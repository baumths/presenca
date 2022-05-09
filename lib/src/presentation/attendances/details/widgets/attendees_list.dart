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
          padding: AppPadding.allSmall,
          separatorBuilder: (_, __) => const SizedBox(height: 4),
          itemBuilder: (context, index) {
            final student = students[index];
            return AttendeeTile(
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
                'Esta chamada está vazia',
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

    late Color backgroundColor = colorScheme.surface;
    late Color color = colorScheme.secondary;
    late IconData icon = Icons.radio_button_off;
    Border? border;
    FontWeight? fontWeight;

    if (attended) {
      fontWeight = FontWeight.w500;
      backgroundColor = colorScheme.surface;
      border = Border.all(color: color, width: 2);
      color = colorScheme.primary;
      icon = Icons.radio_button_on;
    }

    return DecoratedBox(
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: kDefaultBorderRadius / 2,
        border: border,
      ),
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
                  fontWeight: fontWeight,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
