enum AppTheme { DARK, LIGHT }
AppTheme theme;

class AppThemeModel {
  static bool isLight() {
    try {
      return theme == AppTheme.LIGHT;
    } catch (_) {
      return false;
    }
  }
}
