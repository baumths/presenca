import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/form/bloc.dart';
import '../../../../domain/entities/attendee.dart';
import '../../../../shared/shared.dart';

class AttendeesField extends StatelessWidget {
  const AttendeesField({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;

    return DividerTheme(
      data: DividerThemeData(color: color),
      child: Material(
        child: DecoratedBox(
          decoration: BoxDecoration(
            border: Border.all(color: color),
          ),
          child: const AttendeesCheckboxList(),
        ),
      ),
    );
  }
}

class AttendeesCheckboxList extends StatelessWidget {
  const AttendeesCheckboxList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceFormBloc, AttendanceFormState>(
      builder: (context, state) {
        if (state.attendees.isEmpty) {
          return const Center(
            child: Text('A lista de alunos está vazia.'),
          );
        }

        return ListView.separated(
          itemCount: state.attendees.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (_, int index) {
            final attendee = state.attendees[index];

            return AttendeeCheckboxTile(
              key: Key(attendee.studentId),
              attendee: attendee,
            );
          },
        );
      },
    );
  }
}

class AttendeeCheckboxTile extends StatelessWidget {
  const AttendeeCheckboxTile({
    super.key,
    required this.attendee,
  });

  final Attendee attendee;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return CheckboxListTile(
      dense: true,
      contentPadding: AppPadding.allSmall,
      controlAffinity: ListTileControlAffinity.leading,
      visualDensity: VisualDensity.compact,
      activeColor: colorScheme.primary,
      checkColor: colorScheme.onPrimary,
      selectedTileColor: colorScheme.primary.withOpacity(.1),
      title: Text(attendee.name),
      value: attendee.attended,
      selected: attendee.attended,
      onChanged: (_) => context
          .read<AttendanceFormBloc>()
          .add(AttendanceFormAttendeePressed(attendee)),
    );
  }
}
