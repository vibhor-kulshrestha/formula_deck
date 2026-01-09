import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:flutter/foundation.dart';
import 'hive_service.dart';

/// Service for managing AdMob ads
class AdsService {
  static BannerAd? _bannerAd;
  static bool _isInitialized = false;
  
  // Test Ad Unit IDs - Replace with your actual Ad Unit IDs
  static const String _bannerAdUnitId = kDebugMode
      ? 'ca-app-pub-3940256099942544/6300978111' // Test banner
      : 'YOUR_BANNER_AD_UNIT_ID';
  
  static const String _nativeAdUnitId = kDebugMode
      ? 'ca-app-pub-3940256099942544/2247696110' // Test native
      : 'YOUR_NATIVE_AD_UNIT_ID';

  /// Initialize AdMob
  static Future<void> init() async {
    if (_isInitialized) return;
    
    try {
      await MobileAds.instance.initialize();
      _isInitialized = true;
    } catch (e) {
      debugPrint('AdMob initialization failed: $e');
      // Continue without ads if initialization fails
      _isInitialized = false;
    }
  }

  /// Check if ads should be shown
  static bool shouldShowAds() {
    return !HiveService.areAdsRemoved();
  }

  /// Load banner ad
  static BannerAd? loadBannerAd({
    required AdSize adSize,
    required void Function(BannerAd) onAdLoaded,
    required void Function(LoadAdError) onAdFailedToLoad,
  }) {
    if (!shouldShowAds()) return null;

    _bannerAd = BannerAd(
      adUnitId: _bannerAdUnitId,
      size: adSize,
      request: const AdRequest(),
      listener: BannerAdListener(
        onAdLoaded: (ad) => onAdLoaded(ad as BannerAd),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onAdFailedToLoad(error);
        },
      ),
    );

    _bannerAd?.load();
    return _bannerAd;
  }

  /// Create native ad loader
  static NativeAd? loadNativeAd({
    required void Function(NativeAd) onAdLoaded,
    required void Function(LoadAdError) onAdFailedToLoad,
  }) {
    if (!shouldShowAds()) return null;

    final nativeAd = NativeAd(
      adUnitId: _nativeAdUnitId,
      request: const AdRequest(),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white,
        cornerRadius: 10.0,
        callToActionTextStyle: NativeTemplateTextStyle(
          textColor: Colors.white,
          backgroundColor: Colors.blue,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        primaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.black,
          style: NativeTemplateFontStyle.bold,
          size: 16.0,
        ),
        secondaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey,
          style: NativeTemplateFontStyle.normal,
          size: 14.0,
        ),
        tertiaryTextStyle: NativeTemplateTextStyle(
          textColor: Colors.grey,
          style: NativeTemplateFontStyle.normal,
          size: 12.0,
        ),
      ),
      listener: NativeAdListener(
        onAdLoaded: (ad) => onAdLoaded(ad as NativeAd),
        onAdFailedToLoad: (ad, error) {
          ad.dispose();
          onAdFailedToLoad(error);
        },
      ),
    );

    nativeAd.load();
    return nativeAd;
  }

  /// Dispose banner ad
  static void disposeBannerAd() {
    _bannerAd?.dispose();
    _bannerAd = null;
  }

  /// Get native ad unit ID
  static String get nativeAdUnitId => _nativeAdUnitId;
}

