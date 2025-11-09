import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/see_all_items_controller.dart';

// class SeeAllItemsView extends GetView<SeeAllItemsController> {
//   const SeeAllItemsView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('সকল কোর্স আইটেম'),
//         centerTitle: true,
//       ),
//       body: Obx(() {
//         if (controller.isLoading.value && controller.currentPage.value == 1) {
//           return const Center(child: CircularProgressIndicator());
//         }
//
//         final items = controller.model.value.courses?.data ?? [];
//
//         return NotificationListener<ScrollNotification>(
//           onNotification: (scrollInfo) {
//             if (scrollInfo.metrics.pixels ==
//                     scrollInfo.metrics.maxScrollExtent &&
//                 !controller.isLoading.value) {
//               controller.fetchAllCourses(
//                   page: controller.currentPage.value + 1);
//             }
//             return false;
//           },
//           child: ListView.builder(
//             padding: const EdgeInsets.all(16),
//             itemCount: items.length + 1,
//             itemBuilder: (context, index) {
//               if (index == items.length) {
//                 return controller.isLoading.value
//                     ? const Padding(
//                         padding: EdgeInsets.symmetric(vertical: 16),
//                         child: Center(child: CircularProgressIndicator()),
//                       )
//                     : const SizedBox();
//               }
//
//               final item = items[index];
//               return Card(
//                 elevation: 2,
//                 margin: const EdgeInsets.only(bottom: 12),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(8),
//                 ),
//                 child: ListTile(
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   leading: ClipRRect(
//                     borderRadius: BorderRadius.circular(6),
//                     child: Image.network(
//                       item.image ?? '',
//                       width: 60,
//                       height: 60,
//                       fit: BoxFit.cover,
//                       errorBuilder: (_, __, ___) =>
//                           const Icon(Icons.image_not_supported),
//                     ),
//                   ),
//                   title: Text(
//                     item.title ?? 'No title',
//                     style: const TextStyle(fontWeight: FontWeight.bold),
//                   ),
//                   subtitle: Text(
//                     '${item.itemsCount ?? 0} টি আইটেম • ${item.duration ?? ''}',
//                     style: const TextStyle(fontSize: 13),
//                   ),
//                   trailing: const Icon(Icons.arrow_forward_ios, size: 16),
//                   onTap: () {
//                     // Navigate to details
//                   },
//                 ),
//               );
//             },
//           ),
//         );
//       }),
//     );
//   }
// }
