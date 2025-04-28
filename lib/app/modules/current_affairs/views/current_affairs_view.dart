import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/modules/current_affairs/views/current_affairs_content_view.dart';
import '../../../../styles/text_style.dart';
import '../controllers/current_affairs_controller.dart';
import 'international_current_affairs_content_view.dart';

class CurrentAffairsView extends GetView<CurrentAffairsController> {
  const CurrentAffairsView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // দুটি ট্যাব থাকবে
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "কারেন্ট অ্যাফেয়ার্স",
            style: AppTextStyles.heading4.copyWith(color: Colors.white),
          ),
          bottom: TabBar(
            labelStyle: AppTextStyles.heading4.copyWith(color: Colors.white),
            indicatorColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            tabs: const [
              Tab(text: 'বাংলাদেশ'),
              Tab(text: 'আন্তর্জাতিক'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CurrentAffairsContentView(),
            InternationalCurrentAffairsContentView(),
          ],
        ),
      ),
    );
  }
}
