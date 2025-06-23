import 'package:pipeline/pipeline.dart';

class PipelineApp extends StatelessWidget {
  final ValueNotifier<ThemeMode> _themeMode = ValueNotifier(ThemeMode.dark);

  PipelineApp({super.key});

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
            home: HomePageWidget(
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
