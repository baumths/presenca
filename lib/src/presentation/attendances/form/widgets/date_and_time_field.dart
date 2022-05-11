import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../shared/shared.dart';

class DateAndTimeField extends StatelessWidget {
  const DateAndTimeField({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(flex: 3, child: DateSelector()),
        SizedBox(width: 8),
        Expanded(flex: 2, child: TimeSelector()),
      ],
    );
  }
}

class DateSelector extends StatelessWidget {
  const DateSelector({super.key});

  Future<DateTime?> _pickDate(BuildContext context) {
    final now = DateTime.now();
    final firstDate = DateTime(now.year - 10);
    final lastDate = DateTime(now.year + 10);

    return showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: firstDate,
      lastDate: lastDate,
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final date = DateFormat.MMMMd(context.l10n.localeName).format(now);

    return DateOrTimeSelector(
      label: date,
      icon: Icons.edit_calendar_rounded,
      onPressed: () async {
        final date = await _pickDate(context);
        // TODO dispatch to bloc
      },
    );
  }
}

class TimeSelector extends StatelessWidget {
  const TimeSelector({super.key});

  Future<TimeOfDay?> _pickTime(BuildContext context) {
    return showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final time = DateFormat.Hm(context.l10n.localeName).format(now);

    return DateOrTimeSelector(
      label: time,
      icon: Icons.schedule_rounded,
      onPressed: () async {
        final time = await _pickTime(context);
        // TODO dispatch to bloc
      },
    );
  }
}

// TODO: maybe extract to `.../shared`
class DateOrTimeSelector extends StatelessWidget {
  const DateOrTimeSelector({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = theme.colorScheme.primary;
    final backgroundColor = theme.colorScheme.secondaryContainer;

    return Material(
      type: MaterialType.card,
      color: backgroundColor,
      borderRadius: kDefaultBorderRadius,
      child: InkWell(
        onTap: onPressed,
        borderRadius: kDefaultBorderRadius,
        splashColor: color.withOpacity(.1),
        child: Padding(
          padding: AppPadding.allSmall,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(icon, color: color),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: theme.textTheme.titleMedium?.copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
