part of 'body.dart';

class EmptyAttendances extends StatelessWidget {
  const EmptyAttendances({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        children: [
          const Spacer(flex: 8),
          const Text(
            'Essa disciplina ainda não possui chamadas.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 24),
          TextButton(
            style: TextButton.styleFrom(
              backgroundColor: colorScheme.secondaryContainer,
              textStyle: TextStyle(color: colorScheme.onSecondaryContainer),
            ),
            onPressed: () {
              AppRouter.showAttendanceForm(
                context,
                context.read<AttendancesOverviewBloc>().discipline,
              );
            },
            child: const Text('Iniciar Chamada'),
          ),
          const Spacer(flex: 2),
        ],
      ),
    );
  }
}
