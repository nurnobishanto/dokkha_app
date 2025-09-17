// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:lokkha/config/extensions/common_extension.dart';
//
// import '../modules/nav_bar_views/home/views/home_view.dart';
//
// class PremiumCourseCard extends StatefulWidget {
//   final CourseCategory category;
//   const PremiumCourseCard({super.key, required this.category});
//
//   @override
//   State<PremiumCourseCard> createState() => _PremiumCourseCardState();
// }
//
// class _PremiumCourseCardState extends State<PremiumCourseCard> {
//   bool _isPressed = false;
//   static const Color primaryColor = Color(0xFF006A4E);
//
//   @override
//   Widget build(BuildContext context) {
//     final screenWidth = MediaQuery.of(context).size.width;
//     final screenHeight = MediaQuery.of(context).size.height;
//
//     final cardWidth = screenWidth * 0.7; // 70% of screen width
//     final cardHeight = screenHeight * 0.22; // 22% of screen height
//     final padding = cardWidth * 0.06; // responsive padding
//     final iconSize = cardWidth * 0.08; // responsive icon size
//     final textSizeTitle = cardWidth * 0.065;
//     final textSizeSubtitle = cardWidth * 0.045;
//     final statIconSize = cardWidth * 0.05;
//     final statTextSize = cardWidth * 0.04;
//
//     return GestureDetector(
//       onTapDown: (_) => setState(() => _isPressed = true),
//       onTapUp: (_) => setState(() => _isPressed = false),
//       onTapCancel: () => setState(() => _isPressed = false),
//       onTap: () => print("Tapped ${widget.category.title}"),
//       child: AnimatedScale(
//         scale: _isPressed ? 0.97 : 1.0,
//         duration: const Duration(milliseconds: 100),
//         curve: Curves.easeInOut,
//         child: Container(
//           width: cardWidth,
//           height: cardHeight,
//           padding: EdgeInsets.all(padding),
//           decoration: BoxDecoration(
//             color: Colors.white,
//             borderRadius: BorderRadius.circular(cardWidth * 0.06),
//             border: Border.all(color: primaryColor.withOpacity(0.15), width: 1),
//             boxShadow: [
//               BoxShadow(
//                   color: primaryColor.withOpacity(0.08),
//                   blurRadius: 12,
//                   offset: const Offset(0, 4)),
//               BoxShadow(
//                   color: Colors.black.withOpacity(0.04),
//                   blurRadius: 24,
//                   offset: const Offset(0, 8)),
//             ],
//           ),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               _buildHeader(iconSize, padding),
//               SizedBox(height: cardHeight * 0.08),
//               _buildContent(textSizeTitle, textSizeSubtitle),
//               const Spacer(),
//               _buildFooter(statIconSize, statTextSize),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   Widget _buildHeader(double iconSize, double padding) {
//     return Row(
//       children: [
//         Container(
//           padding: EdgeInsets.all(padding * 0.5),
//           decoration: BoxDecoration(
//             color: primaryColor.withOpacity(0.1),
//             borderRadius: BorderRadius.circular(padding),
//             border: Border.all(color: primaryColor.withOpacity(0.2)),
//           ),
//           child:
//               Icon(widget.category.icon, color: primaryColor, size: iconSize),
//         ),
//         const Spacer(),
//         Container(
//           padding: EdgeInsets.symmetric(
//               horizontal: padding, vertical: padding * 0.4),
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.circular(padding * 0.5),
//           ),
//           child: Text(
//             "প্রিমিয়াম",
//             style: TextStyle(
//                 color: Colors.white,
//                 fontSize: iconSize * 0.45,
//                 fontWeight: FontWeight.w600),
//           ),
//         ),
//       ],
//     );
//   }
//
//   Widget _buildContent(double titleSize, double subtitleSize) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           widget.category.title,
//           style: TextStyle(
//             fontSize: titleSize,
//             fontWeight: FontWeight.bold,
//             color: Colors.grey.shade800,
//             height: 1.2,
//           ),
//         ),
//         SizedBox(height: subtitleSize * 0.5),
//         Text(
//           widget.category.subtitle,
//           style: TextStyle(
//               fontSize: subtitleSize, color: Colors.grey.shade600, height: 1.3),
//           maxLines: 2,
//           overflow: TextOverflow.ellipsis,
//         ),
//       ],
//     );
//   }
//
//   Widget _buildFooter(double iconSize, double textSize) {
//     return Row(
//       children: [
//         Flexible(
//             child: _buildStat(Icons.people_outline,
//                 widget.category.studentCount, iconSize, textSize)),
//         SizedBox(width: iconSize),
//         Container(
//             width: 1, height: iconSize * 1.2, color: Colors.grey.shade300),
//         SizedBox(width: iconSize),
//         Flexible(
//             child: _buildStat(Icons.play_circle_outline,
//                 widget.category.courseCount, iconSize, textSize)),
//         const Spacer(),
//         Icon(Icons.arrow_forward_ios,
//             size: iconSize, color: primaryColor.withOpacity(0.7)),
//       ],
//     );
//   }
//
//   Widget _buildStat(
//       IconData icon, String value, double iconSize, double textSize) {
//     return Row(
//       children: [
//         Icon(icon, size: iconSize, color: Colors.grey.shade500),
//         SizedBox(width: iconSize * 0.3),
//         Flexible(
//           child: Text(
//             value,
//             style: TextStyle(
//               fontSize: textSize,
//               fontWeight: FontWeight.w500,
//               color: Colors.grey.shade600,
//             ),
//             overflow: TextOverflow.ellipsis,
//           ),
//         ),
//       ],
//     );
//   }
// }
