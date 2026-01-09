import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:flutter/foundation.dart';
import 'hive_service.dart';

/// Service for managing In-App Purchases
class IAPService {
  static final InAppPurchase _iap = InAppPurchase.instance;
  static final StreamController<List<PurchaseDetails>> _purchaseUpdatedController =
      StreamController<List<PurchaseDetails>>.broadcast();
  
  static Stream<List<PurchaseDetails>> get purchaseUpdated =>
      _purchaseUpdatedController.stream;

  // Product ID - Replace with your actual product ID from Google Play Console / App Store Connect
  static const String removeAdsProductId = kDebugMode
      ? 'android.test.purchased' // Test product
      : 'remove_ads_dark_mode';

  static bool _isAvailable = false;
  static List<ProductDetails> _products = [];
  static bool _purchasePending = false;

  /// Initialize IAP
  static Future<void> init() async {
    try {
      final bool available = await _iap.isAvailable();
      _isAvailable = available;

      if (available) {
        await _loadProducts();
        _iap.purchaseStream.listen(_onPurchaseUpdate);
      }
    } catch (e) {
      debugPrint('IAP initialization failed: $e');
      _isAvailable = false;
    }
  }

  /// Load available products
  static Future<void> _loadProducts() async {
    final Set<String> productIds = {removeAdsProductId};
    final ProductDetailsResponse response =
        await _iap.queryProductDetails(productIds);

    if (response.notFoundIDs.isNotEmpty) {
      debugPrint('Products not found: ${response.notFoundIDs}');
    }

    _products = response.productDetails;
  }

  /// Get product details
  static ProductDetails? getProduct() {
    return _products.isNotEmpty ? _products.first : null;
  }

  /// Check if purchase is available
  static bool get isAvailable => _isAvailable;

  /// Check if purchase is pending
  static bool get purchasePending => _purchasePending;

  /// Buy remove ads + dark mode
  static Future<bool> buyRemoveAds() async {
    if (!_isAvailable || _products.isEmpty) {
      return false;
    }

    final productDetails = _products.first;
    final purchaseParam = PurchaseParam(productDetails: productDetails);

    try {
      _purchasePending = true;
      await _iap.buyNonConsumable(purchaseParam: purchaseParam);
      return true;
    } catch (e) {
      _purchasePending = false;
      debugPrint('Error purchasing: $e');
      return false;
    }
  }

  /// Handle purchase updates
  static void _onPurchaseUpdate(List<PurchaseDetails> purchases) {
    for (final purchase in purchases) {
      if (purchase.status == PurchaseStatus.pending) {
        _purchasePending = true;
        } else {
        if (purchase.status == PurchaseStatus.error) {
          _purchasePending = false;
          debugPrint('Purchase error: ${purchase.error}');
        } else if (purchase.status == PurchaseStatus.purchased ||
            purchase.status == PurchaseStatus.restored) {
          _handlePurchaseSuccess(purchase);
        }

        if (purchase.pendingCompletePurchase) {
          _iap.completePurchase(purchase);
        }
      }
    }
  }

  /// Handle successful purchase
  static void _handlePurchaseSuccess(PurchaseDetails purchase) {
    _purchasePending = false;
    
    if (purchase.productID == removeAdsProductId) {
      HiveService.setAdsRemoved(true);
      HiveService.setDarkMode(true);
    }
  }

  /// Restore purchases
  static Future<void> restorePurchases() async {
    await _iap.restorePurchases();
  }

  /// Dispose
  static void dispose() {
    _purchaseUpdatedController.close();
  }
}

