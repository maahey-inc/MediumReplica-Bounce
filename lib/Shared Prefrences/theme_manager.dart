import 'package:flutter/material.dart';
import 'package:mediumreplica/Models/theme_model.dart';
import 'package:mediumreplica/Shared%20Prefrences/storage_manager.dart';

class ThemeNotifier with ChangeNotifier {
  ThemeModel themeModel = ThemeModel();
  ThemeData _themeData = ThemeData();
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    themeModel = ThemeModel();
    StorageManager.readData('themeMode').then((value) {
      print('value read from storage: ' + value.toString());
      var themeMode = value ?? 'dark';

      if (themeMode == 'light') {
        _themeData = themeModel.lightTheme;
      } else {
        print('setting dark theme');
        _themeData = themeModel.darkTheme;
      }

      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = themeModel.darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = themeModel.lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
