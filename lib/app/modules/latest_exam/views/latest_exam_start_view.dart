// import 'package:flutter/material.dart';
// import 'package:flutter_widget_from_html_core/flutter_widget_from_html_core.dart';
// import 'package:lokkha/app/modules/latest_exam/models/latest_exam_model.dart';
// import 'package:lokkha/styles/text_style.dart';
//
// class LatestExamStartDialog extends StatelessWidget {
//   final LatestExam latestExam;
//   const LatestExamStartDialog({super.key, required this.latestExam});
//
//   @override
//   Widget build(BuildContext context) {
//     return Dialog(
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
//       child: Padding(
//         padding: const EdgeInsets.all(20),
//         child: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             const Icon(Icons.error_outline, color: Colors.orange, size: 60),
//             const SizedBox(height: 16),
//             Text(
//               'আপনি ${latestExam.title} পরীক্ষায় দিতে চলেছেন',
//               textAlign: TextAlign.center,
//               style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               children: [
//                 _buildTextField(
//                     label: 'প্রশ্ন',
//                     value: latestExam.tag!.questions!.length.toString()),
//                 const SizedBox(width: 12),
//                 _buildTextField(
//                     label: 'পরীক্ষার সময়',
//                     value: latestExam.tag!.questions!.length.toString()),
//               ],
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 _buildTextField(
//                     label: 'পাস মার্ক',
//                     value: (latestExam.tag!.questions!.length * 40 / 100)
//                         .toString()),
//                 const SizedBox(width: 12),
//                 _buildDropdownField(label: 'নেগেটিভ মার্ক'),
//               ],
//             ),
//             const SizedBox(height: 12),
//             const Align(
//               alignment: Alignment.centerLeft,
//               child: Text(
//                 'প্রতিটি প্রশ্নের মান সমান ১',
//                 style: TextStyle(fontSize: 14, color: Colors.black54),
//               ),
//             ),
//             const SizedBox(height: 24),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 _buildButton('পরীক্ষা শুরু', Colors.redAccent, Colors.white, 0),
//                 _buildButton('পড়ুন', Colors.green, Colors.white, 8),
//                 _buildButton('বাতিল', Colors.grey.shade300, Colors.black87, 0),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _buildTextField({required String label, required String value}) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 13)),
//           const SizedBox(height: 6),
//           TextField(
//             readOnly: true,
//             controller: TextEditingController(text: value),
//             decoration: InputDecoration(
//               contentPadding:
//                   const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//               border:
//                   OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
//               isDense: true,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildDropdownField({required String label}) {
//     return Expanded(
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(label, style: const TextStyle(fontSize: 13)),
//           const SizedBox(height: 6),
//           Container(
//             padding: const EdgeInsets.symmetric(horizontal: 10),
//             decoration: BoxDecoration(
//               border: Border.all(color: Colors.black38),
//               borderRadius: BorderRadius.circular(8),
//             ),
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton<String>(
//                 value: '0.25',
//                 isExpanded: true,
//                 items: ['0.25', '0.50', '0.75']
//                     .map((value) => DropdownMenuItem(
//                           value: value,
//                           child: Text(value),
//                         ))
//                     .toList(),
//                 onChanged: (value) {},
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
//
//   Widget _buildButton(
//       String label, Color bgColor, Color textColor, double margin) {
//     return Expanded(
//       child: HorizontalMargin(
//         left: margin,
//         right: margin,
//         child: ElevatedButton(
//           onPressed: () {},
//           style: ElevatedButton.styleFrom(
//             backgroundColor: bgColor,
//             foregroundColor: textColor,
//             shape:
//                 RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//             padding: const EdgeInsets.symmetric(vertical: 3, horizontal: 3),
//           ),
//           child: Text(
//             label,
//             style: AppTextStyles.body1.copyWith(color: textColor),
//           ),
//         ),
//       ),
//     );
//   }
// }



import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/latest_exam/models/latest_exam_model.dart';
import 'package:lokkha/app/modules/subject_sections/views/read_question.dart';
import 'package:lokkha/comming_soon_view.dart';
import 'package:lokkha/styles/text_style.dart';

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
    examTimeController = TextEditingController(text: widget.latestExam.tag!.questions!.length.toString());
    selectedNegativeMark = '0.25';
  }

  @override
  void dispose() {
    examTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var questionCount = widget.latestExam.tag?.questions?.length ?? 0;
    final passMark = (questionCount * 0.4).toStringAsFixed(0);

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
                _buildReadOnlyField(label: 'প্রশ্ন', value: questionCount.toString()),
                const SizedBox(width: 12),
                _buildEditableField(label: 'পরীক্ষার সময়', controller: examTimeController),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _buildReadOnlyField(label: 'পাস মার্ক', value: passMark),
                const SizedBox(width: 12),
                _buildDropdownField(label: 'নেগেটিভ মার্ক'),
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
            const SizedBox(height: 24),
            Row(
              children: [
                _buildButton('পরীক্ষা শুরু', Colors.redAccent, Colors.white, () {
                  _navigateToNextPage(context, isStartExam: true);
                }),
                const SizedBox(width: 8),
                _buildButton('পড়ুন', Colors.green, Colors.white, () {
                  _navigateToNextPage(context, isStartExam: false);
                }),
                const SizedBox(width: 8),
                _buildButton('বাতিল', Colors.grey.shade300, Colors.black87, () {
                  Navigator.pop(context);
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToNextPage(BuildContext context, {required bool isStartExam}) {
    final time = int.tryParse(examTimeController.text) ?? 60;

    if(isStartExam){
      //   examTime: time,
      //   negativeMark: double.parse(selectedNegativeMark),
      Get.to(const ComingSoonPage());
    }else{
      Get.to(ReadQuestionView(model: widget.latestExam.tag!.questions!.toList()));
    }
  }

  Widget _buildReadOnlyField({required String label, required String value}) {
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditableField({required String label, required TextEditingController controller}) {
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
              contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
              isDense: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDropdownField({required String label}) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 13)),
          const SizedBox(height: 6),
          Container(
            height: 37.9,
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.black38),
              borderRadius: BorderRadius.circular(8),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: selectedNegativeMark,
                isExpanded: true,
                items: ['0.25', '0.50', '0.75']
                    .map((value) => DropdownMenuItem(
                  value: value,
                  child: Text(value),
                ))
                    .toList(),
                onChanged: (value) {
                  if (value != null) {
                    setState(() {
                      selectedNegativeMark = value;
                    });
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(
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
