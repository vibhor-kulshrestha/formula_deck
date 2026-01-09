import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import '../services/ads_service.dart';
import '../providers/formula_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Widget for displaying native ads
class NativeAdWidget extends ConsumerStatefulWidget {
  const NativeAdWidget({super.key});

  @override
  ConsumerState<NativeAdWidget> createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends ConsumerState<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool _isAdLoaded = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadAd();
    });
  }

  void _loadAd() {
    // Check if ads should be shown
    final adsRemoved = ref.read(adsRemovedProvider);
    if (adsRemoved) {
      return;
    }

    _nativeAd = AdsService.loadNativeAd(
      onAdLoaded: (ad) {
        setState(() {
          _isAdLoaded = true;
        });
      },
      onAdFailedToLoad: (error) {
        debugPrint('Native ad failed to load: $error');
        setState(() {
          _isAdLoaded = false;
        });
      },
    );
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final adsRemoved = ref.watch(adsRemovedProvider);
    
    if (adsRemoved || !_isAdLoaded || _nativeAd == null) {
      return const SizedBox.shrink();
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      height: 300,
      child: AdWidget(ad: _nativeAd!),
    );
  }
}

