import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';
import '../../../infrastructure/adapters.dart';
import 'models/discipline_aggregate.dart';

part 'cubit.freezed.dart';
part 'state.dart';

class DisciplineExportCubit extends Cubit<DisciplineExportState> {
  DisciplineExportCubit({
    required this.discipline,
    required AttendancesRepository attendancesRepository,
    required StudentsRepository studentsRepository,
    required FileSaverAdapter fileSaverAdapter,
  })  : _attendancesRepository = attendancesRepository,
        _studentsRepository = studentsRepository,
        _fileSaverAdapter = fileSaverAdapter,
        super(DisciplineExportState.initial());

  final Discipline discipline;
  final AttendancesRepository _attendancesRepository;
  final StudentsRepository _studentsRepository;

  final FileSaverAdapter _fileSaverAdapter;

  Future<void> exportDiscipline() async {
    if (state.isLoading) {
      return;
    }

    emit(
      state.copyWith(
        isLoading: true,
      ),
    );

    final disciplineAggregate = DisciplineAggregate(
      discipline: discipline,
      students: await _studentsRepository.find(discipline.id),
      attendances: await _attendancesRepository.find(discipline.id),
    );

    // TODO: maybe move to another isolate (probably overkill)
    final String fileName = disciplineAggregate.fileName;
    final List<List<String>> fileContent = disciplineAggregate.toCsv();

    final String? path = await _fileSaverAdapter.saveCsv(
      fileName,
      fileContent,
    );

    // TODO:
    if (path == null) {
      // user canceled
    } else {
      // show success feedback
    }

    emit(
      state.copyWith(
        isLoading: false,
      ),
    );
  }
}
