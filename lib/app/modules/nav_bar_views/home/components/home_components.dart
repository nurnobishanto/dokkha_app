import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

Widget buildTopRankedUser({
  required String imagePath,
  required int id,
  required int rank,
  bool isFirst = false,
}) {
  final double outerRadius = isFirst ? 30.r : 22.r;
  final double innerRadius = isFirst ? 28.r : 20.r;

  return Column(
    children: [
      Stack(
        clipBehavior: Clip.none,
        children: [
          CircleAvatar(
            radius: outerRadius,
            backgroundColor: Colors.blue,
            child: CircleAvatar(
              radius: innerRadius,
              backgroundImage: AssetImage(imagePath),
            ),
          ),
          Positioned(
            top: -4.r,
            right: -6.r,
            child: CircleAvatar(
              radius: 11.r,
              backgroundColor: Colors.green,
              child: Text(
                '$rank',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
      Text(
        "ID: $id",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontSize: 14.sp,
        ),
      ),
    ],
  ).paddingAll(5.r);
}
