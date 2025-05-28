import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/components/custom_app_bar.dart';
import 'package:lokkha/app/modules/vocabulary/controllers/vocabulary_controller.dart';
import 'package:lokkha/config/extensions/common_extension.dart';
import '../../../../config/theme/light_theme_colors.dart';
import '../../../components/custom_search_bar.dart';
import '../../../models/category.dart';

class VocabularyView extends StatelessWidget {
  const VocabularyView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VocabularyController());
    final scrollController = ScrollController();
    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 200) {
        controller.fetchVocabulary(); // Safe fetch handled in controller
      }
    });
    return Scaffold(
      appBar: const CustomAppBar(title: 'Vocabulary'),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: controller.isLoading.value
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Column(
                    children: [
                      CustomSearchBar(
                        onChanged: null,
                        hintText: 'Search Vocabulary...',
                      ),
                      10.0.height,
                      FilterRow(vocabularyController: controller),
                      10.0.height,
                      Center(
                        child: Wrap(
                          spacing: 4,
                          runSpacing: 4,
                          alignment: WrapAlignment.center,
                          children:
                              controller.model.value.alphabets!.map((char) {
                            return InkWell(
                              onTap: () {
                                controller.selectedAlphabet.value =
                                    char.toString();
                                controller.currentPage.value = 1;
                                controller.fetchVocabulary();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: 4.0.r, horizontal: 10),
                                decoration: BoxDecoration(
                                  color:
                                      char == controller.selectedAlphabet.value
                                          ? LightThemeColors.primaryColor
                                          : LightThemeColors.white,
                                  borderRadius: BorderRadius.circular(8),
                                  boxShadow: [
                                    BoxShadow(
                                      color:
                                          Colors.black.withValues(alpha: 0.05),
                                      spreadRadius: 1,
                                      blurRadius: 5,
                                      offset: const Offset(0, 2),
                                    )
                                  ],
                                ),
                                child: Text(
                                  char,
                                  style: TextStyle(
                                      color: char ==
                                              controller.selectedAlphabet.value
                                          ? LightThemeColors.white
                                          : LightThemeColors.primaryColor),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      5.h.height,
                      Divider(),
                      5.h.height,
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount:
                            controller.model.value.vocabularies?.data?.length ??
                                0,
                        itemBuilder: (_, index) {
                          final vocab =
                              controller.model.value.vocabularies!.data![index];

                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: Get.context!,
                                builder: (_) => AlertDialog(
                                  title: Text(vocab.word ?? 'No Word'),
                                  content: SingleChildScrollView(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (vocab.details != null &&
                                            vocab.details!.isNotEmpty)
                                          Text("Details: ${vocab.details}"),
                                        const SizedBox(height: 10),
                                        _buildPopupList(
                                            "Synonyms",
                                            vocab.synonym,
                                            LightThemeColors.primaryColor),
                                        _buildPopupList(
                                            "Antonyms",
                                            vocab.antonym,
                                            LightThemeColors.primaryColor),
                                        _buildPopupList("Wrong Synonyms",
                                            vocab.wrongSynonym, Colors.red),
                                        _buildPopupList("Wrong Antonyms",
                                            vocab.wrongAntonym, Colors.red),
                                      ],
                                    ),
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Get.back(),
                                      child: const Text("Close"),
                                    )
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 6),
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                border: Border.all(color: Colors.grey.shade300),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                vocab.word ?? '',
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                            ),
                          );
                        },
                      ),
                      10.0.height,
                      Divider(),
                      10.0.height,
                      if (controller.totalPages.value > 1)
                        Obx(() => SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // First Page
                                  IconButton(
                                    onPressed: controller.currentPage.value > 1
                                        ? controller.firstPage
                                        : null,
                                    icon: Icon(Icons.first_page),
                                  ),

                                  // Previous Page
                                  IconButton(
                                    onPressed: controller.currentPage.value > 1
                                        ? controller.previousPage
                                        : null,
                                    icon: Icon(Icons.navigate_before),
                                  ),

                                  // Numbered Buttons (show max 5 at a time)
                                  ...List.generate(controller.totalPages.value,
                                      (index) => index + 1).where((page) {
                                    int current = controller.currentPage.value;
                                    return (page >= current - 2 &&
                                            page <= current + 2) ||
                                        page == 1 ||
                                        page == controller.totalPages.value;
                                  }).map((page) {
                                    bool isActive =
                                        page == controller.currentPage.value;
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 2),
                                      child: ElevatedButton(
                                        onPressed: () =>
                                            controller.goToPage(page),
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 6),
                                          backgroundColor: isActive
                                              ? LightThemeColors.primaryColor
                                              : Colors.grey.shade200,
                                          foregroundColor: isActive
                                              ? Colors.white
                                              : Colors.black87,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(6),
                                          ),
                                        ),
                                        child: Text("$page"),
                                      ),
                                    );
                                  }),

                                  // Next Page
                                  IconButton(
                                    onPressed: controller.currentPage.value <
                                            controller.totalPages.value
                                        ? controller.nextPage
                                        : null,
                                    icon: Icon(Icons.navigate_next),
                                  ),

                                  // Last Page
                                  IconButton(
                                    onPressed: controller.currentPage.value <
                                            controller.totalPages.value
                                        ? controller.lastPage
                                        : null,
                                    icon: Icon(Icons.last_page),
                                  ),
                                ],
                              ),
                            )),
                    ],
                  ),
          ),
        );
      }),
    );
  }
}

