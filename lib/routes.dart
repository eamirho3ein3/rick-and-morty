import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/home/home.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    // case AuthPage.route:
    //   return MaterialPageRoute(
    //     builder: (_) => const AuthPage(),
    //     settings: settings,
    //   );

    // case IntroPage.route:
    //   return MaterialPageRoute(
    //     builder: (_) => const IntroPage(),
    //     settings: settings,
    //   );

    // case SplashScreen.route:
    default:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
  }
}
