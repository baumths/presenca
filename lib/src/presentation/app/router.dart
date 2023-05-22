import 'package:flutter/material.dart';

import '../../domain/entities/discipline.dart';
import '../../domain/entities/student.dart';
import '../pages.dart';

abstract class AppRouter {
  static const String kDisciplinesOverviewRouteName = '/disciplines';

  static final Map<String, Widget Function(BuildContext)> routes = {
    kDisciplinesOverviewRouteName: (_) => const DisciplinesOverviewPage(),
  };

  static const String initialRoute = kDisciplinesOverviewRouteName;

  // Edit a dicispline, if `editingDiscipline == null` creates a new discipline.
  static void showDisciplineForm(
    BuildContext context,
    Discipline? editingDiscipline,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: (_) => DisciplineFormPage(
        editingDiscipline: editingDiscipline,
      ),
    );
  }

  static void showDisciplineDetails(
    BuildContext context,
    Discipline discipline,
  ) {
    Navigator.of(context).push(
      DisciplineDetailsPage.route(discipline),
    );
  }

  static void showStudentsForm(
    BuildContext context,
    Discipline discipline, {
    List<Student> initialStudents = const <Student>[],
  }) {
    Navigator.of(context).push(
      StudentsFormPage.route(
        discipline: discipline,
        initialStudents: initialStudents,
      ),
    );
  }

  static void showAttendanceForm(
    BuildContext context,
    Discipline discipline,
  ) {
    Navigator.of(context).push(
      AttendanceFormPage.route(discipline),
    );
  }

  static void showStudentOverview(BuildContext context, Student student) {
    Navigator.of(context).push(StudentOverviewPage.route(student));
  }

  static void showThemeSettings(BuildContext context) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      builder: ThemeSettingsView.bottomSheetBuilder,
    );
  }
}
