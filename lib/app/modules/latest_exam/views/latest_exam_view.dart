import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/latest_exam_controller.dart';

class LatestExamView extends GetView<LatestExamController> {
  const LatestExamView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('LatestExamView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'LatestExamView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
