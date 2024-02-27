import 'package:flutter/material.dart';

import 'package:meta/meta.dart';

import 'base_theme_data.dart';

/// 管理App 主题
@internal
class AppInheritedTheme<T extends BaseThemeData> extends InheritedWidget {
  ///更新Theme
  final int refreshTag;

  ///App主题
  final T theme;

  const AppInheritedTheme({
    super.key,
    required this.refreshTag,
    required this.theme,
    required super.child,
  });

  static AppInheritedTheme<T> watch<T extends BaseThemeData>(
    BuildContext context,
  ) {
    final themeWidget =
        context.dependOnInheritedWidgetOfExactType<AppInheritedTheme<T>>();
    assert(themeWidget != null, "父节点中未找到AppInheritedTheme");
    return themeWidget!;
  }

  static AppInheritedTheme<T> read<T extends BaseThemeData>(
    BuildContext context,
  ) {
    final themeWidget = context
        .getElementForInheritedWidgetOfExactType<AppInheritedTheme<T>>()
        ?.widget;
    assert(themeWidget != null, "父节点中未找到AppInheritedTheme");
    return (themeWidget! as AppInheritedTheme<T>);
  }

  @override
  bool updateShouldNotify(covariant AppInheritedTheme<T> oldWidget) =>
      theme != oldWidget.theme || refreshTag != oldWidget.refreshTag;
}
