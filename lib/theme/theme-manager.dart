import 'package:flutter/material.dart';
import 'package:rick_and_morty/theme/storage-manager.dart';

class ThemeNotifier with ChangeNotifier {
  final darkTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: const Color(0xFF828283),
    brightness: Brightness.dark,
    backgroundColor: const Color(0xFF35363C),
    accentColor: Colors.white,
    accentIconTheme: IconThemeData(color: Colors.black),
    dividerColor: Colors.black12,
    canvasColor: const Color(0xFF21232A),
    appBarTheme: AppBarTheme(
      color: Colors.black,
    ),
    textTheme: const TextTheme(
      headline3: TextStyle(
          fontSize: 24.0, fontWeight: FontWeight.w700, color: Colors.white),
      headline4: TextStyle(
          fontSize: 18.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyText1: TextStyle(fontSize: 18.0, color: const Color(0xFF757575)),
      bodyText2: TextStyle(fontSize: 14.0, color: Colors.white),
      subtitle1: TextStyle(fontSize: 14.0, color: const Color(0xFF828283)),
    ),
  );

  final lightTheme = ThemeData(
    primarySwatch: Colors.grey,
    primaryColor: Colors.white,
    brightness: Brightness.light,
    backgroundColor: const Color(0xFFE5E5E5),
    accentColor: Colors.black,
    accentIconTheme: IconThemeData(color: Colors.white),
    dividerColor: Colors.white54,
    canvasColor: Colors.white,
  );

  ThemeData _themeData;
  ThemeData getTheme() => _themeData;

  ThemeNotifier() {
    StorageManager.readData('themeMode').then((value) {
      var themeMode = value ?? 'dark';
      if (themeMode == 'light') {
        _themeData = lightTheme;
      } else {
        _themeData = darkTheme;
      }
      notifyListeners();
    });
  }

  void setDarkMode() async {
    _themeData = darkTheme;
    StorageManager.saveData('themeMode', 'dark');
    notifyListeners();
  }

  void setLightMode() async {
    _themeData = lightTheme;
    StorageManager.saveData('themeMode', 'light');
    notifyListeners();
  }
}
