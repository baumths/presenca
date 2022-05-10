import 'package:flutter/material.dart';

import 'body.dart';

class AttendanceFormView extends StatelessWidget {
  const AttendanceFormView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamada'),
        titleSpacing: 0,
      ),
      body: const AttendanceFormBody(),
    );
  }
}
