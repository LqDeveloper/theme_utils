import 'package:example/dark_theme_data.dart';
import 'package:example/light_theme_data.dart';
import 'package:flutter/material.dart';
import 'package:theme_utils/theme_utils.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AppThemeWidget(
        initialModel: AppThemeMode.system,
        lightTheme: LightThemeDate(),
        darkTheme: DarkThemeDate(),
        builder: (_, themeData) {
          return MaterialApp(
            title: 'Flutter Demo',
            theme: themeData.themeData,
            home: const HomePage(),
          );
        });
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('主题管理'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextButton(
                onPressed: () {
                  context.setupTheme(AppThemeMode.light);
                },
                child: const Text('Light')),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  context.setupTheme(AppThemeMode.dark);
                },
                child: const Text('Dark')),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  context.setupTheme(AppThemeMode.system);
                },
                child: const Text('System')),
            const SizedBox(height: 40),
            TextButton(
                onPressed: () {
                  context.reloadTheme();
                },
                child: const Text('Reload')),
          ],
        ),
      ),
    );
  }
}
