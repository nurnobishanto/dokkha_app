import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lokkha/app/components/custom_network_image_card.dart';

class CustomCourseCard extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String regularPrice;
  final String salePrice;
  final String rating;
  final int? enrolledCount;
  final String? duration;
  final VoidCallback onPressed;

  const CustomCourseCard({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.regularPrice,
    required this.salePrice,
    required this.rating,
    this.enrolledCount,
    this.duration,
    required this.onPressed,
  });

  String formatPrice(String price) =>
      price.contains('.') ? price.replaceAll('.00', '') : price;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        //width: 0.45.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.r,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.vertical(top: Radius.circular(8.r)),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: CustomNetworkImageCard(imageUrl: imageUrl),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(5.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 14.7.sp,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                      color: Colors.black87,
                    ),
                  ),
                  SizedBox(height: 2.h),
                  Row(
                    children: [
                      Text(
                        '৳${formatPrice(regularPrice)}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey.shade500,
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(width: 8.w),
                      Text(
                        '৳${formatPrice(salePrice)}',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const Spacer(),
                      Icon(Icons.star_rounded,
                          color: Colors.amber, size: 18.sp),
                      SizedBox(width: 2.w),
                      Text(
                        rating.padRight(2),
                        style: TextStyle(
                          fontSize: 13.sp,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
