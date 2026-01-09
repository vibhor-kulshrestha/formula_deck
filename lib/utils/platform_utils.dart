import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:device_info_plus/device_info_plus.dart';

/// Platform detection and iOS version checking utilities
class PlatformUtils {
  static final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();
  static int? _iosVersion;

  /// Check if running on iOS/iPadOS
  static bool get isIOS => Platform.isIOS;

  /// Check if running on Android
  static bool get isAndroid => Platform.isAndroid;

  /// Check if running on iPad
  static Future<bool> get isIPad async {
    if (!isIOS) return false;
    try {
      final iosInfo = await _deviceInfo.iosInfo;
      final model = iosInfo.model.toLowerCase();
      final name = iosInfo.name.toLowerCase();
      // Check both model and name for iPad detection
      return model.contains('ipad') || name.contains('ipad');
    } catch (e) {
      debugPrint('Error detecting iPad: $e');
      return false;
    }
  }

  /// Get iOS version number
  static Future<int> getIOSVersion() async {
    if (_iosVersion != null) return _iosVersion!;
    if (!isIOS) return 0;

    try {
      final iosInfo = await _deviceInfo.iosInfo;
      final versionString = iosInfo.systemVersion;
      final majorVersion = int.tryParse(versionString.split('.').first) ?? 0;
      _iosVersion = majorVersion;
      return majorVersion;
    } catch (e) {
      debugPrint('Error getting iOS version: $e');
      return 0;
    }
  }

  /// Check if iOS version supports Liquid Glass effects (iOS 15+)
  static Future<bool> supportsLiquidGlass() async {
    if (!isIOS) return false;
    final version = await getIOSVersion();
    return version >= 15; // iOS 15+ supports advanced blur effects
  }

  /// Check if device supports advanced blur (iOS 15+)
  static Future<bool> supportsAdvancedBlur() async {
    return await supportsLiquidGlass();
  }
}

