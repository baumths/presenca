part of 'bloc.dart';

sealed class StudentsOverviewState {
  const StudentsOverviewState();
}

class StudentsOverviewInitial extends StudentsOverviewState {
  const StudentsOverviewInitial();
}

class StudentsOverviewLoadInProgress extends StudentsOverviewState {
  const StudentsOverviewLoadInProgress();
}

class StudentsOverviewLoadSuccess extends StudentsOverviewState {
  const StudentsOverviewLoadSuccess(this.students);
  final List<Student> students;
}
