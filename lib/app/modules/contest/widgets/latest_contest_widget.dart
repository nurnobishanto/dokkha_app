import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/contest/controller/latest_contest_controller.dart';
import '../../../helper/global.dart';
import '../views/contest_tab_view.dart';

class LatestContestWidget extends StatelessWidget {
  const LatestContestWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LatestContestController());

    return Obx(() {
      return controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : InkWell(
              onTap: () {
                Get.to(const ContestTabView());
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(7.0),
                child: Stack(
                  children: [
                    isCheckedGifImage(controller.imageUrl.value),
                    // Image.network(
                    //   controller.imageUrl.value,
                    //   height: 110.0.h,
                    //   width: double.infinity,
                    //   fit: BoxFit.fitWidth,
                    // ),
                    Positioned(
                      top: 8.0,
                      left: 8.0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 4.0),
                        decoration: BoxDecoration(
                          color: Colors.black54,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child: controller.status.value == 'timer'
                            ? Text(
                                "${controller.hours.value.toString().padLeft(2, '0')}:"
                                "${controller.minutes.value.toString().padLeft(2, '0')}:"
                                "${controller.seconds.value.toString().padLeft(2, '0')}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0.sp,
                                  fontWeight: FontWeight.bold,
                                ),
                              )
                            : controller.status.value == 'ongoing'
                                ? const Text(
                                    "🟡 Ongoing",
                                    style: TextStyle(color: Colors.white),
                                  )
                                : const Text(
                                    '🔴 Ended',
                                    style: TextStyle(color: Colors.white),
                                  ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    });
  }
}
