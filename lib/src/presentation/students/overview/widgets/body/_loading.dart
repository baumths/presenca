part of 'body.dart';

class _LoadingStudents extends StatelessWidget {
  const _LoadingStudents();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.0),
      child: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 20),
            Text('Buscando alunos...'),
          ],
        ),
      ),
    );
  }
}
