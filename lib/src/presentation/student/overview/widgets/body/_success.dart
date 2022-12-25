part of 'body.dart';

class StudentOverview extends StatelessWidget {
  const StudentOverview({
    super.key,
    required this.student,
    required this.attendees,
  });

  final Student student;
  final List<Attendee> attendees;

  @override
  Widget build(BuildContext context) {
    final int total = attendees.length;
    final int count = attendees.where((entry) => entry.attended).length;
    final int frequency = total == 0 ? 0 : (count / total * 100).round();

    final String locale = context.l10n.localeName;
    final DateFormat dateFormatter = DateFormat('MMMd', locale);
    final DateFormat timeFormatter = DateFormat('HH:mm', locale);

    return Column(
      children: [
        ListTile(
          title: Text(student.name),
          subtitle: Text(
            'Frequência $count/$total ($frequency%)',
            style: const TextStyle(fontWeight: FontWeight.w500),
          ),
        ),
        Expanded(
          child: GridView.builder(
            padding: AppPadding.allMedium,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              mainAxisExtent: 80,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 1,
            ),
            itemCount: attendees.length,
            itemBuilder: (BuildContext context, int index) {
              final Attendee attendee = attendees[index];

              return AttendeeTile(
                date: dateFormatter.format(attendee.date),
                time: timeFormatter.format(attendee.date),
                attended: attendee.attended,
              );
            },
          ),
        ),
      ],
    );
  }
}

class AttendeeTile extends StatelessWidget {
  const AttendeeTile({
    super.key,
    required this.date,
    required this.time,
    required this.attended,
  });

  final String date;
  final String time;
  final bool attended;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final bool lightMode = theme.brightness == Brightness.light;

    final Color accentColor;
    Color backgroundColor = theme.colorScheme.surfaceVariant;

    if (attended) {
      accentColor = Colors.green;
      if (lightMode) {
        backgroundColor = backgroundColor.withGreen(255);
      }
    } else {
      accentColor = Colors.red;
      if (lightMode) {
        backgroundColor = backgroundColor.withRed(255);
      }
    }

    return Card(
      shape: kDefaultShapeBorder.copyWith(
        borderRadius: (kDefaultBorderRadius / 2).copyWith(
          topLeft: Radius.zero,
          topRight: Radius.zero,
        ),
      ),
      color: backgroundColor,
      elevation: 0,
      child: DecoratedBox(
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(color: accentColor, width: 3),
          ),
        ),
        child: Padding(
          padding: AppPadding.allSmall,
          child: DefaultTextStyle(
            style: TextStyle(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(child: Text(date)),
                Text(
                  time,
                  style: const TextStyle(fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
