import 'package:dartz/dartz.dart';
import 'package:hive/hive.dart';

import '../../domain/attendance.dart';

class AttendancesRepositoryImpl implements AttendancesRepository {
  static const String kAttendancesBoxName = 'attendances';

  const AttendancesRepositoryImpl(
    LazyBox<List<dynamic>> storage,
  ) : _storage = storage;

  static Future<AttendancesRepository> create() async {
    final box = await Hive.openLazyBox<List<dynamic>>(kAttendancesBoxName);
    return AttendancesRepositoryImpl(box);
  }

  final LazyBox<List<dynamic>> _storage;

  @override
  Future<List<Attendance>> find(String disciplineId) async {
    try {
      final List<dynamic>? attendances = await _storage.get(disciplineId);

      if (attendances == null) {
        return <Attendance>[];
      }

      return attendancesFromHive(attendances);
    } on HiveError {
      return <Attendance>[];
    }
  }

  @override
  Future<Either<AttendanceFailure, Unit>> save(
    String disciplineId,
    List<Attendance> attendances,
  ) async {
    try {
      await _storage.put(disciplineId, attendancesToHive(attendances));
      return const Right(unit);
    } on HiveError {
      return const Left(AttendanceFailure.unableToUpdate);
    }
  }

  @override
  Stream<List<Attendance>> watch(String disciplineId) async* {
    yield await find(disciplineId);

    await for (final BoxEvent _ in _storage.watch(key: disciplineId)) {
      yield await find(disciplineId);
    }
  }

  List<String> attendancesToHive(List<Attendance> attendances) {
    return attendances.map((a) => a.toJson()).toList();
  }

  List<Attendance> attendancesFromHive(List<dynamic> hiveList) {
    return <Attendance>[
      for (final dynamic json in hiveList) Attendance.fromJson(json as String),
    ];
  }
}
