import 'package:dokkha/app/components/custom_drawer.dart';
import 'package:dokkha/config/extensions/widget_extensions.dart';
import 'package:dokkha/config/theme/light_theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../../../config/constants/app_images.dart';
import '../controllers/home_controller.dart';

// showSearch(
// context: context, delegate: CustomSearchDelegate());
class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const CustomDrawer(),
      appBar: AppBar(
        title: Image.asset(AssetImagePaths.appIcon),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications),
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
                decoration: const BoxDecoration(
                  color: LightThemeColors.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(8.0),
                    bottomRight: Radius.circular(8.0),
                  ),
                ),
                child: TextFormField(
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
                )
                    .paddingOnly(bottom: 10.00.h, left: 15.00.w, right: 15.00.w)
                    .onTap(() {
                  print("Hello");
                  showSearch(
                      context: context, delegate: CustomSearchDelegate());
                }),
              ),

              Column(
                spacing: 10.0.h,
                children: [
                  ConstrainedBox(
                    constraints: const BoxConstraints(maxHeight: 100),
                    child: CarouselView(
                      itemExtent: 330,
                      shrinkExtent: 200,
                      padding: const EdgeInsets.all(10.0),
                      children: List.generate(
                        controller.images.length,
                        (index) => Image.asset(
                          "assets/images/${controller.images[index]}",
                          fit: BoxFit.cover,
                        ).onTap(() {
                          print("tapped");
                        }),
                      ),
                    ),
                  ),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // 3 items per row
                      crossAxisSpacing: 8.0, // Spacing between columns
                      mainAxisSpacing: 8.0, // Spacing between rows
                    ),
                    itemCount: controller.gridViewRoutePage.length,
                    itemBuilder: (c, i) {
                      return Container(
                        color:
                            Colors.blue, // Different color for each container
                        child: Center(
                          child: Text(
                            controller.gridViewTitle[i],
                            style: const TextStyle(color: Colors.white),
                          ),
                        ),
                      ).cornerRadiusWithClipRRect(10).onTap(() {
                        print('Tapped!');
                        Get.toNamed(controller.gridViewRoutePage[i]);
                      });
                    },
                  ),
                ],
              ).paddingAll(8.00.r),
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
