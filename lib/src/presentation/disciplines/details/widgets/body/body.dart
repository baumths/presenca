import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/details/bloc.dart';
import '../../../../pages.dart';

part '_attendances_tab.dart';
part '_students_tab.dart';

class DisciplineDetailsBody extends StatelessWidget {
  const DisciplineDetailsBody({
    super.key,
    required this.tabController,
  });

  final TabController tabController;

  @override
  Widget build(BuildContext context) {
    return TabBarView(
      controller: tabController,
      children: const [
        StudentsTab(),
        AttendancesTab(),
      ],
    );
  }
}
