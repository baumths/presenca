import 'package:flutter/material.dart';

import '../../domain/entities/discipline.dart';
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
    Navigator.of(context).push(
      DisciplineFormPage.route(editingDiscipline),
    );
  }

  static void popUntilDisciplinesOverview(BuildContext context) {
    Navigator.of(context).popUntil(
      (route) => route.settings.name == kDisciplinesOverviewRouteName,
    );
  }
}
