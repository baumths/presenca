import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/details/bloc.dart';
import 'attendees_list.dart';

class AttendanceDetailsView extends StatelessWidget {
  const AttendanceDetailsView({super.key, this.scrollController});

  final ScrollController? scrollController;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: CustomScrollView(
        controller: scrollController,
        slivers: const [
          SliverAppBar(
            pinned: true,
            titleSpacing: 0,
            title: AttendanceTitle(),
          ),
          SliverToBoxAdapter(
            child: AttendanceDetailsNote(),
          ),
          SliverPadding(
            padding: EdgeInsets.all(8),
            sliver: AttendeesList(),
          ),
        ],
      ),
    );
  }
}

class AttendanceTitle extends StatelessWidget {
  const AttendanceTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      context.watch<AttendanceDetailsBloc>().state.dateAndTimeDisplay,
      style: const TextStyle(fontSize: 20),
    );
  }
}

class AttendanceDetailsNote extends StatelessWidget {
  const AttendanceDetailsNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final note = context.watch<AttendanceDetailsBloc>().attendance.note;

    if (note.isEmpty) {
      return const SizedBox.shrink();
    }

    return Card(
      elevation: 0,
      margin: const EdgeInsets.all(8),
      color: theme.colorScheme.surfaceVariant.withOpacity(.3),
      shape: RoundedRectangleBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        side: BorderSide(color: theme.colorScheme.outlineVariant),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Text(
              'Anotações',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(note),
          ],
        ),
      ),
    );
  }
}
