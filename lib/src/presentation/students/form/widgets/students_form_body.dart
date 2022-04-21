import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/student.dart';
import 'student_name_input.dart';
import 'student_tile.dart';

class StudentsFormBody extends StatelessWidget {
  const StudentsFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Material(
          color: colorScheme.surface,
          child: const Padding(
            padding: EdgeInsets.only(top: 8),
            child: StudentNameInput(),
          ),
        ),
        const Expanded(child: _StudentsList()),
      ],
    );
  }
}

class _StudentsList extends StatelessWidget {
  const _StudentsList({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsFormBloc, StudentsFormState>(
      buildWhen: (p, c) => p.students != c.students,
      builder: (BuildContext context, StudentsFormState state) {
        final List<Student> students = state.students;

        return ListView.separated(
          itemCount: students.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (BuildContext context, int index) {
            return StudentTile(student: students[index]);
          },
        );
      },
    );
  }
}
