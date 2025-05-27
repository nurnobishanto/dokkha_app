import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/vocabulary/models/vocabulary_model.dart';

import '../../../../utils/constants.dart';
import '../../../models/category.dart';
import '../../../services/base_client.dart';

class VocabularyController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxString search = RxString("");
  var selectedAlphabet = ''.obs;


  final Rxn<Category> selectedType = Rxn<Category>();
  final Rxn<Category> selectedCategory = Rxn<Category>();

  void setType(Category type) => selectedType.value = type;
  void setCategory(Category category) => selectedCategory.value = category;


  Rx<VocabularyModel> model = VocabularyModel().obs;

  Future<void> fetchVocabulary(
      {int page = 1, bool refresh = false, String? date}) async {
    isLoading.value = true;
    String url = AppConstants.vocabularies;

    Map<String, dynamic> data = {
      'alphabet': selectedAlphabet.value.toUpperCase(),
      'page': page,
      'search': search.value.toString(),
    };
    if (selectedType.value?.id != null) {
      data['type_ids[]'] = [selectedType.value!.id!];
    }
    if (selectedCategory.value?.id != null) {
      data['category_ids[]'] = [selectedCategory.value!.id!];
    }

    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      queryParameters: data,
      onSuccess: (response) {
        if (response.data["status"]) {
          VocabularyModel modelData = VocabularyModel.fromJson(response.data);
          selectedAlphabet.value = modelData.selectedAlphabet.toString().toUpperCase();
          if (page > 1 &&
              model.value.vocabularies != null &&
              modelData.vocabularies != null) {
            model.value.vocabularies!.data!
                .addAll(modelData.vocabularies!.data!);
            model.refresh();
          } else {
            model.value = modelData;
          }
          currentPage.value = page;
        } else {
          debugPrint("ERROR ::::::: ");
        }
        isLoading.value = false;
      },
      onError: (error) {
        debugPrint("API Error: $error");
        isLoading.value = false;
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    fetchVocabulary();
  }
}