class FilterRow extends StatelessWidget {
  final VocabularyController vocabularyController;
  const FilterRow({super.key, required this.vocabularyController});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Obx(
          () => SizedBox(
            height: 35.0.h,
            width: Get.width * 0.45,
            child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: DropdownButton<Category>(
                  isExpanded: true,
                  value: vocabularyController.selectedType.value,
                  hint: Text('Select Type'),
                  underline: SizedBox(),
                  icon: Icon(Icons.arrow_drop_down),
                  items: (vocabularyController.model.value.types ?? [])
                      .map((type) {
                    return DropdownMenuItem<Category>(
                      value: type,
                      child: Text(type.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      vocabularyController.currentPage.value = 1;
                      vocabularyController.setType(value);
                      vocabularyController.selectedAlphabet.value = '';
                      vocabularyController.fetchVocabulary();
                    }
                  },
                )),
          ),
        ),

        const SizedBox(width: 10),

        /// Category Dropdown
        Obx(() => SizedBox(
              height: 35.0.h,
              width: Get.width * 0.45,
              child: Container(
                width: double.infinity,
                height: 35.0.h,
                padding: const EdgeInsets.symmetric(horizontal: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.grey.shade300),
                  borderRadius: BorderRadius.circular(8.0.r),
                ),
                child: DropdownButton<Category>(
                  isExpanded: true,
                  value: vocabularyController.selectedCategory.value,
                  underline: const SizedBox(),
                  hint: Text('Select Category'),
                  icon: const Icon(Icons.arrow_drop_down),
                  items: (vocabularyController.model.value.categories ?? [])
                      .map((category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name ?? ''),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      vocabularyController.currentPage.value = 1;
                      vocabularyController.setCategory(value);
                      vocabularyController.selectedAlphabet.value = '';
                      vocabularyController.fetchVocabulary();
                    }
                  },
                ),
              ),
            )),
      ],
    );
  }
}

Widget _buildPopupList(String title, List<String?>? items, Color color) {
  if (items == null || items.isEmpty) return SizedBox();
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        "$title:",
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 4),
      Wrap(
        spacing: 6,
        runSpacing: 4,
        children: items.asMap().entries.map((entry) {
          int idx = entry.key;
          String e = entry.value!;
          bool isLast = idx == items.length - 1;
          return Text(
            isLast ? e : "$e,",
            style: TextStyle(color: color, fontWeight: FontWeight.w500),
          );
        }).toList(),
      ),
      const SizedBox(height: 10),
    ],
  );
}
