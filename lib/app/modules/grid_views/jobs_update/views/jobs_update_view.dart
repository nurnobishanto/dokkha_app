import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/jobs_update_controller.dart';

class JobsUpdateView extends GetView<JobsUpdateController> {
  const JobsUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('JobsUpdateView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'JobsUpdateView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
