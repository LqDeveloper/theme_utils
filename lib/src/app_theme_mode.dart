/// App 主题类型
enum AppThemeMode {
  /// 浅色模式
  light('Light'),

  /// 暗黑模式
  dark('Dark'),

  /// 跟随系统
  system('System');

  const AppThemeMode(this.val);

  /// 模式名称
  final String val;

  /// 是否使浅色模式
  bool get isLight => this == AppThemeMode.light;

  /// 是否使暗黑模式
  bool get isDark => this == AppThemeMode.dark;

  /// 是否使跟随系统
  bool get isSystem => this == AppThemeMode.system;

  /// 根据名称获取主题类型
  static AppThemeMode fromVal(String modeName) {
    return AppThemeMode.values.firstWhere((element) => element.val == modeName,
        orElse: () => AppThemeMode.system);
  }
}
