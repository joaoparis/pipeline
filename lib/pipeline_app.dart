import 'package:flutter/material.dart';
import 'package:pipeline/core/themes/themes.dart';

import 'presentation/screens/home_screen.dart';

class PipelineApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.dark);

  PipelineApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
        valueListenable: _themeMode,
        builder: (context, ThemeMode currentMode, _) {
          return MaterialApp(
            title: 'Pipeline App',
            theme: lightTheme,
            darkTheme: darkTheme,
            themeMode: currentMode,
            home: HomeScreen(
              onThemeToggle: () {
                _themeMode.value = currentMode == ThemeMode.light
                    ? ThemeMode.dark
                    : ThemeMode.light;
              },
            ),
          );
        });
  }
}
