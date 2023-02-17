import 'package:demo_application/splash_screen.dart';
import 'package:demo_application/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'app/provider/providers.dart';
import 'app/theme/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ChangeThemeProvider()),
          ChangeNotifierProvider(create: (_) => BottomNavProvider()),
          ChangeNotifierProvider(create: (_) => ProductProvider()),
          ChangeNotifierProvider(create: (_) => CartProvider()),
        ],
        child: Builder(
          builder: (context) {
            final theme = Provider.of<ChangeThemeProvider>(context);
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'E-commerce App',
              themeMode: theme.themeMode,
              darkTheme: darkTheme,
              theme: lightTheme,
              routes: AppRoutes.routes,
              home: const SplashScreen(),
            );
          },
        ));
  }
}
