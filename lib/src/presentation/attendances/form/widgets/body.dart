import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'attendees_field.dart';
import 'date_and_time_field.dart';
import 'note.dart';

class AttendanceFormBody extends StatelessWidget {
  const AttendanceFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: AppPadding.allSmall,
      child: Column(
        children: [
          ActionsBar(),
          SizedBox(height: 8),
          Expanded(
            child: AttendeesField(),
          ),
        ],
      ),
    );
  }
}

class ActionsBar extends StatelessWidget {
  const ActionsBar({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 40,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(flex: 3, child: DateSelector()),
          SizedBox(width: 8),
          Expanded(flex: 2, child: TimeSelector()),
          SizedBox(width: 8),
          AttendanceFormNote(),
        ],
      ),
    );
  }
}
