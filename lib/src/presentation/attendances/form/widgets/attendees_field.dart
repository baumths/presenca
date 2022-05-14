import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/form/bloc.dart';
import '../../../../shared/shared.dart';

class AttendeesField extends StatelessWidget {
  const AttendeesField({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;

    return DividerTheme(
      data: DividerThemeData(
        color: color,
        thickness: 1,
      ),
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
        return ListView.separated(
          itemCount: state.attendees.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (_, int index) {
            final attendee = state.attendees[index];

            return AttendeeCheckboxTile(
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
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    final checkColor = theme.colorScheme.onPrimary;

    return CheckboxListTile(
      dense: true,
      checkColor: checkColor,
      selectedTileColor: color.withOpacity(.1),
      activeColor: color,
      contentPadding: AppPadding.allSmall,
      visualDensity: kVisualDensity,
      title: Text(attendee.student.name),
      selected: attendee.attended,
      value: attendee.attended,
      controlAffinity: ListTileControlAffinity.leading,
      onChanged: (_) {
        context
            .read<AttendanceFormBloc>()
            .add(AttendanceFormEvent.attendeePressed(attendee));
      },
    );
  }
}
