import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class ModelTestView extends StatelessWidget {
  const ModelTestView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ModelTestView'),
        centerTitle: true,
      ),
      body: GridView.builder(
        padding: EdgeInsets.all(12.w),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 1,
          childAspectRatio: 0.68,
        ),
        itemCount: 1,
        itemBuilder: (_, __) {
          return const OnlineCourseCard();
        },
      ),
    );
  }
}

class OnlineCourseCard extends StatelessWidget {
  const OnlineCourseCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// Header Banner Image
          Container(
            width: double.infinity,
            height: 120.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(12.r),
                topRight: Radius.circular(12.r),
              ),
              image: const DecorationImage(
                image: AssetImage('assets/images/banner_image.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          // Course Info Section
          Padding(
            padding: EdgeInsets.all(12.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'ভর্তি পরীক্ষা প্রস্তুতি ব্যাচ কোর্স',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.h),

                //  Info Rows
                Row(
                  children: [
                    Icon(Icons.video_library_outlined, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text('মডিউল: 1', style: TextStyle(fontSize: 13.sp)),
                    SizedBox(width: 16.w),
                    Text('ক্লাস: 1', style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.schedule, size: 18.sp),
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Text(
                        'ক্লাস হবে: কোর্স এডমিন দ্বারা নির্ধারিত',
                        style: TextStyle(fontSize: 13.sp),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 6.h),
                Row(
                  children: [
                    Icon(Icons.calendar_today, size: 18.sp),
                    SizedBox(width: 6.w),
                    Text('শুরুর তারিখ: নির্ধারিত নয়',
                        style: TextStyle(fontSize: 13.sp)),
                  ],
                ),
                SizedBox(height: 10.h),

                // ⭐ Rating and Count
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: List.generate(
                        5,
                        (index) => Icon(
                          Icons.star_border,
                          color: Colors.orange,
                          size: 20.sp,
                        ),
                      ),
                    ),
                    Text('(0/5 - ০ রেটিং)', style: TextStyle(fontSize: 12.sp)),
                  ],
                ),
                SizedBox(height: 14.h),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
