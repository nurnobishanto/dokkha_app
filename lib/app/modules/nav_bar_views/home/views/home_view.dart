import 'package:carousel_slider/carousel_slider.dart';
import 'package:lokkha/app/components/custom_drawer.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/extensions/widget_extensions.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../config/constants/app_images.dart';
import '../../../../../styles/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../components/home_components.dart';
import '../components/random_question_selector.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint("Build Home view");
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Image.asset(AssetImagePaths.appIconHorizontal,scale: 3.8),
        actions: [
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: const Icon(Icons.person),
          ),
          SizedBox(width: 10.w),
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Column(
            children: [

              /// Search Bar
              Container(
                decoration: BoxDecoration(
                  color: LightThemeColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0.r),
                    bottomRight: Radius.circular(10.0.r),
                  ),
                ),
                child: Column(
                  children: [
                    10.h.height,
                    TextFormField(
                      enabled: false, // This makes the field non-editable
                      controller: null,
                      decoration: const InputDecoration(
                        hintText: "অনুসন্ধান করুন",
                        prefixIcon: Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.grey),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          borderSide: BorderSide(color: Colors.blue),
                        ),
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10.0, horizontal: 12.0),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      // onChanged: controller.onSearchChanged,
                    ),
                  ],
                )
                    .paddingOnly(bottom: 10.00.h, left: 15.00.w, right: 15.00.w)
                    .onTap(() {
                  print("Hello");
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                }),
              ),

              /// Second Column with others Widget
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 10.0.h,
                    children: [
                      .0.h.height,

                      /// Carousel Slider
                      CarouselSlider(
                        options: CarouselOptions(
                          aspectRatio: 14 / 4,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height,
                          autoPlay: true,
                          viewportFraction: 1.0,
                          onPageChanged:
                              (currentIndex, carouselPageChangedReason) {
                            controller.dotsCount = currentIndex;
                          },
                        ),
                        items: controller.sliderImages.map((sliderItem) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(7.0),
                            child: Container(
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(
                                    AssetImagePaths.appleImg,
                                  ),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                      ),

                      /// Dots Indicator Area
                      DotsIndicator(
                        dotsCount: controller
                            .sliderImages.length, // Total number of dots
                        position: controller
                            .currentPosition, // Current active dot position
                        decorator: const DotsDecorator(
                          color: LightThemeColors.accentColor,
                          activeColor: LightThemeColors.primary,
                          size: Size(8.0, 8.0), // Dot size
                          activeSize: Size(
                              10.0, 10.0), // Optional: active dot size (larger)
                          spacing: EdgeInsets.symmetric(
                              horizontal:
                                  4.0), // Optional: spacing between dots
                        ),
                      ),

                      /// GridView for GridView
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: .0,
                          mainAxisSpacing: .0,
                          childAspectRatio: 1.2,
                        ),
                        itemCount: controller.gridViewTitle.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (x, i) {
                          final color = controller.gridColors[i];
                          final image = controller.gridImages[i];
                          final title = controller.gridViewTitle[i];
                          final route = controller.gridViewRoutePage[i];
                          return GestureDetector(
                            onTap: () => Get.toNamed(route),
                            child: Container(
                              margin: const EdgeInsets.all(5.0),
                              decoration: BoxDecoration(
                                color: color,
                                borderRadius: BorderRadius.circular(12.0),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.blue.withValues(alpha: 0.1),
                                    blurRadius: 2.0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    height: 40.0.h,
                                    width: 40.0.w,
                                    child: FittedBox(
                                      child: Image.asset(
                                        "assets/images/$image",
                                        opacity:
                                            const AlwaysStoppedAnimation(0.9),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  ).center().paddingSymmetric(
                                      horizontal: 3, vertical: 4),
                                  Text(
                                    title,
                                    style: TextStyle(
                                      color:
                                          Colors.black.withValues(alpha: 0.8),
                                      fontSize: 13.2,
                                      fontWeight: FontWeight.w500,
                                    ),
                                    textAlign: TextAlign.center,
                                  ).paddingSymmetric(
                                      horizontal: 3, vertical: 4),
                                ],
                              ),
                            ),
                          );
                        },
                      ),

                      /// Contest Area
                      ClipRRect(
                        borderRadius: BorderRadius.circular(7.0),
                        child: Stack(
                          children: [
                            Image.asset(
                              AssetImagePaths.appleImg,
                              height: 110.0.h,
                              width: double.infinity,
                              fit: BoxFit.fitWidth,
                            ),
                            Positioned(
                              top: 8.0,
                              left: 8.0,
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.black54,
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                child: Text(
                                  "${controller.hours.toString().padLeft(2, '0')}:"
                                  "${controller.minutes.toString().padLeft(2, '0')}:"
                                  "${controller.seconds.toString().padLeft(2, '0')}",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      /// RandomQuestion area
                      CustomOptionSelector(
                        title: 'একটি নির্বাচন করুন: ',
                        options: controller.randomQuestionOptions,
                        selectedOptionIndex: controller.selectedOptionIndex,
                        onOptionSelected: (i) {
                          controller.selectedOptionIndex = i;
                        },
                      ),

                      //5.0.h.height,

                      /// Leader Board
                      Text(
                        "আজকের বিজয়ী",
                        style: AppTextStyles.custom(
                          fontSize: 17.00.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(horizontal: 10.0.r),
                        color: Colors.green.shade100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            controller.leaders.length >= 3
                                ? 3
                                : controller.leaders.length,
                            (index) {
                              int displayRank;
                              if (index == 0) {
                                displayRank = 2;
                              } else if (index == 1) {
                                displayRank = 1;
                              } else {
                                displayRank = controller.leaders[index];
                              }

                              double topPadding;
                              if (index == 1) {
                                topPadding = 10;
                              } else {
                                topPadding = 20;
                              }

                              return Expanded(
                                child: Padding(
                                  padding: EdgeInsets.only(top: topPadding),
                                  child: buildTopRankedUser(
                                    imagePath: AssetImagePaths.appleImg,
                                    name: 'Sadman',
                                    rank: displayRank,
                                    isFirst: displayRank == 1,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ).paddingOnly(left: 8.00.r, right: 8.00.r, bottom: 8.00.r),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  final List<String> searchData = ['Apple', 'Banana', 'Orange', 'Pineapple'];

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = ''; // সার্চ কোয়েরি ক্লিয়ার করা
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // সার্চ বন্ধ করা
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // কোয়েরির উপর ভিত্তি করে রেজাল্ট শো করা
    final results = searchData
        .where((item) => item.toLowerCase().contains(query.toLowerCase()))
        .toList();
    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // কোয়েরির উপর ভিত্তি করে সাজেস্টশান শো করা
    final suggestions = query.isEmpty
        ? searchData
        : searchData
            .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
            .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            query = suggestions[index];
            showResults(context); // সাজার স্টেপে রেজাল্ট দেখানো
          },
        );
      },
    );
  }
}
