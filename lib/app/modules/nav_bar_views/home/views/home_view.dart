import 'package:carousel_slider/carousel_slider.dart';
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
import '../../../../../config/constants/app_images.dart';
import '../../../../../styles/text_style.dart';
import '../../../../components/custom_transparent_divider.dart';
import '../../../../routes/app_pages.dart';
import '../../../courses/controllers/courses_controller.dart';
import '../../../exam_category/controllers/exam_category_controller.dart';
import '../../../exam_category/widgets/exam_category_card.dart';
import '../../../subject_sections/views/subject_sections_view.dart';
import '../components/social_links_widget.dart';
import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    debugPrint("Build Home view");
    // final ExamCategoryController examCategoryController =
    //     Get.put(ExamCategoryController());
    // final ExamCategoryController examCategoryController = Get.find();

    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Row(
          children: [
            Image.asset(
              AssetImagePaths.appIconHorizontal,
              scale: 5,
            ),
            8.0.w.width,
            Text(
              "সঠিক পথে, স্বল্প সময়ে",
              style: AppTextStyles.custom(fontSize: 16.00.sp).copyWith(
                color: Get.theme.indicatorColor,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: GetBuilder<HomeController>(
        builder: (controller) {
          return RefreshIndicator(
            onRefresh: () {
              return controller.refreshHomeViewData();
            },
            child: Column(
              children: [
                /// Search Bar
                Container(
                  height: Get.height / 20,
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
                      .paddingOnly(
                          bottom: 10.00.h, left: 15.00.w, right: 15.00.w)
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
                        0.h.height,

                        /// Carousel Slider
                        Builder(builder: (context) {
                          switch (controller.sliderApiStatus.value) {
                            case ApiCallStatus.loading:
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            case ApiCallStatus.error:
                              return const Text("Slider loading");
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
                                  onPageChanged: (currentIndex,
                                      carouselPageChangedReason) {
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
                                        borderRadius:
                                            BorderRadius.circular(8.0),
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

                        /// GridView for Exam
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
                                  border: Border.all(
                                      color: LightThemeColors.primaryColor,
                                      width: 1),
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

                        /// RandomQuestion area
                        RandomQuestionSelector(),
                        // 2.h.height,

                        /// Premium course area
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            2.h.height,
                            // Centered Title with dividers
                            SectionTitleWithDivider(
                                title: "প্রিমিয়াম পরীক্ষা সমূহ"),
                            5.h.height,
                            // Horizontal Scroll of Cards
                            Obx(() {
                              final examController =
                                  Get.put(ExamCategoryController());
                              final categories = examController
                                      .courseCategoriesModel
                                      .value
                                      .courseCategories ??
                                  [];

                              return SizedBox(
                                height: Get.height / 15,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: categories.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 12.w),
                                  itemBuilder: (_, x) {
                                    return ExamCategoryCard(
                                      title: categories[x].title ?? '',
                                      onTap: () {
                                        Get.toNamed(Routes.COURSES, arguments: {
                                          "course_category_id":
                                              categories[x].id,
                                          "category_name": categories[x].title,
                                        });
                                      },
                                      borderColor: LightThemeColors.primaryColor
                                          .withValues(alpha: 0.4),
                                      iconColor: LightThemeColors.primaryColor,
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),

                        /// Free course area
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            5.h.height,
                            // Centered Title with dividers
                            SectionTitleWithDivider(title: "ফ্রি পরীক্ষা সমূহ"),
                            5.h.height,
                            // Horizontal Scroll of Cards
                            Obx(() {
                              final examController =
                                  Get.put(ExamCategoryController());
                              final exams =
                                  examController.model.value.examCategories ??
                                      [];

                              return SizedBox(
                                height: Get.height / 15,
                                child: ListView.separated(
                                  scrollDirection: Axis.horizontal,
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: exams.length,
                                  separatorBuilder: (_, __) =>
                                      SizedBox(width: 12.w),
                                  itemBuilder: (_, x) {
                                    final exam = exams[x];
                                    return ExamCategoryCard(
                                      title: exam.name ?? '',
                                      onTap: () {
                                        if (exam.id != null) {
                                          Get.toNamed(
                                              Routes.EXAM_CATEGORY_DETAILS,
                                              arguments: {
                                                "category_id": exam.id,
                                                'category_name': exam.name
                                              });
                                        }
                                      },
                                      borderColor: LightThemeColors.primaryColor
                                          .withValues(alpha: 0.4),
                                      iconColor: LightThemeColors.primaryColor,
                                    );
                                  },
                                ),
                              );
                            }),
                          ],
                        ),
                        10.h.height,

                        /// Contest Area
                        const LatestContestWidget(),

                        /// Leader Board
                        const LastContestResultWidget(),

                        // Question Bank
                        Text(
                          "জনপ্রিয় প্রশ্নব্যাংক",
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
                                  itemCount: controller.subjectSectionModel
                                          .value.subjectSections?.length ??
                                      0,
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    final data = controller.subjectSectionModel
                                        .value.subjectSections![index];
                                    return GestureDetector(
                                      onTap: () async {
                                        MySharedPref.clearSubjectSection();
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

                        // spController.dashboardAds.length > 2
                        //     ? SponsorAdsWidget(
                        //   ad: spController.dashboardAds[2],
                        // )
                        //     : const SizedBox.shrink(),
                        const Divider(color: LightThemeColors.primaryColor),
                        SocialLinksScreen(),
                      ],
                    ).paddingOnly(left: 8.00.r, right: 8.00.r, bottom: 8.00.r),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
