import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'platform_utils.dart';

/// Adaptive theme that switches between Material and Cupertino based on platform
class AdaptiveTheme {
  /// Get the appropriate theme data based on platform
  static ThemeData getTheme(BuildContext context, bool isDark) {
    if (PlatformUtils.isIOS) {
      return _getCupertinoTheme(isDark);
    }
    return _getMaterialTheme(isDark);
  }

  /// Get Cupertino-style theme for iOS
  static ThemeData _getCupertinoTheme(bool isDark) {
    return ThemeData(
      useMaterial3: false,
      brightness: isDark ? Brightness.dark : Brightness.light,
      colorScheme: ColorScheme.fromSeed(
        seedColor: CupertinoColors.systemBlue,
        brightness: isDark ? Brightness.dark : Brightness.light,
      ),
      scaffoldBackgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      appBarTheme: AppBarTheme(
        elevation: 0,
        backgroundColor: Colors.transparent,
        foregroundColor: isDark ? CupertinoColors.white : CupertinoColors.black,
        systemOverlayStyle: null,
      ),
      cardTheme: CardThemeData(
        elevation: 0,
        color: isDark
            ? CupertinoColors.secondarySystemGroupedBackground
            : CupertinoColors.systemBackground,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }

  /// Get Material 3 theme for Android
  static ThemeData _getMaterialTheme(bool isDark) {
    const primaryNavy = Color(0xFF1A237E);
    const secondaryBlue = Color(0xFF3F51B5);
    const accentTeal = Color(0xFF00ACC1);
    const backgroundLight = Color(0xFFFAFAFA);
    const surfaceLight = Color(0xFFFFFFFF);
    const backgroundDark = Color(0xFF121212);
    const surfaceDark = Color(0xFF1E1E1E);

    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryNavy,
        brightness: isDark ? Brightness.dark : Brightness.light,
        primary: primaryNavy,
        secondary: secondaryBlue,
        tertiary: accentTeal,
        surface: isDark ? surfaceDark : surfaceLight,
      ),
      scaffoldBackgroundColor: isDark ? backgroundDark : backgroundLight,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      appBarTheme: AppBarTheme(
        elevation: 0,
        centerTitle: true,
        backgroundColor: isDark ? surfaceDark : primaryNavy,
        foregroundColor: Colors.white,
      ),
    );
  }

  /// Get Cupertino theme data
  static CupertinoThemeData getCupertinoTheme(bool isDark) {
    return CupertinoThemeData(
      brightness: isDark ? Brightness.dark : Brightness.light,
      primaryColor: CupertinoColors.systemBlue,
      scaffoldBackgroundColor: isDark
          ? CupertinoColors.black
          : CupertinoColors.systemGroupedBackground,
      barBackgroundColor: isDark
          ? CupertinoColors.secondarySystemGroupedBackground
          : CupertinoColors.systemBackground,
      textTheme: CupertinoTextThemeData(
        textStyle: TextStyle(
          fontFamily: '.SF Pro Text',
          fontSize: 17,
          color: isDark ? CupertinoColors.white : CupertinoColors.black,
        ),
        navTitleTextStyle: TextStyle(
          inherit: false,
          fontFamily: '.SF Pro Display',
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: isDark ? CupertinoColors.white : CupertinoColors.black,
        ),
        navLargeTitleTextStyle: TextStyle(
          inherit: false,
          fontFamily: '.SF Pro Display',
          fontSize: 34,
          fontWeight: FontWeight.bold,
          color: isDark ? CupertinoColors.white : CupertinoColors.black,
        ),
      ),
    );
  }
}

