import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/question_bank_controller.dart';

class QuestionBankView extends GetView<QuestionBankController> {
  const QuestionBankView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QuestionBankView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'QuestionBankView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
