import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../application/attendances/form/bloc.dart';
import '../../../../shared/shared.dart';

class AttendanceFormNote extends StatelessWidget {
  const AttendanceFormNote({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;

    return Material(
      color: theme.colorScheme.secondaryContainer,
      borderRadius: kDefaultBorderRadius,
      child: InkWell(
        borderRadius: kDefaultBorderRadius,
        splashColor: color.withOpacity(.1),
        child: SizedBox.square(
          dimension: 40,
          child: BlocBuilder<AttendanceFormBloc, AttendanceFormState>(
            buildWhen: (p, c) => p.attendance.note != c.attendance.note,
            builder: (context, state) {
              final Widget icon = Icon(
                Icons.text_snippet_rounded,
                color: color,
              );

              if (state.attendance.note.isEmpty) {
                return icon;
              }

              return TweenAnimationBuilder(
                duration: const Duration(milliseconds: 500),
                curve: Curves.fastOutSlowIn,
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (_, double scale, Widget? child) {
                  return Transform.scale(
                    scale: scale,
                    child: child,
                  );
                },
                child: Stack(
                  children: [
                    Positioned.fill(child: icon),
                    const Positioned(
                      bottom: 8,
                      right: 8,
                      height: 8,
                      width: 8,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        onTap: () async {
          final bloc = context.read<AttendanceFormBloc>();

          final note = await showDialog<String>(
            context: context,
            builder: (_) => NotesDialog(
              initialNote: bloc.state.attendance.note,
            ),
          );
          if (note != null) {
            bloc.add(AttendanceFormNoteChanged(note));
          }
        },
      ),
    );
  }
}

class NotesDialog extends StatefulWidget {
  const NotesDialog({
    super.key,
    required this.initialNote,
  });

  final String initialNote;

  @override
  State<NotesDialog> createState() => _NotesDialogState();
}

class _NotesDialogState extends State<NotesDialog> {
  late final TextEditingController _textEditingController;
  String get text => _textEditingController.text;

  @override
  void initState() {
    super.initState();
    _textEditingController = TextEditingController(
      text: widget.initialNote,
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Dialog(
      backgroundColor: theme.colorScheme.background,
      shape: kDefaultShapeBorder,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: AppPadding.allMedium,
            child: Text(
              'Anotações',
              style: theme.textTheme.titleLarge,
            ),
          ),
          TextField(
            minLines: 4,
            maxLines: 10,
            autofocus: true,
            controller: _textEditingController,
            style: const TextStyle(fontWeight: FontWeight.w400),
            decoration: InputDecoration(
              filled: true,
              border: InputBorder.none,
              fillColor: theme.colorScheme.surfaceVariant,
              contentPadding: const EdgeInsets.fromLTRB(16, 8, 0, 8),
              hintText: 'digite aqui...',
            ),
          ),
          ButtonBar(
            children: [
              TextButton(
                child: const Text('Cancelar'),
                onPressed: () => Navigator.pop(context, null),
              ),
              TextButton(
                child: const Text('Salvar'),
                onPressed: () => Navigator.pop(context, text),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
