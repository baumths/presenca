part of 'body.dart';

class _LoadingDisciplines extends StatelessWidget {
  const _LoadingDisciplines({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: const [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Buscando disciplinas...'),
          ],
        ),
      ),
    );
  }
}
