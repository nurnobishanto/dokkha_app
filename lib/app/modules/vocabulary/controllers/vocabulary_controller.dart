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

  var selectedType = Rxn<Category>(); // Rx<Category?> এর shorthand
  var selectedCategory = 'All'.obs;
  var selectedAlphabet = ''.obs;

  void setType(Category type) => selectedType.value = type;
  void setCategory(String category) => selectedCategory.value = category;


  RxObjectMixin<VocabularyModel> model = VocabularyModel().obs;
  Future<void> fetchVocabulary(String search,
      {int page = 1, bool refresh = false, String? date}) async {
    isLoading.value = true;
    String url = AppConstants.vocabularies;
  Map data = {
    'alphabet': '',
    'type_ids': '',
    'category_ids': '',
    'pages':page,
    'search':search,
  };
    BaseClient.safeApiCall(
      url,
      RequestType.get,
      data: data,
      onSuccess: (response) {
        if (response.data["status"]) {
          print("SSSS111${response.data["status"]}");
          VocabularyModel modelData = VocabularyModel.fromJson(response.data);
          print("SSSS${response.data["status"]}");
          selectedAlphabet.value = modelData.selectedAlphabet.toString();
          if (page > 1 && model.value.vocabularies != null) {
            // Merge new data with existing data
            model.value.vocabularies!.data!.addAll(modelData.vocabularies!.data!);
          } else {
            model.value = modelData;

          }
          currentPage.value = page;
          isLoading.value = false;
        } else {
          isLoading.value = false;
          debugPrint("ERROR ::::::: ");
        }
      },
    );
  }


  @override
  void onInit() {
    super.onInit();
    fetchVocabulary("");
  }
}
