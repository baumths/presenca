import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';
import '../../../domain/attendance.dart';
import '../../../domain/student.dart';
import '../../../infrastructure/adapters/file_picker_adapter.dart';
import '../common/discipline_aggregate.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class DisciplineFormBloc
    extends Bloc<DisciplineFormEvent, DisciplineFormState> {
  DisciplineFormBloc({
    required DisciplinesRepository disciplinesRepository,
    required AttendancesRepository attendancesRepository,
    required StudentsRepository studentsRepository,
    required FilePickerAdapter filePicker,
  })  : _disciplinesRepository = disciplinesRepository,
        _attendancesRepository = attendancesRepository,
        _studentsRepository = studentsRepository,
        _filePicker = filePicker,
        super(DisciplineFormState.initial()) {
    on<DisciplineFormEvent>(_onEvent);
  }

  final DisciplinesRepository _disciplinesRepository;
  final AttendancesRepository _attendancesRepository;
  final StudentsRepository _studentsRepository;
  final FilePickerAdapter _filePicker;

  Future<void> _onEvent(
    DisciplineFormEvent event,
    Emitter<DisciplineFormState> emit,
  ) {
    return switch (event) {
      DisciplineFormStarted event => _onStarted(event, emit),
      DisciplineFormNameChanged event => _onNameChanged(event, emit),
      DisciplineFormArchivePressed event => _onArchivePressed(event, emit),
      DisciplineFormImportPressed event => _onImportPressed(event, emit),
      DisciplineFormImportReset() => _onImportReset(emit),
      DisciplineFormSubmitted event => _onSubmitted(event, emit),
    };
  }

  Future<void> _onStarted(
    DisciplineFormStarted event,
    Emitter<DisciplineFormState> emit,
  ) async {
    final Discipline? editingDiscipline = event.editingDiscipline;

    if (editingDiscipline == null) {
      return;
    }

    emit(state.copyWith(
      discipline: editingDiscipline,
      isEditing: true,
      saveFailureOrSuccessOption: const None(),
    ));
  }

  Future<void> _onNameChanged(
    DisciplineFormNameChanged event,
    Emitter<DisciplineFormState> emit,
  ) {
    emit(state.copyWith(
      discipline: state.discipline.copyWith(name: event.name.trim()),
      saveFailureOrSuccessOption: const None(),
    ));
    return Future.value();
  }

  Future<void> _onArchivePressed(
    DisciplineFormArchivePressed event,
    Emitter<DisciplineFormState> emit,
  ) {
    emit(state.copyWith(
      discipline: state.discipline.copyWith(
        isArchived: !state.discipline.isArchived,
      ),
    ));
    return Future.value();
  }

  Future<void> _onImportPressed(
    DisciplineFormImportPressed event,
    Emitter<DisciplineFormState> emit,
  ) async {
    if (state.isEditing) {
      // Importing is disabled when editing a discipline
      return;
    }

    emit(state.copyWith(
      importResult: const DisciplineImportLoading(),
    ));

    final table = await _filePicker.pickCsv();

    if (table.isEmpty) {
      emit(state.copyWith(
        importResult: const DisciplineImportInitial(),
      ));
      return;
    }

    final result = DisciplineAggregate.parseCsv(state.discipline, table);

    switch (result) {
      case (final failure?, null):
        final message = switch (failure) {
          InvalidTableFormat() => 'Formato de tabela inválido.',
          InvalidAttendanceDateFormat failure =>
            'Falha ao interpretar data e hora de chamada. '
                'Linha 1, Coluna ${failure.column + 1}:\n'
                'Formato recebido: "${failure.actual}"\n'
                'Formato esperado: "DD/MM/AAAA HH:MM"',
        };

        emit(state.copyWith(
          importResult: DisciplineImportFailure(message),
        ));

      case (null, final disciplineAggregate?):
        emit(state.copyWith(
          importResult: DisciplineImportSuccess(
            students: disciplineAggregate.students,
            attendances: disciplineAggregate.attendances,
          ),
        ));

      case (null, null):
        assert(false, 'Unreachable');
        return;
    }
  }

  Future<void> _onImportReset(Emitter<DisciplineFormState> emit) {
    emit(state.copyWith(
      importResult: const DisciplineImportInitial(),
    ));
    return Future.value();
  }

  Future<void> _onSubmitted(
    DisciplineFormSubmitted event,
    Emitter<DisciplineFormState> emit,
  ) async {
    Either<DisciplineFailure, Unit>? failureOrSuccess;

    final discipline = state.discipline;

    if (discipline.name.isNotEmpty) {
      failureOrSuccess = await _disciplinesRepository.save(discipline);

      // TODO: handle [StudentFailure] and [AttendanceFailure]
      await failureOrSuccess.fold(
        (_) => Future.value(null),
        (_) => switch (state.importResult) {
          DisciplineImportSuccess(:final students, :final attendances) => (
              _studentsRepository.save(discipline.id, students),
              _attendancesRepository.save(discipline.id, attendances)
            ).wait,
          _ => Future.value(null),
        },
      );
    }

    emit(state.copyWith(
      discipline: discipline,
      saveFailureOrSuccessOption: optionOf(failureOrSuccess),
    ));
  }
}
