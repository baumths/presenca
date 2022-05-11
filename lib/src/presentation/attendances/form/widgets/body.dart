import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';
import 'attendees_field.dart';
import 'date_and_time_field.dart';

class AttendanceFormBody extends StatelessWidget {
  const AttendanceFormBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppPadding.allSmall,
      child: Column(
        children: const [
          DateAndTimeField(),
          SizedBox(height: 8),
          Expanded(
            child: AttendeesField(),
          ),
        ],
      ),
    );
  }
}
