import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:solar_system/main.dart';

class ThemeProvider extends ChangeNotifier {

  bool isDark = prefs.getBool('isDark') ?? false;

  void changeTheme(bool val) async{
    isDark = val;
    await prefs.setBool('isDark', val);
    print("==>${prefs.getBool('isDark')}");
    notifyListeners();
  }

}