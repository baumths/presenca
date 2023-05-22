import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:dartz/dartz.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/discipline.dart';
import '../../../domain/student.dart';
import '../../../infrastructure/adapters.dart';

part 'bloc.freezed.dart';
part 'event.dart';
part 'state.dart';

class StudentsImportBloc
    extends Bloc<StudentsImportEvent, StudentsImportState> {
  StudentsImportBloc({
    required this.discipline,
    required FilePickerAdapter filePicker,
  })  : _filePicker = filePicker,
        super(StudentsImportState.initial()) {
    on<StudentsImportEvent>(_onEvent, transformer: restartable());
  }

  final Discipline discipline;
  final FilePickerAdapter _filePicker;

  Future<void> _onEvent(
    StudentsImportEvent event,
    Emitter<StudentsImportState> emit,
  ) {
    return switch (event) {
      StudentsImportPickFilePressed event => _onPickFilePressed(event, emit),
    };
  }

  Future<void> _onPickFilePressed(
    StudentsImportPickFilePressed event,
    Emitter<StudentsImportState> emit,
  ) async {
    emit(
      state.copyWith(
        isLoading: true,
        students: const None(),
      ),
    );

    // TODO: wrap in try/catch
    // StudentsImportFailure.unableToReadFile
    final List<List<String>> table = await _filePicker.pickCsv();

    if (table.isEmpty) {
      // TODO: show snackbar
      // StudentsImportFailure.emptyFile
      return emit(
        state.copyWith(
          isLoading: false,
          students: const None(),
        ),
      );
    }

    final students = <Student>[];

    for (final List<String> row in table) {
      if (row.isEmpty) continue;

      // TODO(future): let user choose column
      final String name = row[0];

      final Student student = Student.empty().copyWith(
        disciplineId: discipline.id,
        name: name,
      );

      students.add(student);
    }

    emit(
      state.copyWith(
        isLoading: false,
        students: Some(students),
      ),
    );
  }
}
