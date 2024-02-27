import 'package:flutter/material.dart';
import 'package:theme_utils/theme_utils.dart';

class DarkThemeDate extends BaseThemeData {

  @override
  AppBarTheme? get appBarTheme => const AppBarTheme(backgroundColor: Colors.yellow);

  @override
  Color? get scaffoldBgColor => Colors.green;
}
