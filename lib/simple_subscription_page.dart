// // 🔧 Required Dependencies in pubspec.yaml:
// // -----------------------------------------
// // in_app_purchase: ^3.1.6
// // in_app_purchase_storekit: ^0.3.21
// //
// // 👉 Note:
// // - For iOS, make sure to call `InAppPurchaseStoreKitPlatform.registerPlatform()`.
// // - Add your subscription product in App Store Connect or Google Play Console.
// // - Ensure your `productId` (e.g., 'com.yourapp.subscription.monthly') matches exactly.
//
//
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'package:in_app_purchase_storekit/in_app_purchase_storekit.dart';
//
// class SimpleSubscriptionPage extends StatefulWidget {
//   const SimpleSubscriptionPage({super.key});
//   @override
//   State<SimpleSubscriptionPage> createState() => _SimpleSubscriptionPageState();
// }
//
// class _SimpleSubscriptionPageState extends State<SimpleSubscriptionPage> {
//   final InAppPurchase _iap = InAppPurchase.instance;
//   List<ProductDetails> _products = [];
//   final String productId = 'com.lokkha.package_features_90';
//
//   @override
//   void initState() {
//     super.initState();
//     debugPrint('🚀 initState called');
//
//     if (Platform.isIOS) {
//       debugPrint('📲 Platform is iOS, registering StoreKit platform');
//       InAppPurchaseStoreKitPlatform.registerPlatform();
//     }
//
//     debugPrint('🔔 Subscribing to purchase stream');
//     _iap.purchaseStream.listen(_handlePurchaseUpdates);
//     _loadProducts();
//   }
//
//   Future<void> _loadProducts() async {
//     debugPrint('🛒 Querying product details for: $productId');
//     final response = await _iap.queryProductDetails({productId});
//
//     if (response.error != null) {
//       debugPrint('❌ Failed to load products: ${response.error!.message}');
//     } else {
//       debugPrint('✅ Products loaded: ${response.productDetails.length}');
//     }
//
//     setState(() {
//       _products = response.productDetails.toList();
//     });
//   }
//
//   void _buy() {
//     debugPrint('🛍️ Buy button pressed');
//
//     if (_products.isEmpty) {
//       debugPrint('⚠️ No products available to purchase');
//       return;
//     }
//
//     final product = _products.first;
//     debugPrint('🧾 Initiating purchase for: ${product.id}');
//     final purchaseParam = PurchaseParam(productDetails: product);
//
//     _iap.buyNonConsumable(purchaseParam: purchaseParam);
//   }
//
//   void _handlePurchaseUpdates(List<PurchaseDetails> purchases) {
//     debugPrint('📦 Handling purchase updates: ${purchases.length} item(s)');
//
//     for (final purchase in purchases) {
//       debugPrint('🔄 Purchase status: ${purchase.status} for ${purchase.productID}');
//
//       if (purchase.status == PurchaseStatus.purchased) {
//         debugPrint('🎉 Purchase completed');
//
//         if (purchase is AppStorePurchaseDetails) {
//           final transactionId = purchase.skPaymentTransaction.transactionIdentifier;
//           debugPrint('🧾 iOS Transaction ID: $transactionId');
//         } else if (Platform.isAndroid) {
//           final purchaseToken = purchase.verificationData.serverVerificationData;
//           debugPrint('🔑 Android Purchase Token: $purchaseToken');
//         }
//
//         if (purchase.pendingCompletePurchase) {
//           debugPrint('✅ Completing pending purchase');
//           _iap.completePurchase(purchase);
//         }
//       } else if (purchase.status == PurchaseStatus.error) {
//         debugPrint('❌ Purchase error: ${purchase.error?.message}');
//       } else if (purchase.status == PurchaseStatus.canceled) {
//         debugPrint('⚠️ Purchase was cancelled by user');
//       }
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: const Text('Buy Subscription')),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _buy,
//           child: const Text('Buy Subscription'),
//         ),
//       ),
//     );
//   }
// }
