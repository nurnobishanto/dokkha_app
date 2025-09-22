import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/exam_controller.dart';

class ExamView extends GetView<ExamController> {
  const ExamView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ExamView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ExamView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
