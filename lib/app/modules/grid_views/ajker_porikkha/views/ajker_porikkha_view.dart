import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ajker_porikkha_controller.dart';

class AjkerPorikkhaView extends GetView<AjkerPorikkhaController> {
  const AjkerPorikkhaView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjkerPorikkhaView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AjkerPorikkhaView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
