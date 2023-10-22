import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/home/home.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case HomePage.route:
    default:
      return MaterialPageRoute(
        builder: (_) => HomePage(),
        settings: settings,
      );
  }
}
