import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class DisciplineFormBloc
    extends Bloc<DisciplineFormEvent, DisciplineFormState> {
  DisciplineFormBloc({
    required DisciplinesRepository disciplinesRepository,
  })  : _disciplinesRepository = disciplinesRepository,
        super(DisciplineFormState.initial()) {
    on<DisciplineFormEvent>(_onEvent);
  }

  final DisciplinesRepository _disciplinesRepository;

  Future<void> _onEvent(
    DisciplineFormEvent event,
    Emitter<DisciplineFormState> emit,
  ) {
    return switch (event) {
      DisciplineFormStarted event => _onStarted(event, emit),
      DisciplineFormNameChanged event => _onNameChanged(event, emit),
      DisciplineFormArchivePressed event => _onArchivePressed(event, emit),
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

    emit(
      state.copyWith(
        discipline: editingDiscipline,
        isEditing: true,
        saveFailureOrSuccessOption: const None(),
      ),
    );
  }

  Future<void> _onNameChanged(
    DisciplineFormNameChanged event,
    Emitter<DisciplineFormState> emit,
  ) async {
    final String name = event.name.trim();

    emit(
      state.copyWith(
        discipline: state.discipline.copyWith(name: name),
        saveFailureOrSuccessOption: const None(),
      ),
    );
  }

  Future<void> _onArchivePressed(
    DisciplineFormArchivePressed event,
    Emitter<DisciplineFormState> emit,
  ) async {
    emit(state.copyWith(
      discipline: state.discipline.copyWith(
        isArchived: !state.discipline.isArchived,
      ),
    ));
  }

  Future<void> _onSubmitted(
    DisciplineFormSubmitted event,
    Emitter<DisciplineFormState> emit,
  ) async {
    Either<DisciplineFailure, Unit>? failureOrSuccess;

    final discipline = state.discipline;

    if (discipline.name.isNotEmpty) {
      failureOrSuccess = await _disciplinesRepository.save(discipline);
    }

    emit(
      state.copyWith(
        discipline: discipline,
        saveFailureOrSuccessOption: optionOf(failureOrSuccess),
      ),
    );
  }
}
