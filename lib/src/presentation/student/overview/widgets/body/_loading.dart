part of 'body.dart';

class _LoadingStudent extends StatelessWidget {
  const _LoadingStudent();

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
            Text('Carregando detalhes do(a) aluno(a)...'),
          ],
        ),
      ),
    );
  }
}
