import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/notice_board_controller.dart';

class NoticeBoardView extends GetView<NoticeBoardController> {
  const NoticeBoardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NoticeBoardView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'NoticeBoardView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
