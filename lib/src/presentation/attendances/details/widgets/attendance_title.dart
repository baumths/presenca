import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';

class AttendanceTitle extends StatelessWidget {
  const AttendanceTitle({
    super.key,
    this.style,
  });

  final TextStyle? style;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      buildWhen: (p, c) {
        return p.formattedAttendanceDate != c.formattedAttendanceDate;
      },
      builder: (_, state) {
        return Text(
          state.formattedAttendanceDate,
          style: style,
        );
      },
    );
  }
}
