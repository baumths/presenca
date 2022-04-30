import 'package:flutter/material.dart';

import 'body.dart';

class AttendanceDetailsView extends StatelessWidget {
  const AttendanceDetailsView({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: 0,
        title: Text(title),
      ),
      body: const AttendanceDetailsBody(),
    );
  }
}
