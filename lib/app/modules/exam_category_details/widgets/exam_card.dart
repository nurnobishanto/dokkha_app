import 'package:flutter/material.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:lokkha/utils/date_formatter.dart';

import '../../../models/exam.dart';

class ExamCard extends StatelessWidget {
  final Exam exam;
  final VoidCallback? onTap;
  const ExamCard({super.key, required this.exam, this.onTap});

  static const Color primaryColor = Color(0xFF006A4E); // your color

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(border: Border.all(color: LightThemeColors.primaryColor.withValues(alpha: .5)),
        borderRadius: BorderRadius.circular(5)
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                exam.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,

                ),
              ),
              const SizedBox(height: 12),

              // Info Row 1
              Wrap(
                spacing: 5,
                runSpacing: 8,
                children: [
                  _infoChip(
                    Icons.help_outline,
                    '${exam.questionsCount} প্রশ্ন',
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    iconColor: Colors.blue,
                  ),
                  _infoChip(Icons.access_time, "${exam.duration} মিনিট"),
                  _infoChip(
                    Icons.star_border,
                    '${exam.possibleMark} নম্বর',
                    backgroundColor: Colors.blue.withOpacity(0.1),
                    iconColor: Colors.blue,
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // Info Row 2
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  _infoChip(
                    Icons.calendar_today,
                    'প্রকাশিত: ${DateFormatter.formatToReadable(exam.publishedAt)}',
                    backgroundColor: primaryColor.withOpacity(0.1),
                    iconColor: primaryColor,
                  ),
                  _infoChip(
                      Icons.people_alt, '${exam.examResultsCount} অ্যাটেম্পট',
                      backgroundColor: Colors.red.withOpacity(0.1),
                      iconColor: Colors.red),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoChip(IconData icon, String label,
      {Color? backgroundColor, Color? iconColor}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: backgroundColor ?? primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: iconColor ?? primaryColor),
          const SizedBox(width: 4),
          Text(
            label,
            style: TextStyle(
              fontSize: 12,
              color: iconColor ?? primaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
