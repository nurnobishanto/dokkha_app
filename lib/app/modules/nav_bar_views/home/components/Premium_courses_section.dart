// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lokkha/config/extensions/common_extension.dart';
//
// import '../../../../components/premium_courses_card.dart';
// import '../views/home_view.dart';
//
// class PremiumCoursesSection extends StatelessWidget {
//   PremiumCoursesSection({super.key});
//
//   static const Color primaryColor = Color(0xFF006A4E);
//
//   final List<CourseCategory> categories = [
//     CourseCategory(
//         title: "মেডিকেল ভর্তি",
//         subtitle: "MBBS ও BDS প্রস্তুতি",
//         icon: Icons.medical_services_outlined,
//         studentCount: "১৫,০০০+",
//         courseCount: "১২৫+"),
//     CourseCategory(
//         title: "ইঞ্জিনিয়ারিং",
//         subtitle: "BUET ও অন্যান্য বিশ্ববিদ্যালয়",
//         icon: Icons.engineering_outlined,
//         studentCount: "১২,৫০০+",
//         courseCount: "৯৮+"),
//     CourseCategory(
//         title: "বিশ্ববিদ্যালয়",
//         subtitle: "A ও B ইউনিট প্রস্তুতি",
//         icon: Icons.school_outlined,
//         studentCount: "১৮,০০০+",
//         courseCount: "১৫৫+"),
//     CourseCategory(
//         title: "এইচএসসি",
//         subtitle: "সকল শাখার সম্পূর্ণ প্রস্তুতি",
//         icon: Icons.book_outlined,
//         studentCount: "২৫,০০০+",
//         courseCount: "২২০+"),
//     CourseCategory(
//         title: "চাকরি প্রস্তুতি",
//         subtitle: "BCS ও ব্যাংক জব",
//         icon: Icons.work_outline,
//         studentCount: "৮,৫০০+",
//         courseCount: "৭৫+"),
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final cardHeight = MediaQuery.of(context).size.height * 0.18; // 22% of screen height
//     final cardWidth = screenWidth * 0.7; // 70% of screen width
//
//     return Container(
//       color: Colors.grey.shade50,
//       padding: EdgeInsets.symmetric(vertical: 24.h),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildTitleSection(screenWidth),
//           SizedBox(height: 20.h),
//           SizedBox(
//             height: cardHeight,
//             child: ListView.separated(
//               padding: EdgeInsets.symmetric(horizontal: 20.w),
//               scrollDirection: Axis.horizontal,
//               physics: const BouncingScrollPhysics(),
//               itemCount: categories.length,
//               separatorBuilder: (_, __) => SizedBox(width: 16.w),
//               itemBuilder: (_, index) => SizedBox(
//                   width: cardWidth,
//                   child: PremiumCourseCard(category: categories[index])),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildTitleSection(double screenWidth) {
//     return
//     Padding(
//       padding: EdgeInsets.symmetric(horizontal: 20.w),
//       child: Row(
//         children: [
//           Expanded(child: _buildDivider(beginTransparent: true)),
//           Padding(
//             padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.05),
//             child: Text(
//               "প্রিমিয়াম কোর্স সমূহ",
//               style: TextStyle(
//                   fontSize: 20.sp,
//                   fontWeight: FontWeight.bold,
//                   color: primaryColor,
//                   letterSpacing: 0.5),
//             ),
//           ),
//           Expanded(child: _buildDivider(beginTransparent: false)),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDivider({required bool beginTransparent}) {
//     return Container(
//       height: 1.5,
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//           colors: beginTransparent
//               ? [
//             Colors.transparent,
//             primaryColor.withOpacity(0.3),
//             primaryColor.withOpacity(0.6)
//           ]
//               : [
//             primaryColor.withOpacity(0.6),
//             primaryColor.withOpacity(0.3),
//             Colors.transparent
//           ],
//         ),
//       ),
//     );
//   }
// }
