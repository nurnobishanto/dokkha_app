import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';

import '../../../../styles/text_style.dart';
import '../../../../utils/constants.dart';
import '../model_test_categories/controllers/model_test_categories_controller.dart';


class ModelTestCategoryCard extends StatelessWidget {
  final String categoryTitle;
  final String imageUrl;
  final String description;
  final VoidCallback? onTap;

  const ModelTestCategoryCard({
    super.key,
    required this.categoryTitle,
    required this.imageUrl,
    required this.description,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 8.h),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        gradient: LinearGradient(
          colors: [
            LightThemeColors.primaryColor.withValues(alpha: 0.12),
            LightThemeColors.primaryColor.withValues(alpha: 0.04),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        border: Border.all(
          color: LightThemeColors.primaryColor.withValues(alpha: 0.05),
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          height: Get.height / 9.3,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: Colors.grey.shade200, width: 0.8),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Row(
            children: [
              /// Image with gradient overlay
              ClipRRect(
                borderRadius:
                    BorderRadius.horizontal(left: Radius.circular(12.r)),
                child: Stack(
                  children: [
                    CachedNetworkImage(
                      imageUrl: imageUrl,
                      width: 120.w,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => Container(
                        color: LightThemeColors.primaryColor
                            .withValues(alpha: 0.05),
                        child: Center(
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation(
                                LightThemeColors.primaryColor),
                          ),
                        ),
                      ),
                      errorWidget: (context, url, error) => Container(
                        color: Colors.grey.shade100,
                        child: Icon(Icons.image_not_supported_outlined,
                            size: 28.sp, color: Colors.grey.shade400),
                      ),
                    ),
                    Container(
                      width: 120.w,
                      height: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.15),
                            Colors.transparent
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              /// Content
              Expanded(
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      /// Title
                      Text(
                        categoryTitle,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyles.heading5.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade900,
                        ),
                      ),

                      /// Accent line
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 6.h),
                        height: 1,
                        width: 35.w,
                        color: LightThemeColors.primaryColor
                            .withValues(alpha: 0.3),
                      ),

                      /// Description
                      Expanded(
                        child: Text(
                          description,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.body1.copyWith(
                            color: Colors.grey.shade600,
                            fontSize: 13.sp,
                            height: 1.35,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
