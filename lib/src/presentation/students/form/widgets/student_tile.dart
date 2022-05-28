import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/students/form/bloc.dart';
import '../../../../domain/student.dart';

class StudentTile extends StatelessWidget {
  const StudentTile({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsFormBloc, StudentsFormState>(
      builder: (BuildContext context, StudentsFormState state) {
        if (student.active) {
          late Widget tile = DefaultStudentTile(student: student);

          state.selectedStudent.fold(
            () {},
            (editingStudent) {
              if (student.id == editingStudent.id) {
                tile = EditingStudentTile(
                  title: student.name,
                );
              }
            },
          );

          return tile;
        }

        return InactiveStudentTile(student: student);
      },
    );
  }
}

class DefaultStudentTile extends StatelessWidget {
  const DefaultStudentTile({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.name),
      trailing: IconButton(
        splashRadius: 24,
        color: Colors.green,
        tooltip: 'Marcar como Inativo',
        icon: const Icon(Icons.toggle_on),
        onPressed: () => context
            .read<StudentsFormBloc>()
            .add(StudentsFormEvent.activeToggled(student)),
      ),
      onTap: () => context
          .read<StudentsFormBloc>()
          .add(StudentsFormEvent.selected(student)),
    );
  }
}

class EditingStudentTile extends StatelessWidget {
  const EditingStudentTile({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      selected: true,
      title: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text('Editando'),
      trailing: const Padding(
        padding: EdgeInsets.only(right: 8),
        child: Icon(Icons.edit_rounded),
      ),
    );
  }
}

class InactiveStudentTile extends StatelessWidget {
  const InactiveStudentTile({
    super.key,
    required this.student,
  });

  final Student student;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        student.name,
        style: const TextStyle(
          decoration: TextDecoration.lineThrough,
        ),
      ),
      subtitle: const Text('Inativo'),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            splashRadius: 24,
            color: Theme.of(context).colorScheme.error,
            tooltip: 'Remover',
            icon: const Icon(Icons.delete),
            onPressed: () => context
                .read<StudentsFormBloc>()
                .add(StudentsFormEvent.deletePressed(student)),
          ),
          IconButton(
            splashRadius: 24,
            tooltip: 'Marcar como Ativo',
            icon: const Icon(Icons.toggle_off),
            onPressed: () => context
                .read<StudentsFormBloc>()
                .add(StudentsFormEvent.activeToggled(student)),
          ),
        ],
      ),
    );
  }
}
