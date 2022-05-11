import 'package:flutter/material.dart';

import '../../../../shared/shared.dart';

class AttendeesField extends StatelessWidget {
  const AttendeesField({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.secondaryContainer;

    return DividerTheme(
      data: DividerThemeData(
        color: color,
        thickness: 1,
      ),
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border.all(color: color),
          borderRadius: kDefaultBorderRadius,
        ),
        child: const AttendeesCheckboxList(),
      ),
    );
  }
}

class AttendeesCheckboxList extends StatelessWidget {
  const AttendeesCheckboxList({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: wrap in [BlocBuilder]
    return ListView.separated(
      itemCount: 20,
      separatorBuilder: (_, __) => const Divider(height: 0),
      itemBuilder: (_, int index) {
        // TODO: get student from bloc
        return const AttendeeCheckboxTile();
      },
    );
  }
}

class AttendeeCheckboxTile extends StatelessWidget {
  const AttendeeCheckboxTile({super.key});

  @override
  Widget build(BuildContext context) {
    final selectedColor = Theme.of(context).colorScheme.secondaryContainer;

    return CheckboxListTile(
      dense: true,
      checkColor: selectedColor,
      selectedTileColor: selectedColor,
      contentPadding: AppPadding.tile,
      visualDensity: kVisualDensity,
      shape: const RoundedRectangleBorder(borderRadius: kDefaultBorderRadius),
      title: const Text('Student Name'),
      value: false,
      onChanged: (_) {
        // TODO: dispatch to bloc
      },
    );
  }
}
