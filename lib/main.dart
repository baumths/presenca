import 'package:flutter/widgets.dart';

import 'src/bootstrap.dart';

Future<void> main() async {
  final Widget app = await createAndInitializeApp();
  runApp(app);
}
