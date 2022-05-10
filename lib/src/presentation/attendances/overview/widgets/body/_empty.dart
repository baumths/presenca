part of 'body.dart';

class EmptyAttendances extends StatelessWidget {
  const EmptyAttendances({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Essa disciplina ainda não possui chamadas.',
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 32),
          PrimaryButton.wide(
            label: 'INICIAR CHAMADA',
            onPressed: () {
              AppRouter.showAttendanceForm(
                context,
                context.read<AttendancesOverviewBloc>().discipline,
              );
            },
          ),
        ],
      ),
    );
  }
}
