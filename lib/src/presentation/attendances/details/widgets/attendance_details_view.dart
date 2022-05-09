import 'package:flutter/material.dart';

import 'attendance_title.dart';
import 'body.dart';

class AttendanceDetailsView extends StatelessWidget {
  const AttendanceDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surfaceVariant,
      appBar: AppBar(
        titleSpacing: 0,
        title: const AttendanceTitle(),
      ),
      body: const AttendanceDetailsBody(),
    );
  }
}
