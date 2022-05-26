import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import '../../../../domain/student.dart';
import '../../../../shared/shared.dart';

class AttendeesList extends StatelessWidget {
  const AttendeesList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      builder: (context, state) {
        final students = state.students;

        if (students.isEmpty) {
          return const EmptyAttendeesList();
        }

        return ListView.separated(
          itemCount: students.length,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          padding: AppPadding.allSmall,
          itemBuilder: (context, index) {
            final student = students[index];

            return AttendeeTile(
              key: Key(student.id),
              student: student,
              attended: state.didStudentAttend(student),
            );
          },
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

    final Color color = colorScheme.onTertiaryContainer;
    late Color backgroundColor = colorScheme.tertiaryContainer.withOpacity(.3);
    late IconData icon = Icons.radio_button_off;

    if (attended) {
      backgroundColor = colorScheme.tertiaryContainer;
      icon = Icons.radio_button_on;
    }

    return Material(
      shape: kDefaultShapeBorder,
      color: backgroundColor,
      child: Padding(
        padding: AppPadding.tile,
        child: Row(
          children: [
            Icon(icon, color: color),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                student.name,
                style: TextStyle(
                  fontSize: 14,
                  color: color,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
