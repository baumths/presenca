part of 'bloc.dart';

sealed class StudentsImportEvent {
  const StudentsImportEvent();
}

class StudentsImportPickFilePressed extends StudentsImportEvent {
  const StudentsImportPickFilePressed();
}
