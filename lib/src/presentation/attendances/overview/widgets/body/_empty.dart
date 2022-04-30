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
          const Spacer(flex: 2),
          const Text(
            'Essa disciplina ainda não possui chamadas.',
            textAlign: TextAlign.center,
          ),
          const Spacer(flex: 2),
          PrimaryButton.wide(
            label: 'INICIAR CHAMADA',
            onPressed: () {
              // TODO: create new attendance
            },
          ),
          const Spacer(flex: 1),
        ],
      ),
    );
  }
}
