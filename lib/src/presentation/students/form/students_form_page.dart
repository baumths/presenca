import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/students/form/bloc.dart';
import '../../../domain/discipline.dart';
import '../../../domain/student.dart';
import '../../../shared/shared.dart';
import 'widgets/students_form_view.dart';

class StudentsFormPage extends StatelessWidget {
  const StudentsFormPage({
    super.key,
    required this.discipline,
    this.initialStudents = const <Student>[],
  });

  final Discipline discipline;
  final List<Student> initialStudents;

  static Route<void> route({
    required Discipline discipline,
    List<Student> initialStudents = const [],
  }) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => StudentsFormPage(
        discipline: discipline,
        initialStudents: initialStudents,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider<StudentsFormBloc>(
      create: (_) {
        final bloc = StudentsFormBloc(
          discipline: discipline,
          studentsRepository: context.read<StudentsRepository>(),
        );

        return bloc..add(StudentsFormStarted(initialStudents));
      },
      child: BlocListener<StudentsFormBloc, StudentsFormState>(
        listenWhen: (p, c) {
          return p.failureOrSuccessOption != c.failureOrSuccessOption;
        },
        listener: (BuildContext context, StudentsFormState state) {
          state.failureOrSuccessOption.fold(
            () {},
            (either) => either.fold(
              (failure) => switch (failure) {
                StudentFailure.unableToUpdate => SnackBarHelper.showError(
                    context,
                    'Não foi possível salvar lista de alunos.',
                  ),
                _ => null,
              },
              (_) {
                Navigator.pop(context);
                SnackBarHelper.showSuccess(
                  context,
                  'As alterações foram salvas.',
                );
              },
            ),
          );
        },
        child: const Stack(
          children: [
            StudentsFormView(),
            Positioned.fill(child: _Overlay()),
          ],
        ),
      ),
    );
  }
}

class _Overlay extends StatelessWidget {
  const _Overlay();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StudentsFormBloc, StudentsFormState>(
      buildWhen: (p, c) => p.isSaving != c.isSaving,
      builder: (BuildContext context, StudentsFormState state) {
        return IgnorePointer(
          ignoring: !state.isSaving,
          child: Visibility(
            visible: state.isSaving,
            child: ColoredBox(
              color: Colors.black.withOpacity(0.7),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation(Colors.white),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Salvando Lista de Alunos...',
                    style: Theme.of(context)
                        .textTheme
                        .bodyLarge
                        ?.copyWith(color: Colors.white),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
