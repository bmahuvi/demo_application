import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import '../theme/theme.dart';

class ChangeThemeProvider extends ChangeNotifier {
  final storage = GetStorage();
  bool get isDark => storage.read('darkmode') ?? false;
  ThemeData get theme => isDark ? darkTheme : lightTheme;

  void changeTheme(bool val) {
    storage.write('darkmode', val);
    notifyListeners();
  }
}
