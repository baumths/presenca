import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import '../../../../domain/student.dart';
import '../../../../shared/shared.dart';

class AttendeesList extends StatelessWidget {
  const AttendeesList({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      builder: (context, state) {
        final students = state.students;

        if (students.isEmpty) {
          return const EmptyAttendeesList();
        }

        return CheckboxTheme(
          data: theme.checkboxTheme.copyWith(
            fillColor: MaterialStatePropertyAll(theme.colorScheme.primary),
            checkColor: MaterialStatePropertyAll(theme.colorScheme.onPrimary),
          ),
          child: ListView.separated(
            itemCount: students.length,
            padding: AppPadding.allSmall,
            separatorBuilder: (_, __) => const SizedBox(height: 8),
            itemBuilder: (context, index) {
              final student = students[index];

              return AttendeeTile(
                key: Key(student.id),
                student: student,
                attended: state.didStudentAttend(student),
              );
            },
          ),
        );
      },
    );
  }
}

class EmptyAttendeesList extends StatelessWidget {
  const EmptyAttendeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox.expand(
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            borderRadius: kDefaultBorderRadius,
            type: MaterialType.card,
            child: Padding(
              padding: AppPadding.tile,
              child: Text(
                'Essa chamada está vazia',
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.student,
    required this.attended,
  });

  final Student student;
  final bool attended;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CheckboxListTile(
      onChanged: null,
      value: attended,
      selected: attended,
      title: Text(
        student.name,
        style: TextStyle(
          fontSize: 14,
          color: colorScheme.onSurfaceVariant,
        ),
      ),
      contentPadding: const EdgeInsetsDirectional.only(start: 16, end: 8),
      shape: RoundedRectangleBorder(
        side: BorderSide(color: colorScheme.outlineVariant),
        borderRadius: kDefaultBorderRadius,
      ),
      selectedTileColor: colorScheme.surfaceVariant,
      tileColor: colorScheme.surfaceVariant.withOpacity(.3),
    );
  }
}
