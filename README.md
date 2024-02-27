## How to Use

```dart

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

```

## AppThemeMode
```dart

enum AppThemeMode {
  /// Light Mode
  light('Light'),

  /// Dark Mode
  dark('Dark'),

  /// Follow the system
  system('System');
}

```

## Extension
```dart
extension ThemeContextExtensions on BuildContext {
  ///setup Theme
  void setupTheme(AppThemeMode mode) {
    AppThemeWidget.of(this).setupMode(mode);
  }

  ///get current theme mode
  AppThemeMode get themeMode =>
      AppThemeWidget
          .of(this)
          .themeMode;

  ///watch theme mode
  T wt<T extends BaseThemeData>() => AppThemeWidget.watch<T>(this);

  ///read theme mode
  T rt<T extends BaseThemeData>() => AppThemeWidget.read<T>(this);

  ///reload theme
  void reloadTheme() {
    AppThemeWidget.reloadTheme(this);
  }
}

```