import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/comming_soon_view.dart';

import '../controllers/jobs_update_controller.dart';

class JobsUpdateView extends GetView<JobsUpdateController> {
  const JobsUpdateView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('চাকরির আপডেট'),
        centerTitle: true,
      ),
      body:const ComingSoonPage(),
    );
  }
}
