import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:meta/meta.dart';

/// App 主题管理基类
abstract class BaseThemeData {
  ///app主颜色
  Color? get primaryColor => null;

  ///颜色配置
  ColorScheme? get colorScheme => null;

  ///Scaffold背景色
  Color? get scaffoldBgColor => null;

  ///水波纹颜色
  Color? get splashColor => Colors.transparent;

  ///高亮颜色
  Color? get highlightColor => Colors.transparent;

  ///Inkwell点击样式样式
  InteractiveInkFeatureFactory? get splashFactory => NoSplash.splashFactory;

  ///字体类型
  String? get fontFamily => null;

  ///状态栏样式
  SystemUiOverlayStyle? get systemOverlay => null;

  ///AppBar样式
  AppBarTheme? get appBarTheme => null;

  ///TabBar样式
  TabBarTheme? get tabBarTheme => null;

  ///底部导航样式
  BottomNavigationBarThemeData? get bottomNavigationBarTheme => null;

  ///底部弹窗样式
  BottomSheetThemeData? get bottomSheetTheme => null;

  ///Dialog样式
  DialogTheme? get dialogTheme => null;

  ///字体所在package,如果字体在子库中，需要设置这个属性
  String? get package => null;

  ///页面切换样式
  PageTransitionsTheme? get pageTransitionsTheme => null;

  ///MaterialApp中的Theme参赛
  ThemeData get themeData {
    return ThemeData(
      appBarTheme: appBarTheme,
      tabBarTheme: tabBarTheme,
      bottomNavigationBarTheme: bottomNavigationBarTheme,
      bottomSheetTheme: bottomSheetTheme,
      dialogTheme: dialogTheme,
      scaffoldBackgroundColor: scaffoldBgColor,
      colorScheme: colorScheme,
      splashColor: splashColor,
      highlightColor: highlightColor,
      splashFactory: splashFactory,
      primaryColor: primaryColor,
      fontFamily: fontFamily,
      package: package,
      pageTransitionsTheme: pageTransitionsTheme,
    );
  }

  ///设置状态栏颜色
  @internal
  void setStatusStyle() {
    final overlay = systemOverlay;
    if (overlay != null) {
      SystemChrome.setSystemUIOverlayStyle(overlay);
    }
  }
}
