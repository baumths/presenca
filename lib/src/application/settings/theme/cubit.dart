import 'dart:convert' show jsonDecode, jsonEncode;

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

import '../../../domain/repositories/settings_repository.dart';

class ThemeSettingsCubit extends Cubit<ThemeSettingsState> {
  ThemeSettingsCubit({
    required SettingsRepository settingsRepository,
  })  : _settingsRepository = settingsRepository,
        super(const ThemeSettingsState());

  final SettingsRepository _settingsRepository;

  Future<void> init() async {
    final String? themeJson = await _settingsRepository.findThemeSettings();

    if (themeJson == null) {
      return;
    }

    emit(ThemeSettingsState.fromJson(themeJson));
  }

  Future<void> updateSeedColor(Color color) async {
    if (color == state.seedColor) {
      return;
    }

    emit(state.copyWith(seedColor: color));
    await _backup();
  }

  Future<void> updateThemeMode(ThemeMode themeMode) async {
    if (themeMode == state.themeMode) {
      return;
    }

    emit(state.copyWith(themeMode: themeMode));
    await _backup();
  }

  Future<void> _backup() {
    return _settingsRepository.saveThemeSettings(state.toJson());
  }
}

class ThemeSettingsState {
  const ThemeSettingsState({
    this.themeMode = ThemeMode.system,
    this.seedColor = Colors.teal,
  });

  final ThemeMode themeMode;
  final Color seedColor;

  ThemeSettingsState.fromMap(Map<String, Object?> map)
      : this(
          themeMode: ThemeMode.values[map['themeMode'] as int],
          seedColor: Color(map['seedColor'] as int),
        );

  ThemeSettingsState.fromJson(String json)
      : this.fromMap(Map<String, Object?>.from(jsonDecode(json) as Map));

  Map<String, Object?> toMap() {
    return {
      'themeMode': themeMode.index,
      'seedColor': seedColor.value,
    };
  }

  String toJson() => jsonEncode(toMap());

  ThemeSettingsState copyWith({
    ThemeMode? themeMode,
    Color? seedColor,
  }) {
    return ThemeSettingsState(
      themeMode: themeMode ?? this.themeMode,
      seedColor: seedColor ?? this.seedColor,
    );
  }
}
