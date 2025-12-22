import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/latest_exam/models/latest_exam_model.dart';
import 'package:lokkha/styles/text_style.dart';
import '../controllers/latest_exam_controller.dart';

class LatestExamStartDialog extends StatefulWidget {
  final LatestExam latestExam;

  const LatestExamStartDialog({super.key, required this.latestExam});

  @override
  State<LatestExamStartDialog> createState() => _LatestExamStartDialogState();
}

class _LatestExamStartDialogState extends State<LatestExamStartDialog> {
  late TextEditingController examTimeController;
  late String selectedNegativeMark;

  @override
  void initState() {
    super.initState();
    examTimeController = TextEditingController(
        text: widget.latestExam.tag!.questionCount.toString());
    selectedNegativeMark = '0.25';
  }

  @override
  void dispose() {
    examTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var questionCount = widget.latestExam.tag?.questionCount ?? 0;
    (questionCount * 0.4).toStringAsFixed(0);

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Icon(Icons.error_outline, color: Colors.orange, size: 60),
            const SizedBox(height: 16),
            Text(
              'আপনি ${widget.latestExam.title} পরীক্ষায় দিতে চলেছেন',
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                _readOnlyField(
                    label: 'প্রশ্ন', value: questionCount.toString()),
                const SizedBox(width: 12),
                _editableField(
                    label: 'পরীক্ষার সময়', controller: examTimeController),
              ],
            ),
            const SizedBox(height: 12),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'প্রতিটি প্রশ্নের মান সমান ১',
                style: TextStyle(fontSize: 14, color: Colors.black54),
              ),
            ),
            // const SizedBox(height: 24),
            Row(
              children: [
                _button('পরীক্ষা শুরু', Colors.redAccent, Colors.white, () {
                  Get.find<LatestExamController>().fetchTagQuestions(
                    widget.latestExam.tag!,
                    true,
                    int.tryParse(examTimeController.text) ?? 60,
                    selectedNegativeMark,
                    context,
                  );
                }),
                const SizedBox(width: 8),
                _button('পড়ুন', Colors.green, Colors.white, () {
                  Get.find<LatestExamController>().fetchTagQuestions(
                    widget.latestExam.tag!,
                    false,
                    int.tryParse(examTimeController.text) ?? 60,
                    selectedNegativeMark,
                    context,
                  );
                }),
                const SizedBox(width: 8),
                _button('বাতিল', Colors.grey.shade300, Colors.black87, () {
                  Navigator.pop(context);
                }),
              ],
            ),
            Obx(() {
              return Column(children: [
                if (Get.find<LatestExamController>()
                    .isLoadingQuestion
                    .value) ...[
                  const SizedBox(height: 20),
                  CircularProgressIndicator()
                ]
              ]);
            })
          ],
        ),
      ),
    );
  }

  Widget _readOnlyField({required String label, required String value}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            readOnly: true,
            controller: TextEditingController(text: value),
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _editableField(
      {required String label, required TextEditingController controller}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          TextField(
            controller: controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _button(
    String label,
    Color bgColor,
    Color textColor,
    VoidCallback onPressed,
  ) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: bgColor,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(vertical: 12),
        ),
        child: Text(
          label,
          style: AppTextStyles.body1.copyWith(color: textColor),
        ),
      ),
    );
  }
}
