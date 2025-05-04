import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/contest/controller/latest_contest_controller.dart';

import '../../../../styles/text_style.dart';
import '../../nav_bar_views/home/components/home_components.dart';

class LastContestResultWidget extends StatelessWidget {
  const LastContestResultWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(LatestContestController());
    return Obx(() {
      return Column(
        children: [
          Text(
            "সর্বশেষ বিজয়ীদের তালিকা",
            style: AppTextStyles.custom(
              fontSize: 17.00.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          controller.isResultLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  color: Colors.green.shade50,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                      controller.rankUsers.length >= 3
                          ? 3
                          : controller.rankUsers.length,
                      (index) {
                        int displayRank = controller.rankUsers[index]
                            .rank; // can change this based on actual data
                        double topPadding = index == 1 ? 5.h : 30.h;
                        return Padding(
                          padding: EdgeInsets.only(top: topPadding),
                          child: buildTopRankedUser(
                            imagePath:
                                controller.rankUsers[index].image.toString(),
                            id: controller.rankUsers[index].userId.toString(),
                            rank: displayRank,
                            isFirst: displayRank == 1,
                          ),
                        );
                      },
                    ),
                  ),
                ),
        ],
      );
    });
  }
}
