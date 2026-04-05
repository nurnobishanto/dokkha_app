import 'dart:async';
import 'package:in_app_purchase/in_app_purchase.dart';

typedef OnPurchaseDelivered = void Function(String productId, int credits);
typedef OnPurchaseError = void Function(String error);

class InAppPurchaseService {
  final InAppPurchase _iap = InAppPurchase.instance;
  final List<String> productIds;
  final OnPurchaseDelivered onDelivered;
  final OnPurchaseError? onError;

  late final StreamSubscription<List<PurchaseDetails>> _sub;
  bool available = false;
  bool initialized = false;
  List<ProductDetails> products = [];

  InAppPurchaseService({
    required this.productIds,
    required this.onDelivered,
    this.onError,
  });

  Future<void> init() async {
    available = await _iap.isAvailable();
    if (!available) {
      onError?.call('In-app purchases not available');
      return;
    }

    _sub = _iap.purchaseStream.listen(_onPurchaseUpdated,
        onError: (error) => onError?.call(error.toString()));

    final response = await _iap.queryProductDetails(productIds.toSet());
    if (response.error != null) {
      onError?.call('Product query error: ${response.error!.message}');
      return;
    }
    if (response.notFoundIDs.isNotEmpty) {
      onError?.call('Products not found: ${response.notFoundIDs.join(", ")}');
    }

    products = response.productDetails;
    initialized = true;
  }

  ProductDetails? getProductById(String id) {
    try {
      return products.firstWhere((p) => p.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<void> buyConsumable(String productId) async {
    if (!initialized) {
      onError?.call('IAP not initialized');
      return;
    }
    final prod = getProductById(productId);
    if (prod == null) {
      onError?.call('Product $productId not found');
      return;
    }
    final purchaseParam = PurchaseParam(productDetails: prod);
    try {
      await _iap.buyConsumable(purchaseParam: purchaseParam, autoConsume: true);
    } catch (e) {
      onError?.call('Purchase error: $e');
    }
  }

  Future<void> restorePurchases() async {
    if (!available) return;
    await _iap.restorePurchases();
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (final purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
        // Optional: show pending UI
          break;
        case PurchaseStatus.purchased:
        case PurchaseStatus.restored:
          _verifyAndDeliver(purchaseDetails);
          break;
        case PurchaseStatus.error:
          onError?.call(purchaseDetails.error?.message ?? 'Purchase error');
          break;
        default:
          break;
      }
    }
  }

  Future<void> _verifyAndDeliver(PurchaseDetails purchaseDetails) async {
    try {
      final productId = purchaseDetails.productID;
      final credits = _creditsForProduct(productId);

      // deliver credits callback
      onDelivered(productId, credits);

      // finish the purchase
      if (purchaseDetails.pendingCompletePurchase) {
        await _iap.completePurchase(purchaseDetails);
      }
    } catch (e) {
      onError?.call('Delivery error: $e');
    }
  }

  static const Map<String, int> _productCredits = {
    'package_feature_90': 90,
    'package_feature_180': 180,
    'package_feature_365': 365,
    'package_aparajita_365': 365,
    'package_master_365': 365,
  };

  int _creditsForProduct(String productId) {
    return _productCredits[productId] ?? 0;
  }



  void dispose() {
    try {
      _sub.cancel();
    } catch (_) {}
  }
}