import 'package:flutter/material.dart';

import '../../../../../domain/entities/student.dart';
import '../../../../../shared/widgets/buttons/primary_button.dart';
import '../../../bloc/students_overview_bloc.dart';
import '../student_tile.dart';

part '_empty.dart';
part '_loading.dart';
part '_success.dart';

class StudentsOverviewBody extends StatelessWidget {
  const StudentsOverviewBody({
    Key? key,
    required this.state,
  }) : super(key: key);

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
