import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:rick_and_morty/services/key_list.dart';
import 'package:rick_and_morty/services/storage-manager.dart';
import 'package:rick_and_morty/theme/colors.dart';

class CustomTheme with ChangeNotifier {
  ColorPalette _currentColor =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? CustomColors.dark
          : CustomColors.light;

  ThemeMode themeMode =
      SchedulerBinding.instance.window.platformBrightness == Brightness.dark
          ? ThemeMode.dark
          : ThemeMode.light;

  ColorPalette get currentColor => _currentColor;
  bool get isDarkMode => themeMode == ThemeMode.dark;

  Future<void> switchTheme(bool isDark) async {
    _currentColor = isDark ? CustomColors.dark : CustomColors.light;
    themeMode = isDark ? ThemeMode.dark : ThemeMode.light;
    SystemChrome.setSystemUIOverlayStyle(
        isDark ? SystemUiOverlayStyle.light : SystemUiOverlayStyle.dark);

    await StorageManager.saveData(theme, isDark);
    notifyListeners();
  }
}

class ProjectTheme {
  // light theme
  static final lightTheme = ThemeData(
    primarySwatch: CustomColors.light.primary,
    primaryColor: CustomColors.light.primary,
    brightness: Brightness.light,
    iconTheme: IconThemeData(color: CustomColors.light.icon),
    dividerColor: CustomColors.light.border,
    splashColor: Colors.black.withOpacity(0.08),
    primaryColorLight: CustomColors.light.primary,
    appBarTheme: AppBarTheme(
      color: CustomColors.light.background,
      systemOverlayStyle: SystemUiOverlayStyle.dark,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: CustomColors.light.secondary,
      primary: CustomColors.light.primary,
      brightness: Brightness.light,
      background: CustomColors.light.background,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide:
            BorderSide(width: 1, color: CustomColors.light.interactiveFocus),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide(width: 1, color: CustomColors.light.textDanger),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide(width: 1, color: CustomColors.light.border),
      ),
      filled: true,
      fillColor: CustomColors.light.background,
      hoverColor: CustomColors.light.background,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      labelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.light.textSoft),
      helperStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.light.textSoft),
      counterStyle: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.light.textSoft),
    ),
    chipTheme: ChipThemeData(
      elevation: 0,
      pressElevation: 0,
      brightness: Brightness.dark,
      disabledColor: Colors.black38,
      labelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.light.text),
      padding: const EdgeInsets.all(0),
      secondaryLabelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.light.text),
      secondarySelectedColor: CustomColors.light.secondary,
    ),
    cardTheme: CardTheme(
      color: CustomColors.light.background,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        fontSize: 28.0,
        fontWeight: FontWeight.w500,
        color: CustomColors.light.text,
      ),
      displayMedium: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w500,
        color: CustomColors.light.text,
      ),
      headlineMedium: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.w600,
        color: CustomColors.light.text,
      ),
      bodyLarge: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.light.text,
      ),
      bodyMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.light.text,
      ),
      titleMedium: TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.w600,
        color: CustomColors.light.text,
      ),
      titleSmall: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.light.text,
      ),
      labelLarge: TextStyle(
        fontSize: 14.0,
        fontWeight: FontWeight.w500,
        color: CustomColors.light.text,
      ),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.light.text,
      ),
    ),
  );

  // dark theme
  static final darkTheme = ThemeData(
    primarySwatch: CustomColors.dark.primary,
    primaryColor: CustomColors.dark.primary,
    brightness: Brightness.dark,
    iconTheme: IconThemeData(color: CustomColors.dark.icon),
    dividerColor: CustomColors.dark.border,
    splashColor: Colors.black.withOpacity(0.08),
    primaryColorLight: CustomColors.dark.primary,
    appBarTheme: AppBarTheme(
      color: CustomColors.dark.background,
      systemOverlayStyle: SystemUiOverlayStyle.light,
    ),
    colorScheme: ColorScheme.fromSwatch().copyWith(
      secondary: CustomColors.dark.secondary,
      primary: CustomColors.dark.primary,
      brightness: Brightness.dark,
      background: CustomColors.light.background,
    ),
    chipTheme: ChipThemeData(
      elevation: 0,
      pressElevation: 0,
      brightness: Brightness.dark,
      disabledColor: Colors.black38,
      labelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.dark.text),
      padding: const EdgeInsets.all(0),
      secondaryLabelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.dark.text),
      secondarySelectedColor: CustomColors.dark.secondary,
    ),
    cardTheme: CardTheme(
      color: CustomColors.dark.background,
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide:
            BorderSide(width: 1, color: CustomColors.dark.interactiveFocus),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide(width: 1, color: CustomColors.dark.textDanger),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(80),
        borderSide: BorderSide(width: 1, color: CustomColors.dark.border),
      ),
      filled: true,
      fillColor: CustomColors.dark.background,
      hoverColor: CustomColors.dark.background,
      contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
      labelStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.dark.textSoft),
      helperStyle: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.dark.textSoft),
      counterStyle: TextStyle(
          fontSize: 12.0,
          fontWeight: FontWeight.w400,
          color: CustomColors.dark.textSoft),
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.w500,
          color: CustomColors.dark.text),
      displayMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.w500,
          color: CustomColors.dark.text),
      headlineMedium: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.w600,
          color: CustomColors.dark.text),
      bodyLarge: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.normal,
          color: CustomColors.dark.text),
      bodyMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.normal,
          color: CustomColors.dark.text),
      titleMedium: TextStyle(
          fontSize: 16.0,
          fontWeight: FontWeight.w600,
          color: CustomColors.dark.text),
      titleSmall: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.normal,
          color: CustomColors.dark.text),
      labelLarge: TextStyle(
          fontSize: 14.0,
          fontWeight: FontWeight.w500,
          color: CustomColors.dark.text),
      bodySmall: TextStyle(
        fontSize: 12.0,
        fontWeight: FontWeight.normal,
        color: CustomColors.dark.text,
      ),
    ),
  );
}
