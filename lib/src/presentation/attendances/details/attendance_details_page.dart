import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../application/attendances/details/bloc.dart';
import 'widgets/attendance_details_view.dart';

class AttendanceDetailsPage extends StatelessWidget {
  const AttendanceDetailsPage({
    super.key,
    required this.bloc,
    this.scrollController,
  });

  final AttendanceDetailsBloc bloc;
  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: bloc,
      child: AttendanceDetailsView(
        scrollController: scrollController,
      ),
    );
  }
}
