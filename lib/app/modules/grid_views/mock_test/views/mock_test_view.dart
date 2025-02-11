import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/mock_test_controller.dart';

class MockTestView extends GetView<MockTestController> {
  const MockTestView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MockTestView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'MockTestView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
