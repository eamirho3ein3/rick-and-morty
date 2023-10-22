import 'package:flutter/material.dart';

///
/// Solid color system
///

class ColorPalette {
  final Color background;
  final Color surface;

  final MaterialColor primary;
  final Color primaryDisable;

  final Color secondary;
  final Color secondaryDisable;

  final Color text;
  final Color textSoft;
  final Color textDanger;

  final Color icon;

  final Color border;

  final Color interactiveFocus;

  final MaterialColor black;
  final MaterialColor white;

  ColorPalette({
    required this.background,
    required this.surface,
    required this.primary,
    required this.primaryDisable,
    required this.secondary,
    required this.secondaryDisable,
    required this.text,
    required this.textDanger,
    required this.textSoft,
    required this.icon,
    required this.border,
    required this.black,
    required this.white,
    required this.interactiveFocus,
  });
}

class CustomColors {
  //
  // Light
  static ColorPalette light = ColorPalette(
    background: Color(0xFFE5E5E5),
    surface: Color(0xffFFFFFF),
    primary: MaterialColor(
      0xFFfbfb63,
      const <int, Color>{
        50: const Color(0xFFfbfb63),
        100: const Color(0xFFfbfb63),
        200: const Color(0xFFfbfb63),
        300: const Color(0xFFfbfb63),
        400: const Color(0xFFfbfb63),
        500: const Color(0xFFfbfb63),
        600: const Color(0xFFfbfb63),
        700: const Color(0xFFfbfb63),
        800: const Color(0xFFfbfb63),
        900: const Color(0xFFfbfb63),
      },
    ),
    primaryDisable: Color(0xff22A76C).withOpacity(0.6),
    secondary: Color(0xFF86c3b8),
    secondaryDisable: Colors.black.withOpacity(0.6),
    text: Colors.black,
    textSoft: Colors.black.withOpacity(0.6),
    textDanger: Color(0xffC93637),
    icon: Colors.white,
    border: Colors.white54,
    interactiveFocus: Color(0xff66A6FF),
    black: MaterialColor(
      0xff131A28,
      <int, Color>{
        20: const Color(0xff131A28).withOpacity(0.2),
        40: const Color(0xff131A28).withOpacity(0.4),
        60: const Color(0xff131A28).withOpacity(0.6),
        80: const Color(0xff131A28).withOpacity(0.8),
      },
    ),
    white: MaterialColor(
      0xffFFFFFF,
      <int, Color>{
        20: const Color(0xffFFFFFF).withOpacity(0.2),
        40: const Color(0xffFFFFFF).withOpacity(0.4),
        60: const Color(0xffFFFFFF).withOpacity(0.6),
        80: const Color(0xffFFFFFF).withOpacity(0.8),
      },
    ),
  );

  //
  // Dark
  static ColorPalette dark = ColorPalette(
    background: Color(0xFF35363C),
    surface: Color(0xff19191A),
    primary: MaterialColor(
      0xFFfbfb63,
      const <int, Color>{
        50: const Color(0xFFfbfb63),
        100: const Color(0xFFfbfb63),
        200: const Color(0xFFfbfb63),
        300: const Color(0xFFfbfb63),
        400: const Color(0xFFfbfb63),
        500: const Color(0xFFfbfb63),
        600: const Color(0xFFfbfb63),
        700: const Color(0xFFfbfb63),
        800: const Color(0xFFfbfb63),
        900: const Color(0xFFfbfb63),
      },
    ),
    primaryDisable: Color.fromARGB(255, 188, 188, 189),
    secondary: Color(0xFF86c3b8),
    secondaryDisable: Colors.white,
    text: Colors.white,
    textSoft: Colors.white.withOpacity(0.6),
    textDanger: Color(0xffEE3D3F),
    icon: Colors.black,
    border: Colors.black12,
    interactiveFocus: Color(0xffFFCB66),
    black: MaterialColor(
      0xffFFFFFF,
      <int, Color>{
        20: const Color(0xffFFFFFF).withOpacity(0.2),
        40: const Color(0xffFFFFFF).withOpacity(0.4),
        60: const Color(0xffFFFFFF).withOpacity(0.6),
        80: const Color(0xffFFFFFF).withOpacity(0.8),
      },
    ),
    white: MaterialColor(
      0xff1E1E1E,
      <int, Color>{
        20: const Color(0xff1E1E1E).withOpacity(0.2),
        40: const Color(0xff1E1E1E).withOpacity(0.4),
        60: const Color(0xff1E1E1E).withOpacity(0.6),
        80: const Color(0xff1E1E1E).withOpacity(0.8),
      },
    ),
  );
}

extension CustomColorScheme on ColorScheme {
  Color get testPurple => Colors.purple;
}
