import 'package:flutter/material.dart';

import '../../../../domain/student.dart';
import 'student_name_input.dart';
import 'student_tile.dart';

class StudentsFormBody extends StatelessWidget {
  const StudentsFormBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const StudentNameInput(),
        Expanded(
          child: ListView.separated(
            itemCount: 100,
            separatorBuilder: (_, __) => const Divider(height: 0),
            itemBuilder: (BuildContext context, int index) {
              return StudentTile(
                student: Student(
                  id: '$index',
                  name: 'Aluno $index',
                  disciplineId: '',
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
