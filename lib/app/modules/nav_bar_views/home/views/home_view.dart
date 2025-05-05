import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_social_button/flutter_social_button.dart';
import 'package:lokkha/app/components/custom_drawer.dart';
import 'package:lokkha/app/data/local/my_shared_pref.dart';
import 'package:lokkha/app/helper/global.dart';
import 'package:lokkha/app/modules/contest/widgets/last_contest_result_widget.dart';
import 'package:lokkha/app/modules/contest/widgets/latest_contest_widget.dart';
import 'package:lokkha/app/modules/random_question/views/random_question_view.dart';
import 'package:lokkha/app/services/api_call_status.dart';
import 'package:lokkha/comming_soon_view.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import 'package:lokkha/config/extensions/widget_extensions.dart';
import 'package:lokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/utils/constants.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../../../../../config/constants/app_images.dart';
import '../../../../../styles/text_style.dart';
import '../../../current_affairs/views/current_affairs_view.dart';
import '../../../subject_sections/models/sub_sec_select_model.dart';
import '../../../subject_sections/views/subject_sections_view.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint("Build Home view");
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              AssetImagePaths.appIconHorizontal,
              scale: 5.8,
            ),
            const SizedBox(width: 8),
            Text(
              "সঠিক পথে, স্বল্প সময়ে",
              style: AppTextStyles.custom(fontSize: 16.00).copyWith(
                color: Get.theme.indicatorColor,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: GetBuilder<HomeController>(
        //init: HomeController(),
        builder: (controller) {
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
                child: TextFormField(
                  enabled: false, // This makes the field non-editable
                  controller: null,
                  textAlign: TextAlign.start,
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
                        EdgeInsets.symmetric(vertical: 0.0, horizontal: 12.0),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                  // onChanged: controller.onSearchChanged,
                )
                    .paddingOnly(bottom: 10.00.h, left: 15.00.w, right: 15.00.w)
                    .onTap(() {
                  Get.to(const ComingSoonPage());
                  // showSearch(
                  //     context: context, delegate: CustomSearchDelegate());
                }),
              ),
              //10.0.h.height,
              // Switch(
              //   value: MySharedPref.getThemeIsLight(),
              //   onChanged: (value) {
              //     MyTheme.changeTheme();
              //   },
              // ),
              // 10.0.h.height,
              // CustomActionButton(
              //     text: "text",
              //     onPressed: () {
              //       Get.toNamed(Routes.PREMIUM_PACKAGES);
              //     }),
              /// Second Column with others Widget
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    spacing: 5.0.h,
                    children: [
                      .0.h.height,

                      /// Carousel Slider
                      Builder(builder: (context) {
                        switch (controller.sliderApiStatus.value) {
                          case ApiCallStatus.loading:
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          case ApiCallStatus.error:
                            return const Text("Slider loading error");
                          case ApiCallStatus.holding:
                            return const SizedBox.shrink();
                          case ApiCallStatus.success:
                            return CarouselSlider(
                              options: CarouselOptions(
                                aspectRatio: 14 / 4,
                                enlargeCenterPage: true,
                                enlargeStrategy:
                                    CenterPageEnlargeStrategy.height,
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
                                    "URL IMAGE : ${AppConstants.storageUrl + sliderItem.image.toString()}");
                                return ClipRRect(
                                  borderRadius: BorderRadius.circular(7.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey.shade200,
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: isCheckedGifImage(
                                          AppConstants.storageUrl +
                                              sliderItem.image.toString()),
                                    ),
                                  ),
                                );
                              }).toList(),
                            );
                          default:
                            return const SizedBox();
                        }
                      }),

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
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10.0,
                          childAspectRatio: 4,
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
                              child: Center(
                                child: Text(
                                  title,
                                  style: AppTextStyles.heading5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      2.h.height,

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
                      const LatestContestWidget(),

                      /// Leader Board
                      const LastContestResultWidget(),

                      /// RandomQuestion area
                      RandomQuestionSelector(),
                      // Question Bank
                      Text(
                        "প্রশ্নব্যাংক",
                        style: AppTextStyles.custom(
                          fontSize: 17.00.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Builder(
                        builder: (context) {
                          switch (controller.subjectSectionApiStatus.value) {
                            case ApiCallStatus.loading:
                              return const Center(
                                  child: CircularProgressIndicator());

                            case ApiCallStatus.success:
                              return GridView.builder(
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  childAspectRatio: 4,
                                ),
                                itemCount: controller.subjectSectionModel.value
                                        .subjectSections?.length ??
                                    0,
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index) {
                                  final data = controller.subjectSectionModel
                                      .value.subjectSections![index];
                                  return GestureDetector(
                                    onTap: () async {
                                      MySharedPref.clearSubjectSection();
                                      SubjectSectionSelect newSubject =
                                          SubjectSectionSelect(
                                        id: controller
                                                .subjectSectionModel
                                                .value
                                                .subjectSections![index]
                                                .subject
                                                ?.id ??
                                            0,
                                        name: controller
                                                .subjectSectionModel
                                                .value
                                                .subjectSections![index]
                                                .subject
                                                ?.name ??
                                            '',
                                        quantity: 20,
                                      );
                                      await MySharedPref
                                          .addOrUpdateSubjectSectionSelect(
                                              newSubject);
                                      Get.to(
                                        SubjectSectionView(
                                          subject: controller
                                              .subjectSectionModel
                                              .value
                                              .subjectSections![index]
                                              .subject,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius:
                                            BorderRadius.circular(7.0),
                                        border: Border.all(
                                            color: Colors.grey, width: 0.5.w),
                                      ),
                                      child: Center(
                                        child: Text(
                                          data.name.toString(),
                                          style: AppTextStyles.body2.copyWith(
                                            height: 1.1.h,
                                            fontSize: 12.sp,
                                          ),
                                          maxLines: 2,
                                          textAlign: TextAlign.center,
                                          overflow: TextOverflow.ellipsis,
                                        ).paddingSymmetric(
                                            horizontal: 2.00.w,
                                            vertical: 5.00.h),
                                      ),
                                    ),
                                  );
                                },
                              );
                            case ApiCallStatus.error:
                              return const Center(
                                  child: Text(
                                      "কিছু ভুল হয়েছে, আবার চেষ্টা করুন"));

                            default:
                              return const SizedBox();
                          }
                        },
                      ),

                      const Divider(color: LightThemeColors.primaryColor),
                      SocialLinksScreen(),
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

class SocialLinksScreen extends StatelessWidget {
  SocialLinksScreen({Key? key}) : super(key: key);

  void _launchURL(String url) async {
    await launchUrlString(url, mode: LaunchMode.externalApplication);
  }

  final List<Map<String, dynamic>> socialLinks = [
    {
      'icon': FontAwesomeIcons.facebook,
      'color': const Color(0xFF1877F2),
      'url': 'https://www.facebook.com/lokkhabd',
      'title': 'Facebook Page',
    },
    {
      'icon': FontAwesomeIcons.facebook,
      'color': const Color(0xFF1877F2),
      'url': 'https://www.facebook.com/groups/lokkha',
      'title': 'Facebook Group',
    },
    {
      'icon': FontAwesomeIcons.youtube,
      'color': Colors.red,
      'url': 'https://www.youtube.com/channel/lokkhabd',
      'title': 'YouTube Channel',
    },
    {
      'icon': FontAwesomeIcons.whatsapp,
      'color': const Color(0xFF25D366),
      'url': 'https://wa.me/8801334260543',
      'title': 'WhatsApp',
    },
    {
      'icon': FontAwesomeIcons.xTwitter,
      'color': Colors.black,
      'url': 'https://twitter.com/lokkhabd',
      'title': 'X (Twitter)',
    },
    {
      'icon': FontAwesomeIcons.linkedin,
      'color': const Color(0xFF0A66C2),
      'url': 'https://www.linkedin.com/in/lokkhabd',
      'title': 'LinkedIn',
    },
    {
      'icon': FontAwesomeIcons.instagram,
      'color': const Color(0xFFE1306C),
      'url': 'https://www.instagram.com/lokkhabd',
      'title': 'Instagram',
    },
    {
      'icon': FontAwesomeIcons.envelope,
      'color': Colors.grey,
      'url': 'mailto:info.lokkha@gmail.com',
      'title': 'Email',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 8,
        childAspectRatio: 1,
      ),
      itemCount: socialLinks.length,
      itemBuilder: (context, index) {
        final link = socialLinks[index];
        return InkWell(
          onTap: () => _launchURL(link['url']),
          borderRadius: BorderRadius.circular(12),
          child: CircleAvatar(
            backgroundColor: link['color'],
            radius: 22,
            child: Icon(
              link['icon'],
              color: Colors.white,
              size: 18,
            ),
          ),
        );
      },
    );
  }
}

// class SocialLinksScreen extends StatelessWidget {
//   SocialLinksScreen({Key? key}) : super(key: key);
//
//   void _launchURL(String url) async {
//     Uri uri = Uri.parse(url);
//     if (await canLaunchUrl(uri)) {
//       await launchUrl(uri, mode: LaunchMode.externalApplication);
//     } else {
//       throw 'Could not launch $url';
//     }
//   }
//
//   final List<Map<String, dynamic>> socialLinks = [
//     {
//       'icon': FontAwesomeIcons.facebook,
//       'color': const Color(0xFF1877F2),
//       'url': 'https://www.facebook.com/lokkhabd',
//       'title': 'Facebook Page',
//     },
//     {
//       'icon': FontAwesomeIcons.facebook,
//       'color': const Color(0xFF1877F2),
//       'url': 'https://www.facebook.com/groups/lokkha',
//       'title': 'Facebook Group',
//     },
//     {
//       'icon': FontAwesomeIcons.youtube,
//       'color': Colors.red,
//       'url': 'https://www.youtube.com/channel/lokkhabd',
//       'title': 'YouTube Channel',
//     },
//     {
//       'icon': FontAwesomeIcons.whatsapp,
//       'color': const Color(0xFF25D366),
//       'url': 'https://wa.me/8801334260543',
//       'title': 'WhatsApp',
//     },
//     {
//       'icon': FontAwesomeIcons.x,
//       'color': Colors.black,
//       'url': 'https://twitter.com/lokkhabd',
//       'title': 'X (Twitter)',
//     },
//     {
//       'icon': FontAwesomeIcons.linkedin,
//       'color': const Color(0xFF0A66C2),
//       'url': 'https://www.linkedin.com/in/lokkhabd',
//       'title': 'LinkedIn',
//     },
//     {
//       'icon': FontAwesomeIcons.instagram,
//       'color': const Color(0xFFE1306C),
//       'url': 'https://www.instagram.com/lokkhabd',
//       'title': 'Instagram',
//     },
//     {
//       'icon': FontAwesomeIcons.envelope,
//       'color': Colors.grey,
//       'url': 'mailto:info.lokkha@gmail.com',
//       'title': 'Email',
//     },
//   ];
//
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       shrinkWrap: true,
//       physics: const NeverScrollableScrollPhysics(),
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 2,
//         crossAxisSpacing: 8.0,
//         mainAxisSpacing: 8.0,
//         childAspectRatio: 5,
//       ),
//       itemCount: socialLinks.length,
//       itemBuilder: (context, index) {
//         final link = socialLinks[index];
//         return ElevatedButton.icon(
//           onPressed: () => _launchURL(link['url']),
//           icon: Icon(
//             link['icon'],
//             size: 15,
//             color: Colors.white,
//           ),
//           label: Text(
//             link['title'],
//             style: AppTextStyles.body1.copyWith(color: Colors.white),
//           ),
//           style: ElevatedButton.styleFrom(
//             backgroundColor: link['color'],
//             padding: const EdgeInsets.symmetric(horizontal: 12.0),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(10),
//             ),
//             alignment: Alignment.centerLeft,
//           ),
//         );
//       },
//     );
//   }
// }

// class CustomSearchDelegate extends SearchDelegate {
//   final List<String> searchData = ['Apple', 'Banana', 'Orange', 'Pineapple'];
//
//   @override
//   List<Widget> buildActions(BuildContext context) {
//     return [
//       IconButton(
//         icon: const Icon(Icons.clear),
//         onPressed: () {
//           query = '';
//         },
//       ),
//     ];
//   }
//
//   @override
//   Widget buildLeading(BuildContext context) {
//     return IconButton(
//       icon: const Icon(Icons.arrow_back),
//       onPressed: () {
//         close(context, null); // সার্চ বন্ধ করা
//       },
//     );
//   }
//
//   @override
//   Widget buildResults(BuildContext context) {
//     // কোয়েরির উপর ভিত্তি করে রেজাল্ট শো করা
//     final results = searchData
//         .where((item) => item.toLowerCase().contains(query.toLowerCase()))
//         .toList();
//     return ListView.builder(
//       itemCount: results.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(results[index]),
//         );
//       },
//     );
//   }
//
//   @override
//   Widget buildSuggestions(BuildContext context) {
//     // কোয়েরির উপর ভিত্তি করে সাজেস্টশান শো করা
//     final suggestions = query.isEmpty
//         ? searchData
//         : searchData
//             .where((item) => item.toLowerCase().startsWith(query.toLowerCase()))
//             .toList();
//
//     return ListView.builder(
//       itemCount: suggestions.length,
//       itemBuilder: (context, index) {
//         return ListTile(
//           title: Text(suggestions[index]),
//           onTap: () {
//             query = suggestions[index];
//             showResults(context); // সাজার স্টেপে রেজাল্ট দেখানো
//           },
//         );
//       },
//     );
//   }
// }
