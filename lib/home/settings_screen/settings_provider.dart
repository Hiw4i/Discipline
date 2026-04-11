import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier {
  static const String _themeKey = 'theme_mode';
  static const String _colorKey = 'theme_color';
  static const String _amoledKey = 'amoled_mode';
  static const Map<String, Color> themeColors = {
    'ocean': Color(0xFF2D7575),
    'purple': Color(0xFF7A468F),
    'forest': Color(0xFF0E4736),
    'amber': Color(0xFFC0741E),
    'sunset': Color(0xFFC25E5E),
    'sky': Color(0xFF4682B4),
    'mint': Color(0xFF98FF98),
  };

  ThemeMode _themeMode = ThemeMode.system;
  String _themeColor = 'dynamic';
  bool _amoled = false;

  ThemeMode get themeMode => _themeMode;
  String get themeColor => _themeColor;
  bool get amoled => _amoled;

  late SharedPreferences _prefs;

  Future<void> loadSettings() async {
    _prefs = await SharedPreferences.getInstance();
    
    _themeMode = ThemeMode.values[_prefs.getInt(_themeKey) ?? 0];
    _themeColor = _prefs.getString(_colorKey) ?? 'dynamic';
    _amoled = _prefs.getBool(_amoledKey) ?? false;
    
    notifyListeners();
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    _themeMode = mode;
    notifyListeners();

    await _prefs.setInt(_themeKey, mode.index);
  }

  Future<void> setThemeColor(String colorName) async {
    _themeColor = colorName;
    notifyListeners(); 

    await _prefs.setString(_colorKey, colorName); 
  }

  Color get currentSeedColor {
    if (_themeColor == 'dynamic') {
      return themeColors['amber']!; // If dynamic is selected but not available
    }
    return themeColors[_themeColor]!;
  }

  Future<void> setAmoled(bool value) async {
    _amoled = value;
    notifyListeners();
    
    await _prefs.setBool(_amoledKey, value);
  }
}