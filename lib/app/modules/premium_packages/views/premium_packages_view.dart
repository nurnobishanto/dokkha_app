import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/helper/global.dart';
import 'package:lokkha/app/modules/auth_views/auth_gateway/views/auth_gateway_view.dart';
import 'package:lokkha/app/modules/premium_packages/views/premium_package_checkout_view.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import '../../../../styles/text_style.dart';
import '../controllers/premium_packages_controller.dart';

class PremiumPackagesView extends GetView<PremiumPackagesController> {
  const PremiumPackagesView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PremiumPackagesController());
    //   final packages=controller.model.value.packages;
    return Scaffold(
      appBar:
          const CustomAppBar(title: 'প্রিমিয়াম প্যাকেজ', centerTitle: true),
      body: Obx(() {
        return controller.isLoading.value
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: Colors.grey)),
                child: Column(
                  children: [
                    _buildHeaderRow(),
                    const Divider(height: 0, color: Colors.grey),
                    Flexible(
                      child: ListView.builder(
                        itemCount: controller.model.value.packages?.length ?? 0,
                        itemBuilder: (context, index) {
                          final pkg = controller.model.value.packages![index];
                          return Column(
                            children: [
                              _buildPackageTable(
                                onTapCheckout: () {
                                  if (isLoggedIn.value) {
                                    Get.to(
                                      PremiumPackageCheckoutView(
                                        packagesModel: pkg,
                                      ),
                                    );
                                  } else {
                                    Get.to(const AuthGatewayView());
                                  }
                                },
                                title: pkg.name.toString(),
                                duration: '${pkg.duration.toString()} দিন',
                                price: pkg.discountedPrice.toString(),
                                oldPrice: pkg.regularPrice.toString(),
                                discount: '- ${pkg.discount.toString()}%',
                                features: (jsonDecode(pkg.features.toString())
                                        as List<dynamic>)
                                    .cast<String>(),
                                isFemale: pkg.isFemale!.toInt(),
                              ),
                              const Divider(height: 0),
                            ],
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
    required int isFemale,
    void Function()? onTapCheckout,
    required List<String> features,
  }) {
    return InkWell(
      onTap: onTapCheckout,
      child: Container(
        color: isFemale == 1
            ? LightThemeColors.red.withValues(alpha: .2)
            : Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(top: 3, bottom: 1, left: 8, right: 8),
          child: Table(
            columnWidths: const {
              0: FlexColumnWidth(3),
              1: FixedColumnWidth(6),
              2: FlexColumnWidth(2),
            },
            children: [
              TableRow(
                children: [
                  // Title + Features
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      Text(
                        duration,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 14),
                      ),
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
                      height: 90,
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
                        style:
                            const TextStyle(fontSize: 12, color: Colors.green),
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: onTapCheckout,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: isFemale == 1
                              ? LightThemeColors.red
                              : Colors.blueAccent,
                          minimumSize: const Size(90, 30),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 6),
                        ),
                        child: Text(
                          'প্যাকেজ কিনুন',
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
        ),
      ),
    );
  }
}
