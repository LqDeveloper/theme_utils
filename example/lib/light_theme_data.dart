import 'package:flutter/material.dart';
import 'package:theme_utils/theme_utils.dart';

class LightThemeDate extends BaseThemeData {
  @override
  AppBarTheme? get appBarTheme =>
      const AppBarTheme(backgroundColor: Colors.pink);

  @override
  Color? get scaffoldBgColor => Colors.red;
}
