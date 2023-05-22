part of 'bloc.dart';

sealed class StudentsFormEvent {
  const StudentsFormEvent();
}

class StudentsFormStarted extends StudentsFormEvent {
  const StudentsFormStarted(this.initialStudents);
  final List<Student> initialStudents;
}

class StudentsFormStudentSelected extends StudentsFormEvent {
  const StudentsFormStudentSelected(this.student);
  final Student student;
}

class StudentsFormEditingComplete extends StudentsFormEvent {
  const StudentsFormEditingComplete(this.name);
  final String name;
}

class StudentsFormStudentActiveToggled extends StudentsFormEvent {
  const StudentsFormStudentActiveToggled(this.student);
  final Student student;
}

class StudentsFormStudentDeleted extends StudentsFormEvent {
  const StudentsFormStudentDeleted(this.student);
  final Student student;
}

class StudentsFormSubmitted extends StudentsFormEvent {
  const StudentsFormSubmitted();
}
