import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/exam/controllers/exam_controller.dart';
import 'package:lokkha/app/modules/subject_sections/views/read_question.dart';
import '../../../models/exam.dart';

const Color primaryColor = Color(0xFF006A4E);

class ExamDetailsDialog extends StatelessWidget {
  final Exam exam;
  const ExamDetailsDialog({super.key, required this.exam});

  @override
  Widget build(BuildContext context) {
    final examController = Get.put(ExamController());
    return Dialog(
      backgroundColor: Colors.white,
      elevation: 10,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.5, sigmaY: 1.5),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Header with primary color
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.info_outline,
                        color: Colors.white, size: 24),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Text(
                        exam.name ?? '',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    // Description
                    Align(
                      alignment: Alignment.centerLeft,
                      child: HtmlWidget(
                        exam.description ?? 'কোনো বিবরণ নেই',
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Info Cards
                    Column(
                      children: [
                        _infoCard(
                            Icons.timer, 'সময়কাল', '${exam.duration} মিনিট'),
                        _infoCard(Icons.check_circle, 'সঠিক নম্বর',
                            '${exam.positiveMark}'),
                        _infoCard(
                            Icons.cancel, 'ভুল নম্বর', '${exam.negativeMark}'),
                        _infoCard(Icons.help_outline, 'মোট প্রশ্ন',
                            '${exam.questionsCount}'),
                      ],
                    ),

                    const SizedBox(height: 28),

                    // Action Buttons
                    Obx(() {
                      return Row(
                        children: [
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: examController.isReadLoading.value
                                  ? const SizedBox.shrink()
                                  : const Icon(Icons.menu_book),
                              label: examController.isReadLoading.value
                                  ? Center(
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      ),
                                    )
                                  : const Text('প্রশ্ন পড়ুন'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor.withOpacity(0.9),
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {
                                // Handle read question

                                examController
                                    .fetchExamDetails(exam.id!.toInt());
                              },
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: ElevatedButton.icon(
                              icon: examController.isExamLoading.value
                                  ? const SizedBox.shrink()
                                  : const Icon(Icons.edit),
                              label: examController.isExamLoading.value
                                  ? Center(
                                      child: SizedBox(
                                        height: 28,
                                        width: 28,
                                        child: CircularProgressIndicator(
                                            color: Colors.white),
                                      ),
                                    )
                                  : const Text('পরীক্ষা দিন'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: primaryColor,
                                foregroundColor: Colors.white,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 14),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                elevation: 4,
                              ),
                              onPressed: () {

                                examController.startExam(exam.id!.toInt());
                              },
                            ),
                          ),
                        ],
                      );
                    }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoCard(IconData icon, String label, String value) {
    final bool isNegative = label.contains('ভুল নম্বর');

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: primaryColor.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: primaryColor.withOpacity(0.2)),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Icon(
            icon,
            size: 20,
            color: isNegative ? Colors.red : primaryColor,
          ),
          const SizedBox(width: 10),
          Text(
            '$label: ',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54,
              ),
              textAlign: TextAlign.right,
            ),
          ),
        ],
      ),
    );
  }
}
