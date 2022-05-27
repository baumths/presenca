import 'package:hive/hive.dart';

import '../../domain/repositories/settings_repository.dart';

enum SettingsKeys {
  theme('theme');

  const SettingsKeys(this.key);

  final String key;
}

class SettingsRepositoryImpl implements SettingsRepository {
  static const String kSettingsBoxName = 'settings';

  const SettingsRepositoryImpl(
    LazyBox<String> storage,
  ) : _storage = storage;

  final LazyBox<String> _storage;

  static Future<SettingsRepository> create() async {
    final box = await Hive.openLazyBox<String>(kSettingsBoxName);
    return SettingsRepositoryImpl(box);
  }

  @override
  Future<String?> findThemeSettings() {
    return _storage.get(SettingsKeys.theme.key);
  }

  @override
  Future<void> saveThemeSettings(String json) async {
    await _storage.put(SettingsKeys.theme.key, json);
  }
}
