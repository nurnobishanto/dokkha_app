// import 'dart:developer';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:lokkha/app/components/custom_app_bar.dart';
//
// import '../../../../../utils/date_formatter.dart';
// import '../../../premium_packages/views/payment_webview.dart';
// import '../controllers/my_orders_details_controller.dart';
//
// class OrderDetailsScreen extends GetView<MyOrdersDetailsController> {
//   final int orderId;
//   const OrderDetailsScreen( {super.key, required this.orderId,});
//
//   @override
//   Widget build(BuildContext context) {
//     controller.fetchMyOrdersDetails(id: orderId);
//     final data = controller.model.value.order;
//     return Scaffold(
//       appBar: const CustomAppBar(title: 'অর্ডার ইনফরমেশন'),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Card(
//                 elevation: 4,
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(10),
//                 ),
//                 child: Padding(
//                   padding: const EdgeInsets.all(16.0),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "#${data?.invoiceNo ?? ''}",
//                         style: const TextStyle(
//                             fontWeight: FontWeight.bold, fontSize: 16),
//                       ),
//                       const SizedBox(height: 10),
//                       // Text(
//                       //   DateFormatter.formatToDMY(data.createdAt.toString()),
//                       //   style:
//                       //   const TextStyle(color: Colors.grey, fontSize: 14),
//                       // ),
//                       order.note == null
//                           ? const SizedBox.shrink()
//                           : Text(
//                               order.note.toString(),
//                               style: const TextStyle(
//                                   color: Colors.grey, fontSize: 14),
//                             ),
//                       const SizedBox(height: 10),
//                       ListView.builder(
//                         itemCount: order.items!.length,
//                         itemBuilder: (_, index) {
//                           log(order.items![index].itemOne.toString());
//                           return (order.items![index].itemOne == null &&
//                                   order.items![index].itemTwo == null &&
//                                   order.items![index].itemThree == null)
//                               ? const SizedBox.shrink()
//                               : ProductItem(
//                                   name: () {
//                                     debugPrint(
//                                         "Items ${order.items![index].itemType.toString()}");
//                                     if (order.items![index].itemType
//                                             .toString() ==
//                                         'App\\Models\\TaxReturn') {
//                                       return order
//                                           .items![index].itemTwo!.returnId
//                                           .toString();
//                                     } else if (order.items![index].itemType
//                                             .toString() ==
//                                         'App\\Models\\ModelTest') {
//                                       return order
//                                           .items![index].itemThree!.title
//                                           .toString();
//                                     } else {
//                                       return order.items![index].itemOne!.name
//                                           .toString();
//                                     }
//                                   }(),
//                                   price: () {
//                                     if (order.items![index].itemType
//                                             .toString() ==
//                                         'App\\Models\\TaxReturn') {
//                                       return '৳ ${order.items![index].itemTwo!.paymentAmount.toString()}';
//                                     } else if (order.items![index].itemType
//                                             .toString() ==
//                                         'App\\Models\\ModelTest') {
//                                       return '৳ ${order.items![index].itemThree!.sellingPrice.toString()}';
//                                     } else {
//                                       return '৳ ${order.items![index].itemOne!.price.toString()}';
//                                     }
//                                   }(),
//                                 );
//                         },
//                         shrinkWrap: true,
//                         physics: const NeverScrollableScrollPhysics(),
//                       ),
//                       const SizedBox(height: 10),
//                       const Divider(),
//                       OrderSummaryItem(
//                         label: AppConstant.total.tr,
//                         amount: '৳ ${order.totalAmount.toString()}',
//                       ),
//                       double.tryParse(order.paidAmount.toString())! > 0.0
//                           ? OrderSummaryItem(
//                               label: AppConstant.paidAmount.tr,
//                               amount: '৳ ${order.paidAmount.toString()}',
//                             )
//                           : const SizedBox(),
//                       double.tryParse(order.due.toString())! > 0.0
//                           ? OrderSummaryItem(
//                               label: AppConstant.dueAmount.tr,
//                               amount: '৳ ${order.due.toString()}',
//                               isNegative: true,
//                             )
//                           : const SizedBox(),
//                       const SizedBox(height: 10),
//                       const Divider(),
//                       const SizedBox(height: 10),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           OrderStatusLabel(
//                             status: order.status.toString().tr,
//                             color: order.status == 'pending'
//                                 ? Colors.amber
//                                 : order.status == 'completed'
//                                     ? Colors.green
//                                     : Colors.red,
//                             fontColor: order.status == 'pending'
//                                 ? Colors.black
//                                 : order.status == 'completed'
//                                     ? Colors.white
//                                     : Colors.white,
//                           ),
//                           OrderStatusLabel(
//                             // status:
//                             //     order.paymentMethod!.toUpperCase().toString(),
//                             status: order.paymentMethod!.toString(),
//                             color: AppColors.black,
//                             fontColor: AppColors.white,
//                           ),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 20.0,
//               ),
//               //
//               Text(
//                 AppConstant.paymentHistory.tr,
//                 style: const TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.black,
//                 ),
//               ),
//               SizedBox(
//                 height: order.payments!.length * 100,
//                 child: ListView.builder(
//                     itemCount: order.payments!.length,
//                     itemBuilder: (_, index) {
//                       return Card(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.start,
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       "#${order.payments![index].transactionId.toString()}",
//                                       style: const TextStyle(
//                                         fontWeight: FontWeight.w500,
//                                       ),
//                                     ),
//                                     const SizedBox(width: 10.0),
//                                     Text(
//                                         "৳ ${order.payments![index].amount.toString()}"),
//                                     Text(
//                                         " ${order.payments![index].paymentMethod!.toString()}"),
//                                   ],
//                                 ),
//                               ),
//                               Expanded(
//                                 child: Column(
//                                   mainAxisAlignment: MainAxisAlignment.center,
//                                   crossAxisAlignment: CrossAxisAlignment.end,
//                                   children: [
//                                     OrderStatusLabel(
//                                       status: order.payments![index].status!
//                                           .toString()
//                                           .tr,
//                                       color: order.payments![index].status ==
//                                               'pending'
//                                           ? Colors.amber
//                                           : order.payments![index].status ==
//                                                   'completed'
//                                               ? Colors.green
//                                               : Colors.red,
//                                       fontColor:
//                                           order.payments![index].status ==
//                                                   'pending'
//                                               ? Colors.black
//                                               : order.payments![index].status ==
//                                                       'completed'
//                                                   ? Colors.white
//                                                   : Colors.white,
//                                     ),
//                                     order.payments![index].status == 'pending'
//                                         ? ElevatedButton(
//                                             onPressed: () {
//                                               Get.to(PaymentWebView(
//                                                   url:
//                                                       "${order.paymentUrl.toString()}?payment_method${order.payments![index].paymentMethod!.toString()}"));
//                                             },
//                                             style: ElevatedButton.styleFrom(
//                                               backgroundColor: Colors
//                                                   .green, // background color
//                                               shape: RoundedRectangleBorder(
//                                                 borderRadius:
//                                                     BorderRadius.circular(
//                                                         20), // rounded corners
//                                               ),
//                                               minimumSize: const Size(
//                                                   50, 25), // small size
//                                             ),
//                                             child: Text(
//                                               'payNow',
//                                               style: const TextStyle(
//                                                   color: Colors.white),
//                                             ),
//                                           )
//                                         : const SizedBox(),
//                                   ],
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     }),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// class ProductItem extends StatelessWidget {
//   final String name;
//   final String price;
//
//   const ProductItem({super.key, required this.name, required this.price});
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Expanded(
//             child: Text(
//               name,
//               style: const TextStyle(fontSize: 14),
//             ),
//           ),
//           Text(
//             price,
//             style: const TextStyle(fontSize: 14),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OrderSummaryItem extends StatelessWidget {
//   final String label;
//   final String amount;
//   final bool isBold;
//   final bool isNegative;
//
//   const OrderSummaryItem({
//     super.key,
//     required this.label,
//     required this.amount,
//     this.isBold = false,
//     this.isNegative = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 5.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: [
//           Text(
//             label,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//             ),
//           ),
//           Text(
//             amount,
//             style: TextStyle(
//               fontSize: 14,
//               fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
//               color: isNegative ? Colors.red : Colors.black,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
//
// class OrderStatusLabel extends StatelessWidget {
//   final String status;
//   final Color color;
//   final Color fontColor;
//
//   const OrderStatusLabel(
//       {super.key,
//       required this.status,
//       required this.color,
//       required this.fontColor});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(20),
//       ),
//       child: Text(
//         status,
//         style: TextStyle(color: fontColor, fontSize: 12),
//       ),
//     );
//   }
// }
