import 'package:flutter/material.dart';

import 'app_theme_mode.dart';
import 'app_theme_widget.dart';
import 'base_theme_data.dart';

extension ThemeContextExtensions on BuildContext {
  ///设置主题
  void setupTheme(AppThemeMode mode) {
    AppThemeWidget.of(this).setupMode(mode);
  }

  ///获取当前主题类型
  AppThemeMode get themeMode => AppThemeWidget.of(this).themeMode;

  ///监听主题变化
  T wt<T extends BaseThemeData>() => AppThemeWidget.watch<T>(this);

  ///获取主题的值
  T rt<T extends BaseThemeData>() => AppThemeWidget.read<T>(this);

  ///更新了BaseThemeData中的值，重新加载当前AppThemeMode的主题
  void reloadTheme() {
    AppThemeWidget.reloadTheme(this);
  }
}
