import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';

// TODO: show attendance.note
class AttendanceDetailsBody extends StatelessWidget {
  const AttendanceDetailsBody({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return BlocBuilder<AttendanceDetailsBloc, AttendanceDetailsState>(
      builder: (context, state) {
        if (state.students.isEmpty) {
          // TODO: show empty message
          return const SizedBox();
        }

        return ListView.separated(
          itemCount: state.students.length,
          separatorBuilder: (_, __) => const Divider(height: 0),
          itemBuilder: (context, index) {
            final student = state.students[index];

            return ListTile(
              dense: true,
              title: Text(student.name),
              trailing: Checkbox(
                onChanged: null,
                value: state.didStudentAttend(student),
                fillColor: MaterialStateColor.resolveWith(
                  (_) => colorScheme.primary,
                ),
              ),
            );
          },
        );
      },
    );
  }
}
