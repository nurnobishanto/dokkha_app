import 'package:carousel_slider/carousel_slider.dart';
import 'package:lokkha/app/components/custom_action_button.dart';
import 'package:lokkha/app/components/custom_drawer.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/modules/random_question/views/random_question_view.dart';
import 'package:lokkha/comming_soon_view.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/extensions/widget_extensions.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/utils/constants.dart';
import '../../../../../config/constants/app_images.dart';
import '../../../../../config/theme/my_theme.dart';
import '../../../../../styles/text_style.dart';
import '../../../../routes/app_pages.dart';
import '../../../current_affairs/views/current_affairs_view.dart';
import '../components/home_components.dart';
import '../components/random_question_selector.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint("Build Home view");
    debugPrint("Get token ${MySharedPref.getUserToken()}");
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Image.asset(AssetImagePaths.appIconHorizontal, scale: 5.8),
        actions: [
          Text(
            "সঠিক পথ, স্বল্প খরচ",
            style: AppTextStyles.custom(fontSize: 16.00).copyWith(
              color: Get.theme.indicatorColor,
            ),
          ),
          70.w.width,
          IconButton(
            onPressed: () {
              Get.toNamed(Routes.PROFILE);
            },
            icon: const Icon(Icons.person),
          ),
          10.w.width,
        ],
      ),
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (_) {
          return Column(
            children: [
              /// Search Bar
              Container(
                height: 40.00,
                decoration: BoxDecoration(
                  color: LightThemeColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10.0.r),
                    bottomRight: Radius.circular(10.0.r),
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      10.w.width,
                      Expanded(
                        flex: 2,
                        child: Center(
                          child: TextFormField(
                            enabled: false, // This makes the field non-editable
                            controller: null,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                              hintText: "অনুসন্ধান করুন",
                              prefixIcon: Icon(Icons.search),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.grey),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 12.0),
                              filled: true,
                              fillColor: Colors.white,
                            ),
                            // onChanged: controller.onSearchChanged,
                          ),
                        ),
                      ),
                      10.w.width,
                      Expanded(
                        flex: 3,
                        child: CustomActionButton(
                          text: "সম্পূর্ণ অ্যাক্সেস পেতে ক্লিক করুন",
                          onPressed: () {},
                          btnBackgroundColor: Colors.transparent,
                        ),
                      ),
                    ],
                  )
                      .paddingOnly(
                          bottom: 10.00.h, left: 15.00.w, right: 15.00.w)
                      .onTap(() {
                    print("Hello");
                    showSearch(
                        context: context, delegate: CustomSearchDelegate());
                  }),
                ),
              ),
              //10.0.h.height,
              // Switch(
              //   value: MySharedPref.getThemeIsLight(),
              //   onChanged: (value) {
              //     MyTheme.changeTheme();
              //   },
              // ),
              // 10.0.h.height,

              /// Second Column with others Widget
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 5.0.h,
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
                        items: controller.sliderModel.value.sliders!
                            .map((sliderItem) {
                          debugPrint(
                              "URLL IMAGE : ${AppConstants.storageUrl + sliderItem.image.toString()}");
                          return ClipRRect(
                              borderRadius: BorderRadius.circular(7.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: Image.network(
                                    AppConstants.storageUrl +
                                        sliderItem.image.toString(),
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Image.network(
                                          "https://media.istockphoto.com/id/827247322/vector/danger-sign-vector-icon-attention-caution-illustration-business-concept-simple-flat-pictogram.jpg?s=612x612&w=0&k=20&c=BvyScQEVAM94DrdKVybDKc_s0FBxgYbu-Iv6u7yddbs=");
                                    },
                                  ),
                                ),
                              ));
                        }).toList(),
                      ),

                      /// Dots Indicator Area
                      // DotsIndicator(
                      //   dotsCount: controller
                      //       .sliderImages.length, // Total number of dots
                      //   position: controller
                      //       .currentPosition, // Current active dot position
                      //   decorator: const DotsDecorator(
                      //     color: LightThemeColors.accentColor,
                      //     activeColor: LightThemeColors.primaryColor,
                      //     size: Size(8.0, 8.0), // Dot size
                      //     activeSize: Size(
                      //         10.0, 10.0), // Optional: active dot size (larger)
                      //     spacing: EdgeInsets.symmetric(
                      //         horizontal:
                      //             4.0), // Optional: spacing between dots
                      //   ),
                      // ),
                      2.0.h.height,

                      /// GridView for GridView
                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 2,
                        ),
                        itemCount: controller.gridViewTitle.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (x, i) {
                          //final color = controller.gridColors[i];
                          //final image = controller.gridImages[i];
                          final title = controller.gridViewTitle[i];
                          final route = controller.gridViewRoutePage[i];
                          return GestureDetector(
                            onTap: () => Get.to(route),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.00, horizontal: 4.00),
                              decoration: BoxDecoration(
                                color: LightThemeColors.white,
                                borderRadius: BorderRadius.circular(7.0),
                                border:
                                    Border.all(color: Colors.grey, width: .5),
                              ),
                              child: Text(
                                title,
                                style: AppTextStyles.heading5,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          );
                        },
                      ),
                      5.h.height,

                      InkWell(
                        onTap: () => Get.to(const CurrentAffairsView()),
                        child: Container(
                          height: 40,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(7.00),
                            border: Border.all(
                                color: LightThemeColors.primaryColor),
                          ),
                          child: Center(
                            child: Text(
                              "কারেন্ট অ্যাফেয়ার্স",
                              style: AppTextStyles.heading5.copyWith(
                                  color: LightThemeColors.primaryColor),
                            ),
                          ),
                        ),
                      ),
                      5.h.height,

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

                      /// Leader Board
                      Text(
                        "সর্বশেষ বিজয়ীদের তালিকা ",
                        style: AppTextStyles.custom(
                          fontSize: 17.00.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Container(
                        color: Colors.green.shade50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: List.generate(
                            controller.leaders.length >= 3
                                ? 3
                                : controller.leaders.length,
                            (index) {
                              int displayRank = index == 0
                                  ? 2
                                  : index == 1
                                      ? 1
                                      : index +
                                          1; // can change this based on actual data

                              double topPadding = index == 1 ? 5.h : 30.h;

                              return Padding(
                                padding: EdgeInsets.only(top: topPadding),
                                child: buildTopRankedUser(
                                  imagePath: AssetImagePaths.appleImg,
                                  id: 23,
                                  rank: displayRank,
                                  isFirst: displayRank == 1,
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                      5.h.height,

                      /// RandomQuestion area
                      RandomQuestionSelector(),

                      Text(
                        "জনপ্রিয় সেকশন",
                        style: AppTextStyles.custom(
                          fontSize: 17.00.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),

                      GridView.builder(
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 4,
                        ),
                        itemCount: controller.gridViewTitle2.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (x, i) {
                          final image = controller.gridImages2[i];
                          final title = controller.gridViewTitle2[i];
                          // final route = controller.gridViewRoutePage[i];
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(7.0),
                                  border: Border.all(
                                      color: Colors.grey, width: .5.w)),
                              child: Center(
                                child: Text(
                                  title,
                                  style: AppTextStyles.body2.copyWith(
                                    height: 1.1.h,
                                    fontSize: 12.sp,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                ).paddingSymmetric(
                                    horizontal: 2.00.w, vertical: 5.00.h),
                              ),
                            ),
                          );
                        },
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
          query = '';
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
