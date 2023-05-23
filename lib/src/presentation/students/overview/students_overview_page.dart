import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/overview/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../domain/repositories/students_repository.dart';
import '../../app/router.dart';
import 'widgets/student_tile.dart';

class StudentsOverviewPage extends StatelessWidget {
  const StudentsOverviewPage({super.key, required this.discipline});

  final Discipline discipline;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsOverviewBloc>(
      create: (BuildContext context) {
        final bloc = StudentsOverviewBloc(
          discipline: discipline,
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(const StudentsOverviewStarted());
      },
      child: const StudentsOverviewView(),
    );
  }
}

class StudentsOverviewView extends StatelessWidget {
  const StudentsOverviewView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsOverviewBloc, StudentsOverviewState>(
      builder: (context, state) => switch (state) {
        StudentsOverviewInitial() => const _EmptyStudents(),
        StudentsOverviewLoadInProgress() => const _LoadingStudents(),
        StudentsOverviewLoadSuccess state => ListView.separated(
            padding: const EdgeInsets.all(8),
            itemCount: state.students.length,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (BuildContext context, int index) {
              final student = state.students[index];

              return StudentTile(
                key: Key(student.id),
                student: student,
              );
            },
          ),
      },
    );
  }
}

class _EmptyStudents extends StatelessWidget {
  const _EmptyStudents();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 8),
          const Text(
            'Essa disciplina ainda não possui alunos.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          FilledButton.tonal(
            child: const Text('Cadastrar Alunos'),
            onPressed: () {
              final bloc = context.read<StudentsOverviewBloc>();
              AppRouter.showStudentsForm(context, bloc.discipline);
            },
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}

class _LoadingStudents extends StatelessWidget {
  const _LoadingStudents();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Buscando alunos...'),
          ],
        ),
      ),
    );
  }
}
