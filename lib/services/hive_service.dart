import 'package:hive_flutter/hive_flutter.dart';

/// Service for managing bookmarks using Hive
class HiveService {
  static const String _bookmarksBoxName = 'bookmarks';
  static const String _settingsBoxName = 'settings';
  static Box<String>? _bookmarksBox;
  static Box<dynamic>? _settingsBox;

  /// Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    
    // Register adapters if needed
    // For now, we'll store formula IDs as strings
    
    _bookmarksBox = await Hive.openBox<String>(_bookmarksBoxName);
    _settingsBox = await Hive.openBox<dynamic>(_settingsBoxName);
  }

  /// Check if formula is bookmarked
  static bool isBookmarked(String formulaId) {
    return _bookmarksBox?.containsKey(formulaId) ?? false;
  }

  /// Add bookmark
  static Future<void> addBookmark(String formulaId) async {
    await _bookmarksBox?.put(formulaId, formulaId);
  }

  /// Remove bookmark
  static Future<void> removeBookmark(String formulaId) async {
    await _bookmarksBox?.delete(formulaId);
  }

  /// Get all bookmarked formula IDs
  static List<String> getBookmarkedIds() {
    return _bookmarksBox?.values.toList() ?? [];
  }

  /// Clear all bookmarks
  static Future<void> clearBookmarks() async {
    await _bookmarksBox?.clear();
  }

  /// Get setting value
  static dynamic getSetting(String key, {dynamic defaultValue}) {
    return _settingsBox?.get(key, defaultValue: defaultValue) ?? defaultValue;
  }

  /// Set setting value
  static Future<void> setSetting(String key, dynamic value) async {
    await _settingsBox?.put(key, value);
  }

  /// Check if dark mode is enabled
  static bool isDarkModeEnabled() {
    return getSetting('dark_mode', defaultValue: false) as bool;
  }

  /// Set dark mode
  static Future<void> setDarkMode(bool enabled) async {
    await setSetting('dark_mode', enabled);
  }

  /// Check if ads are removed
  static bool areAdsRemoved() {
    return getSetting('ads_removed', defaultValue: false) as bool;
  }

  /// Set ads removed status
  static Future<void> setAdsRemoved(bool removed) async {
    await setSetting('ads_removed', removed);
  }

  /// Close boxes
  static Future<void> close() async {
    await _bookmarksBox?.close();
    await _settingsBox?.close();
  }
}

