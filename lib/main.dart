import 'package:demo_application/app/splash_screen.dart';
import 'package:demo_application/utils/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:provider/provider.dart';

import 'app/provider/providers.dart';
import 'app/theme/theme.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
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
            return Consumer<ChangeThemeProvider>(
                builder: (context, theme, child) {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                title: 'E-commerce App',
                themeMode: theme.isDark ? ThemeMode.dark : ThemeMode.light,
                darkTheme: theme.isDark ? darkTheme : lightTheme,
                theme: theme.isDark ? darkTheme : lightTheme,
                routes: AppRoutes.routes,
                home: const SplashScreen(),
              );
            });
          },
        ));
  }
}
