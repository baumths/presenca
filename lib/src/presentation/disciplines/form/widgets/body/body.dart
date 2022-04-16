import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../application/discipline/form/bloc.dart';
import '../../../../../shared/shared.dart';

part '_name_field.dart';
part '_submit_button.dart';

class DisciplineFormBody extends StatelessWidget {
  const DisciplineFormBody({
    Key? key,
    required this.state,
  }) : super(key: key);

  final DisciplineFormState state;

  @override
  Widget build(BuildContext context) {
    final EdgeInsets viewInsets = MediaQuery.of(context).viewInsets;
    final bottomPadding = viewInsets.bottom + 24.0;

    return Padding(
      padding: EdgeInsets.fromLTRB(24.0, 24.0, 24.0, bottomPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: const [
          _NameFormField(),
          _SubmitDisciplineButton(),
        ],
      ),
    );
  }
}
