import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/comming_soon_view.dart';

import '../controllers/ajker_bissho_controller.dart';

class AjkerBisshoView extends GetView<AjkerBisshoController> {
  const AjkerBisshoView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('আজকের বিশ্ব'),
        centerTitle: true,
      ),
      body:const  ComingSoonPage(),
    );
  }
}
