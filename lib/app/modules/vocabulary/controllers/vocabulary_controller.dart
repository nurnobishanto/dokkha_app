import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/vocabulary/models/vocabulary_model.dart';

import '../../../../utils/constants.dart';
import '../../../services/base_client.dart';

class VocabularyController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxString search = RxString("");
  RxObjectMixin<VocabularyModel> model = VocabularyModel().obs;
  Future<void> fetchVocabulary(String search,
      {int page = 1, bool refresh = false, String? date}) async {
    isLoading.value = true;
    String url = "${AppConstants.vocabulary}?search=$search&page=$page";

    BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        if (response.data["status"]) {
          VocabularyModel modelData = VocabularyModel.fromJson(response.data);
          if (page > 1 && model.value.vocabulary != null) {
            // Merge new data with existing data
            model.value.vocabulary!.data!.addAll(modelData.vocabulary!.data!);
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
