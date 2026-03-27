import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../../comming_soon_view.dart';
import '../controllers/question_bank_controller.dart';

class QuestionBankView extends GetView<QuestionBankController> {
  const QuestionBankView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('প্রশ্ন ব্যাংক'),
        centerTitle: true,
      ),
      body: const ComingSoonPage(),
    );
  }
}
