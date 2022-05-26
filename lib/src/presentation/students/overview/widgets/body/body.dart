import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/students/overview/bloc.dart';
import '../../../../../domain/entities/student.dart';
import '../../../../../shared/shared.dart';
import '../../../../app/router.dart';
import '../student_tile.dart';

part '_empty.dart';
part '_loading.dart';
part '_success.dart';

class StudentsOverviewBody extends StatelessWidget {
  const StudentsOverviewBody({
    super.key,
    required this.state,
  });

  final StudentsOverviewState state;

  @override
  Widget build(BuildContext context) {
    return state.map(
      initial: (_) => const _EmptyStudents(),
      loadInProgress: (_) => const _LoadingStudents(),
      loadSuccess: (StudentsOverviewLoadSuccess state) => StudentsOverview(
        students: state.students,
      ),
    );
  }
}
