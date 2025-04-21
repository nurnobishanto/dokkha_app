import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:lokkha/app/modules/grid_views/mock_test/views/mock_test_view.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../fast_practice/views/fast_practice_view.dart';
import '../controllers/mock_test_tab_controller.dart';

class MockTestTabView extends GetView<MockTestTabController> {
  const MockTestTabView({super.key});
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              SizedBox(height: 20.0),
              TabBar(
                indicatorColor: LightThemeColors.primaryColor,
                labelColor: LightThemeColors.primaryColor,
                unselectedLabelColor: Colors.grey,
                tabs: [
                  Tab(
                    child: Text(
                      "মক পরীক্ষা",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                  Tab(
                    child: Text(
                      "Coming",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    MockTestView(),
                    FastPracticeView(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
