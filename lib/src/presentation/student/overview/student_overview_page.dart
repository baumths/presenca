import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/student/overview/bloc.dart';
import '../../../domain/student.dart';
import '../../../infrastructure/usecases/find_student_attendances.dart';
import 'widgets/student_overview_view.dart';

class StudentOverviewPage extends StatelessWidget {
  const StudentOverviewPage({
    super.key,
    required this.student,
  });

  final Student student;

  static Route<void> route(Student student) {
    return MaterialPageRoute(
      builder: (_) => StudentOverviewPage(student: student),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentOverviewBloc>(
      create: (BuildContext context) {
        final bloc = StudentOverviewBloc(
          findStudentAttendances: FindStudentAttendancesUsecase(
            attendancesRepository: RepositoryProvider.of(context),
          ),
        );
        return bloc..add(StudentOverviewEvent.started(student));
      },
      child: const StudentOverviewView(),
    );
  }
}
