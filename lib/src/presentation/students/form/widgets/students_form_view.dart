import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/entities/student.dart';
import 'discard_dialog.dart';
import 'student_name_input.dart';
import 'student_tile.dart';

class StudentsFormView extends StatelessWidget {
  const StudentsFormView({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // Remove keyboard before exiting
        FocusScope.of(context).unfocus();

        final bool? discardPressed = await showDialog<bool>(
          context: context,
          builder: (_) => const DiscardDialog(),
        );

        return discardPressed ?? false;
      },
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              pinned: true,
              titleSpacing: 0,
              title: Text(title),
              titleTextStyle: Theme.of(context).textTheme.titleMedium,
              actions: [
                TextButton(
                  child: const Text('Salvar'),
                  onPressed: () => context
                      .read<StudentsFormBloc>()
                      .add(const StudentsFormEvent.submitted()),
                ),
                const SizedBox(width: 8),
              ],
              bottom: const PreferredSize(
                preferredSize: Size(double.infinity, 48),
                child: StudentNameInput(),
              ),
            ),
            const StudentsFormBody(),
          ],
        ),
      ),
    );
  }
}

class StudentsFormBody extends StatelessWidget {
  const StudentsFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTileTheme(
      data: theme.listTileTheme.copyWith(
        dense: true,
        horizontalTitleGap: 0,
        contentPadding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
        selectedColor: theme.colorScheme.primary,
        selectedTileColor: theme.colorScheme.primaryContainer,
      ),
      child: BlocBuilder<StudentsFormBloc, StudentsFormState>(
        buildWhen: (p, c) => p.students != c.students,
        builder: (BuildContext context, StudentsFormState state) {
          final List<Student> students = state.students;

          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: students.length,
              (context, int index) {
                final student = students[index];

                final tile = StudentTile(
                  key: Key(student.id),
                  student: student,
                );

                if (index.isOdd) {
                  return tile;
                }

                return ColoredBox(
                  color: theme.colorScheme.surfaceVariant.withOpacity(.3),
                  child: tile,
                );
              },
            ),
          );
        },
      ),
    );
  }
}
