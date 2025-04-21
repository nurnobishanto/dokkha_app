import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/comming_soon_view.dart';

import '../controllers/notice_board_controller.dart';

class NoticeBoardView extends GetView<NoticeBoardController> {
  const NoticeBoardView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('নোটিশ বোর্ড'),
        centerTitle: true,
      ),
      body:const ComingSoonPage(),
    );
  }
}
