import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import '../../../../shared/shared.dart';
import 'attendees_list.dart';

class AttendanceDetailsBody extends StatelessWidget {
  const AttendanceDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: const [
        AttendanceDetailsNote(),
        Expanded(
          child: AttendeesList(),
        ),
      ],
    );
  }
}

class AttendanceDetailsNote extends StatelessWidget {
  const AttendanceDetailsNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = context.read<AttendanceDetailsBloc>().attendance.note;

    if (note.isEmpty) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: AppPadding.allSmall.copyWith(bottom: 0),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: kDefaultBorderRadius,
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Padding(
          padding: AppPadding.allMedium,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Anotações',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(note),
            ],
          ),
        ),
      ),
    );
  }
}
