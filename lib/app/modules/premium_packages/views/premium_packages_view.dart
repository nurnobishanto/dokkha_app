import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import '../../../../styles/text_style.dart';
import '../controllers/premium_packages_controller.dart';

class PremiumPackagesView extends GetView<PremiumPackagesController> {
  const PremiumPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PremiumPackagesController());
    //   final packages=controller.model.value.packages;
    return Scaffold(
      appBar: const CustomAppBar(title: 'প্রিমিয়াম প্যাকেজ'),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color:  Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey)
                ),
                child: Column(
                  children: [
                    _buildHeaderRow(),
                    const Divider(height: 0, color: Colors.grey),
                    Expanded(
                      child: ListView.separated(
                        itemCount: controller.model.value.packages?.length ?? 0,
                        separatorBuilder: (_, __) =>
                            const Divider(height: 0, color: Colors.grey),
                        itemBuilder: (context, index) {
                          final pkg = controller.model.value.packages![index];
                          return _buildPackageTable(
                            title: pkg.name.toString(),
                            duration: '${pkg.duration.toString()} দিন',
                            price: pkg.discountedPrice.toString(),
                            oldPrice: pkg.regularPrice.toString(),
                            discount: '- ${pkg.discount.toString()}%',
                            features: (jsonDecode(pkg.features.toString())
                                    as List<dynamic>)
                                .cast<String>(),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              );
      }),
    );
  }

  Widget _buildHeaderRow() {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 12, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('📦 প্যাকেজ',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          Text('💰 মূল্য',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
        ],
      ),
    );
  }

  Widget _buildPackageTable({
    required String title,
    required String price,
    required String oldPrice,
    required String discount,
    required String duration,
    required List<String> features,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      child: Table(
        columnWidths: const {
          0: FlexColumnWidth(2),
          1: FixedColumnWidth(16),
          2: FlexColumnWidth(1.3),
        },
        children: [
          TableRow(
            children: [
              // Title + Features
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),

                  Text(duration,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),



                  const SizedBox(height: 4),
                  ...features.map(
                    (f) => Padding(
                      padding: const EdgeInsets.only(bottom: 2),
                      child: Text(f, style: const TextStyle(fontSize: 12)),
                    ),
                  ),
                ],
              ),

              // Divider
              Center(
                child: Container(
                  height: 80,
                  width: 1,
                  color: Colors.green,
                ),
              ),

              // Price + Button
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(price,
                      style: const TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 14)),
                  Text(
                    oldPrice,
                    style: const TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Text(
                    discount,
                    style: const TextStyle(fontSize: 12, color: Colors.green),
                  ),
                  const SizedBox(height: 6),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent,
                      minimumSize: const Size(90, 30),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 6),
                    ),
                    child: Text(
                      'প্যাকেজ নিন',
                      style: AppTextStyles.body1.copyWith(
                        color: Colors.white,
                        fontSize: 12.0.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
