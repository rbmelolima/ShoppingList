import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shoppinglist/main/routes/routes.dart';
import 'package:shoppinglist/ui/style/style.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sua lista de compras inteligente!',
      theme: defaultTheme(),
      routes: AppRoutes.mapOfRoutes,
    );
  }
}
