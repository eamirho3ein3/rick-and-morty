import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rick_and_morty/routes.dart';
import 'package:rick_and_morty/theme/theme-manager.dart';

void main() {
  runApp(RickApp());
}

class RickApp extends StatefulWidget {
  @override
  _RickAppState createState() => _RickAppState();
}

class _RickAppState extends State<RickApp> {
  final GlobalKey<NavigatorState> _navigatorKey = GlobalKey();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CustomTheme>(
      create: (_) => CustomTheme(),
      child: Consumer<CustomTheme>(
        builder: (context, theme, _) => ConstrainedBox(
          constraints: BoxConstraints(
            maxWidth: 412,
            maxHeight: 915,
          ),
          child: MaterialApp(
            // debugShowCheckedModeBanner: false,
            // title: 'Flutter Demo',
            // theme: theme.getTheme(),
            // home: HomePage(),
            navigatorKey: _navigatorKey,
            locale: const Locale('fa', 'IR'),
            debugShowCheckedModeBanner: false,
            themeMode: theme.themeMode,
            theme: ProjectTheme.lightTheme,
            darkTheme: ProjectTheme.darkTheme,
            onGenerateRoute: (settings) {
              return onGenerateRoute(settings);
            },
          ),
        ),
      ),
    );
  }
}
