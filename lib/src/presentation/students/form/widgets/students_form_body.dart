import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/student.dart';
import 'student_name_input.dart';
import 'student_tile.dart';

class StudentsFormBody extends StatelessWidget {
  const StudentsFormBody({super.key});

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
        const Expanded(
          child: StudentsList(),
        ),
      ],
    );
  }
}

class StudentsList extends StatelessWidget {
  const StudentsList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        dense: true,
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.only(left: 16, right: 8),
        selectedColor: theme.colorScheme.primary,
        selectedTileColor: theme.colorScheme.primaryContainer,
      ),
      child: BlocBuilder<StudentsFormBloc, StudentsFormState>(
        buildWhen: (p, c) => p.students != c.students,
        builder: (BuildContext context, StudentsFormState state) {
          final List<Student> students = state.students;

          return ListView.separated(
            itemCount: students.length,
            separatorBuilder: (_, __) => Divider(
              height: 0,
              color: theme.colorScheme.outline.withOpacity(.5),
            ),
            itemBuilder: (_, int index) => StudentTile(
              student: students[index],
            ),
          );
        },
      ),
    );
  }
}
