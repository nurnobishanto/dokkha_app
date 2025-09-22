import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/models/start_exam_model.dart';
import 'package:lokkha/app/modules/exam/models/exam_details_model.dart';
import 'package:lokkha/app/modules/exam/models/start_exam_model.dart';

import '../../../../utils/constants.dart';
import '../../../data/local/my_shared_pref.dart';
import '../../../helper/api_helper.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../../auth_views/auth_gateway/views/auth_gateway_view.dart';
import '../../model_test_module/views/exam_run_view.dart';
import '../../subject_sections/views/read_question.dart';

class ExamController extends GetxController {
  final isReadLoading = false.obs;
  final isExamLoading = false.obs;

  // Read Exam
  final apiCallStatus = ApiCallStatus.holding.obs;
  Future<void> fetchExamDetails(int examID) async {
    isReadLoading.value = true;
    apiCallStatus.value = ApiCallStatus.loading;
    try {
      final url = "${AppConstants.exam}/$examID";
      await BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
        if (response.data['status']) {
          ExamDetailsModel examDetailsModel =
              ExamDetailsModel.fromJson(response.data);
          apiCallStatus.value = ApiCallStatus.success;
          isReadLoading.value = false;
          Get.to(() => ReadQuestionView(
              model: examDetailsModel.exam!.questions!.toList()));
        } else {
          isReadLoading.value = false;

          apiCallStatus.value = ApiCallStatus.error;
        }
      }, onError: (err) {
        isReadLoading.value = false;

        apiCallStatus.value = ApiCallStatus.error;
        debugPrint("error from fetchExamDetails $err");
      });
    } catch (e) {
      isReadLoading.value = false;
      apiCallStatus.value = ApiCallStatus.error;
    }
  }

  // Read Exam
  final apiExamCallStatus = ApiCallStatus.holding.obs;
  Future<void> startExam(int examID) async {
    isExamLoading.value = true;
    apiExamCallStatus.value = ApiCallStatus.loading;
    String? token = MySharedPref.getUserToken();
    if (token == '' || token.isEmpty) return Get.to(const AuthGatewayView());

    try {
      final url = "${AppConstants.startExam}/$examID";

      await BaseClient.safeApiCall(url, RequestType.get,
          headers: {
            "Authorization": 'Bearer $token',
          },
          onSuccess: (response) {
        if (response.data['status']) {
          ExamStartModel startExamModel =
          ExamStartModel.fromJson(response.data);
          apiExamCallStatus.value = ApiCallStatus.success;
          isExamLoading.value = false;
          Get.to(() => RunExamView(
            examStartModel: startExamModel,
          ));
        } else {
          isExamLoading.value = false;
          print("sdjsdjkf${response.data['message']}");
          apiExamCallStatus.value = ApiCallStatus.error;
        }
      }, onError: (err) {
        isExamLoading.value = false;
        apiExamCallStatus.value = ApiCallStatus.error;
        debugPrint("error from fetchExamDetails $err");
      });
    } catch (e) {
      isExamLoading.value = false;
      apiExamCallStatus.value = ApiCallStatus.error;
    }
  }
}
