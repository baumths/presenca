import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:share_plus/share_plus.dart';

import '../../../domain/attendance.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';
import '../../../infrastructure/services.dart';
import 'models/discipline_aggregate.dart';

part 'cubit.freezed.dart';
part 'state.dart';

class DisciplineExportCubit extends Cubit<DisciplineExportState> {
  DisciplineExportCubit({
    required this.discipline,
    required AttendancesRepository attendancesRepository,
    required StudentsRepository studentsRepository,
    required SaveFileService saveFileService,
  })  : _attendancesRepository = attendancesRepository,
        _studentsRepository = studentsRepository,
        _saveFileService = saveFileService,
        super(const DisciplineExportState.initial());

  final Discipline discipline;
  final AttendancesRepository _attendancesRepository;
  final StudentsRepository _studentsRepository;

  final SaveFileService _saveFileService;

  Future<void> exportDiscipline() async {
    emit(const DisciplineExportState.loading());

    final disciplineAggregate = DisciplineAggregate(
      discipline: discipline,
      students: await _studentsRepository.find(discipline.id),
      attendances: await _attendancesRepository.find(discipline.id),
    );

    // TODO: maybe move to another isolate (probably overkill)
    final String fileName = disciplineAggregate.fileName;
    final List<List<String>> fileContent = disciplineAggregate.toCsv();

    final String path = await _saveFileService.saveCsv(
      fileName,
      fileContent,
    );

    await Share.shareFiles(
      [path],
      mimeTypes: ['text/csv'],
      text: fileName,
    );

    emit(const DisciplineExportState.success());
  }
}
