import 'package:flutter/material.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/styles/text_style.dart';

import '../../../../config/theme/light_theme_colors.dart';
import 'all_contest_view.dart';
import 'latest_contest_view.dart';

class ContestTabView extends StatelessWidget {
  const ContestTabView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: CustomAppBar(title: 'কনটেস্ট'),
        backgroundColor: LightThemeColors.primaryColor,
        body: SafeArea(
          maintainBottomViewPadding: true,
          child: Column(
            children: [
              Container(
                color: LightThemeColors.primaryColor,
                child:  TabBar(
                  indicatorColor: LightThemeColors.white,
                  labelColor: LightThemeColors.white,
                  unselectedLabelColor: Colors.white70,
                  tabs: [
                    Tab(
                      child: Text(
                        "সর্বশেষ কনটেস্ট",
                  style: AppTextStyles.heading5.copyWith(color: LightThemeColors.white)
                      ),
                    ),
                    Tab(
                      child: Text(
                        "সকল কনটেস্ট",
                        style: AppTextStyles.heading5.copyWith(color: LightThemeColors.white)
                      ),
                    ),
                  ],
                ),
              ),
              const Expanded(
                child: TabBarView(
                  children: [
                    LatestContestView(),
                    AllContestView(),
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
