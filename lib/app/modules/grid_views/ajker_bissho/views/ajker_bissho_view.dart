import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/ajker_bissho_controller.dart';

class AjkerBisshoView extends GetView<AjkerBisshoController> {
  const AjkerBisshoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AjkerBisshoView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'AjkerBisshoView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
