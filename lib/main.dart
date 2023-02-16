import 'package:demo_application/app/data/products_class.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/app.dart';
import 'app/theme/theme.dart';

void main() {
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (BuildContext context) => ProductData(),
      child: MaterialApp(
        title: 'E-commerce App',
        themeMode: ThemeMode.light,
        darkTheme: darkTheme,
        theme: lightTheme,
        home: const App(),
      ),
    );
  }
}
