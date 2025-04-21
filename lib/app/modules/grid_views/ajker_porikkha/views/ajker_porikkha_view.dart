import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/comming_soon_view.dart';

import '../controllers/ajker_porikkha_controller.dart';

class AjkerPorikkhaView extends GetView<AjkerPorikkhaController> {
  const AjkerPorikkhaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আজকের পরীক্ষা'),
        centerTitle: true,
      ),
      body: const ComingSoonPage(),
    );
  }
}
