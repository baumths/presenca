part of 'body.dart';

class LoadingAttendances extends StatelessWidget {
  const LoadingAttendances({super.key});

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
            Text('Buscando chamadas...'),
          ],
        ),
      ),
    );
  }
}
