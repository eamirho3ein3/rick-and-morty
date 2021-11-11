import 'package:flutter/material.dart';
import 'package:rick_and_morty/pages/home/home.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/theme/theme-manager.dart';

void main() {
  runApp(RickApp());
}

class RickApp extends StatefulWidget {
  @override
  _RickAppState createState() => _RickAppState();
}

class _RickAppState extends State<RickApp> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ThemeNotifier>(
      create: (_) => ThemeNotifier(),
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, _) => ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 412,
            maxHeight: 915,
          ),
          child: LayoutBuilder(builder: (context, constraints) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: theme.getTheme(),
              home: HomePage(),
            );
          }),
        ),
      ),
    );
  }
}
