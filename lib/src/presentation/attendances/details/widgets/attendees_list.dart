import 'dart:math' as math show max;

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

    return CheckboxTheme(
      data: theme.checkboxTheme.copyWith(
        checkColor: MaterialStatePropertyAll(theme.colorScheme.onSecondary),
        fillColor: MaterialStateProperty.resolveWith(
          (Set<MaterialState> states) {
            if (states.contains(MaterialState.selected)) {
              return theme.colorScheme.secondary;
            }
            return theme.colorScheme.outlineVariant;
          },
        ),
      ),
      child: BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
        builder: (context, state) {
          if (state.students.isEmpty) {
            return const EmptyAttendeesList();
          }

          // TODO: Use SliverList.separated once available on stable
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              childCount: math.max(0, state.students.length * 2 - 1),
              (context, index) {
                final int studentIndex = index ~/ 2;

                if (index.isEven) {
                  final student = state.students[studentIndex];

                  return AttendeeTile(
                    key: Key(student.id),
                    student: student,
                    attended: state.didStudentAttend(student),
                  );
                }

                return const SizedBox(height: 8);
              },
            ),
          );
        },
      ),
    );
  }
}

class EmptyAttendeesList extends StatelessWidget {
  const EmptyAttendeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return const SliverFillRemaining(
      hasScrollBody: false,
      child: Padding(
        padding: EdgeInsets.only(top: 16),
        child: Align(
          alignment: Alignment.topCenter,
          child: Material(
            borderRadius: kDefaultBorderRadius,
            type: MaterialType.card,
            child: Padding(
              padding: EdgeInsets.all(16),
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
        side: BorderSide(
          color: attended ? colorScheme.secondary : colorScheme.outlineVariant,
        ),
        borderRadius: kDefaultBorderRadius,
      ),
      selectedTileColor: colorScheme.surfaceVariant,
      tileColor: colorScheme.surfaceVariant.withOpacity(.3),
    );
  }
}
