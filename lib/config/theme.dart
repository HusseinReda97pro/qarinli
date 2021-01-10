enum AppTheme { DARK, LIGHT }
AppTheme theme;

class AppThemeModel {
  static bool get isLight {
    try {
      return theme == AppTheme.LIGHT;
    } catch (_) {
      return false;
    }
  }
}
