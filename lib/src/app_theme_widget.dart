import 'dart:ui';

import 'package:flutter/material.dart';

import 'app_inherited_theme.dart';
import 'app_theme_mode.dart';
import 'base_theme_data.dart';

typedef AppThemeBuilder<T> = Widget Function(BuildContext context, T themeData);

/// App主题管理
class AppThemeWidget<T extends BaseThemeData> extends StatefulWidget {
  final AppThemeMode initialModel;
  final T lightTheme;
  final T darkTheme;
  final AppThemeBuilder<T> builder;

  const AppThemeWidget({
    super.key,
    required this.initialModel,
    required this.lightTheme,
    required this.darkTheme,
    required this.builder,
  });

  /// 获取非空AppThemeState
  static AppThemeState<T> of<T extends BaseThemeData>(BuildContext context) {
    final state = context.findAncestorStateOfType<AppThemeState<T>>();
    assert(state != null, '父节点中并没有AppTheme包裹');
    return state!;
  }

  /// 获取可为空非空AppThemeState
  static AppThemeState<T>? maybeOf<T extends BaseThemeData>(
      BuildContext context) {
    final state = context.findAncestorStateOfType<AppThemeState<T>>();
    return state;
  }

  ///设置主题
  static void setupMode(BuildContext context, AppThemeMode mode) {
    of(context).setupMode(mode);
  }

  ///更新Theme
  static void reloadTheme(BuildContext context) {
    of(context).reloadTheme();
  }

  /// 可监听主题的变化的形式获取T
  static T watch<T extends BaseThemeData>(BuildContext context) {
    return AppInheritedTheme.watch<T>(context).theme;
  }

  /// 不监听主题的变化的形式获取 T
  static T read<T extends BaseThemeData>(BuildContext context) {
    return AppInheritedTheme.read<T>(context).theme;
  }

  @override
  AppThemeState<T> createState() => AppThemeState<T>();
}

class AppThemeState<T extends BaseThemeData> extends State<AppThemeWidget<T>>
    with ThemeMixin<T, AppThemeWidget<T>> {
  @override
  void initState() {
    super.initState();
    _currentMode = widget.initialModel;
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      _updateStatusBar();
    });
  }

  @override
  void didUpdateWidget(covariant AppThemeWidget<T> oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialModel != widget.initialModel) {
      _currentMode = widget.initialModel;
      _updateStatusBar();
    }
  }

  /// 子节点通过AppThemeState.of(context).setupMode
  /// 或者AppThemeState.maybeOf(context)?.setupMode
  /// 设置App 主题
  @override
  void setupMode(AppThemeMode mode) {
    super.setupMode(mode);
    _updateStatusBar();
  }

  void _updateStatusBar() {
    final themeData = _themeData;
    themeData.setStatusStyle();
  }

  T get _themeData {
    switch (_currentMode) {
      case AppThemeMode.light:
        return widget.lightTheme;
      case AppThemeMode.dark:
        return widget.darkTheme;
      case AppThemeMode.system:
        return _systemTheme;
    }
  }

  T get _systemTheme {
    final brightness =
        WidgetsBinding.instance.platformDispatcher.platformBrightness;
    return brightness == Brightness.light
        ? widget.lightTheme
        : widget.darkTheme;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<int>(
        valueListenable: valueNotifier,
        builder: (BuildContext context, _, __) {
          final themeData = _themeData;
          return AppInheritedTheme(
            refreshTag: refreshTag,
            theme: themeData,
            child: widget.builder(
              context,
              themeData,
            ),
          );
        });
  }
}

mixin ThemeMixin<T extends BaseThemeData, S extends StatefulWidget> on State<S>
    implements WidgetsBindingObserver {
  AppThemeMode _currentMode = AppThemeMode.system;

  ///当前主题类型
  AppThemeMode get themeMode => _currentMode;

  int _refreshTag = 0;

  int get refreshTag => _refreshTag;

  final ValueNotifier<int> valueNotifier = ValueNotifier(0);

  ///更新Theme
  void reloadTheme() {
    if (_refreshTag > 100) {
      _refreshTag = 0;
    } else {
      _refreshTag = _refreshTag + 1;
    }
    _updateValueNotifier();
  }

  void _updateValueNotifier() {
    final value = valueNotifier.value;
    if (value > 100) {
      valueNotifier.value = 0;
    } else {
      valueNotifier.value = value + 1;
    }
  }

  ///设置主题类型
  void setupMode(AppThemeMode mode) {
    if (_currentMode == mode) {
      return;
    }
    _currentMode = mode;
    _updateValueNotifier();
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  ///WidgetsBindingObserver
  @override
  void didChangeAccessibilityFeatures() {}

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {}

  @override
  void didChangeLocales(List<Locale>? locales) {}

  @override
  void didChangeMetrics() {}

  @override
  void didChangePlatformBrightness() {
    ///更改系统模式
    if (_currentMode == AppThemeMode.system && context.mounted) {
      _updateValueNotifier();
    }
  }

  @override
  void didChangeTextScaleFactor() {}

  @override
  void didHaveMemoryPressure() {}

  @override
  Future<bool> didPopRoute() => Future<bool>.value(false);

  @override
  Future<bool> didPushRoute(String route) => Future<bool>.value(false);

  @override
  Future<bool> didPushRouteInformation(RouteInformation routeInformation) {
    final Uri uri = routeInformation.uri;
    return didPushRoute(
      Uri.decodeComponent(
        Uri(
          path: uri.path.isEmpty ? '/' : uri.path,
          queryParameters:
              uri.queryParametersAll.isEmpty ? null : uri.queryParametersAll,
          fragment: uri.fragment.isEmpty ? null : uri.fragment,
        ).toString(),
      ),
    );
  }

  @override
  Future<AppExitResponse> didRequestAppExit() async {
    return AppExitResponse.exit;
  }
}
