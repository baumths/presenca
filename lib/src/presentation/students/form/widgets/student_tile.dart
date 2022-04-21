import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/student.dart';
import '../../../../shared/shared.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    void dispatch(StudentsFormEvent event) {
      context.read<StudentsFormBloc>().add(event);
    }

    return BlocBuilder<StudentsFormBloc, StudentsFormState>(
      buildWhen: (p, c) {
        return p.selectedStudent != c.selectedStudent ||
            p.deletedStudentIds != c.deletedStudentIds;
      },
      builder: (BuildContext context, StudentsFormState state) {
        if (state.deletedStudentIds.contains(student.id)) {
          return _DeletedTile(
            title: student.name,
            onTap: () => dispatch(StudentsFormEvent.restored(student: student)),
          );
        }

        late Widget tile = _NormalTile(
            title: student.name,
            onTap: () => dispatch(StudentsFormEvent.selected(student: student)),
            onTrailingPressed: () {
              dispatch(StudentsFormEvent.deleted(student: student));
            });

        state.selectedStudent.fold(
          () {},
          (editingStudent) {
            if (student.id == editingStudent.id) {
              tile = _EditingTile(
                title: student.name,
              );
            }
          },
        );

        return tile;
      },
    );
  }
}

class _NormalTile extends StatelessWidget {
  const _NormalTile({
    Key? key,
    required this.title,
    this.onTap,
    this.onTrailingPressed,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;
  final VoidCallback? onTrailingPressed;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: IconButton(
        iconSize: 20,
        splashRadius: 20,
        visualDensity: kVisualDensity,
        icon: const Icon(Icons.delete_rounded),
        onPressed: onTrailingPressed,
      ),
      onTap: onTap,
    );
  }
}

class _EditingTile extends StatelessWidget {
  const _EditingTile({
    Key? key,
    required this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      selected: true,
      selectedColor: theme.colorScheme.primary,
      selectedTileColor: theme.colorScheme.primary.withOpacity(.1),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('Editando'),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.edit_rounded, size: 20),
      ),
    );
  }
}

class _DeletedTile extends StatelessWidget {
  const _DeletedTile({
    Key? key,
    required this.title,
    this.onTap,
  }) : super(key: key);

  final String title;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(
        title,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      selected: true,
      selectedColor: theme.colorScheme.error,
      subtitle: const Text('Mantenha pressionado para restaurar.'),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.restore_from_trash_rounded, size: 20),
      ),
      onLongPress: onTap,
    );
  }
}
