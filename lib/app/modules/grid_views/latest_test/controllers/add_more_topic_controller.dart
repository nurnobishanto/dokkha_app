import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../../../utils/constants.dart';
import '../../../../data/local/my_shared_pref.dart';
import '../../../../models/get_subjects.dart';
import '../../../../models/mock_subject_select_model.dart';
import '../../../../services/api_call_status.dart';
import '../../../../services/base_client.dart';

class AddMoreTopicController extends GetxController {
  RxList<MockSubjectSelect> selectedSubjects = <MockSubjectSelect>[].obs;

  Future<void> getSubjects() async {
    List<MockSubjectSelect> fetchedSubjects =
        await MySharedPref.getMockSubjects();
    selectedSubjects.assignAll(fetchedSubjects);
  }

  final Rx<ApiCallStatus> apiCallStatus = ApiCallStatus.holding.obs;
  final Rx<GetSubjectsModel> topics = GetSubjectsModel().obs;
  final isLoading = true.obs;
  Future<void> getSubjectTopics({required int parentID}) async {
    isLoading.value = true;
    apiCallStatus.value = ApiCallStatus.loading;
    debugPrint("Fetching topics...");
    String url = "${AppConstants.getSubjects}?parent_id=$parentID";

    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      onSuccess: (response) {
        topics.value = GetSubjectsModel.fromJson(response.data);
        apiCallStatus.value = ApiCallStatus.success;
        isLoading.value = false;

      },
      onError: (error) {
        apiCallStatus.value = ApiCallStatus.error;
        isLoading.value = false;
        debugPrint("Error fetching topics: ${error.message}");
      },
    );
  }

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }
}
