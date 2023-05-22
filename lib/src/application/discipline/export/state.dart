part of 'cubit.dart';

sealed class DisciplineExportState {
  const DisciplineExportState();

  bool get isLoading => this is DisciplineExportLoadInProgress;
}

class DisciplineExportInitial extends DisciplineExportState {
  const DisciplineExportInitial();
}

class DisciplineExportLoadInProgress extends DisciplineExportState {
  const DisciplineExportLoadInProgress();
}

class DisciplineExportLoadSuccess extends DisciplineExportState {
  const DisciplineExportLoadSuccess({required this.snackBarMessage});
  final String? snackBarMessage;
}
