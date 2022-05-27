abstract class SettingsRepository {
  Future<String?> findThemeSettings();
  Future<void> saveThemeSettings(String json);
}
