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
    return BlocBuilder<StudentsFormBloc, StudentsFormState>(
      builder: (BuildContext context, StudentsFormState state) {
        if (student.active) {
          late Widget tile = _NormalTile(student: student);

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
        }

        return _InactiveTile(student: student);
      },
    );
  }
}

class _NormalTile extends StatelessWidget {
  const _NormalTile({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(student.name),
      trailing: IconButton(
        iconSize: 20,
        splashRadius: 20,
        visualDensity: kVisualDensity,
        tooltip: 'Marcar como Inativo',
        color: Colors.green,
        icon: const Icon(Icons.toggle_on),
        onPressed: () {
          context
              .read<StudentsFormBloc>()
              .add(StudentsFormEvent.activeToggled(student: student));
        },
      ),
      onTap: () {
        context
            .read<StudentsFormBloc>()
            .add(StudentsFormEvent.selected(student: student));
      },
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

class _InactiveTile extends StatelessWidget {
  const _InactiveTile({
    Key? key,
    required this.student,
  }) : super(key: key);

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      dense: true,
      horizontalTitleGap: 0,
      contentPadding: const EdgeInsets.only(left: 16, right: 8),
      title: Text(
        student.name,
        style: const TextStyle(
          fontStyle: FontStyle.italic,
          decoration: TextDecoration.lineThrough,
        ),
      ),
      subtitle: const Text('Inativo'),
      trailing: IconButton(
        iconSize: 20,
        splashRadius: 20,
        visualDensity: kVisualDensity,
        tooltip: 'Marcar como Ativo',
        icon: const Icon(Icons.toggle_off),
        onPressed: () {
          context
              .read<StudentsFormBloc>()
              .add(StudentsFormEvent.activeToggled(student: student));
        },
      ),
    );
  }
}
