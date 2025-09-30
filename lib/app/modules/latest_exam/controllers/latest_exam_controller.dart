import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:lokkha/app/modules/latest_exam/models/tag_questions_model.dart';
import '../../../../utils/constants.dart';
import '../../../models/start_exam_model.dart';
import '../../../services/base_client.dart';
import '../../../views/views/exam_process_view.dart';
import '../../subject_sections/views/read_question.dart';
import '../models/latest_exam_model.dart';
import 'package:lokkha/app/services/api_call_status.dart';

class LatestExamController extends GetxController {
  RxBool isLoading = true.obs;
  RxBool isLoadingQuestion = false.obs;
  RxInt currentPage = 1.obs;
  RxBool isFavourite = false.obs;
  RxString search = RxString("");
  RxObjectMixin<LatestExamModel> model = LatestExamModel().obs;

  ApiCallStatus apiCallStatus = ApiCallStatus.holding;

  Future<void> fetchLatestExam(
      {int page = 1, String date = '', String search = ''}) async {
    apiCallStatus = ApiCallStatus.loading;
    isLoading.value = true;
    String url =
        "${AppConstants.latestExam}?search=$search&page=$page&date=$date";

    BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
      if (response.data["status"]) {
        LatestExamModel modelData = LatestExamModel.fromJson(response.data);
        if (page > 1 && model.value.latestExams != null) {
          // Merge new data with existing data
          model.value.latestExams!.data!.addAll(modelData.latestExams!.data!);
          apiCallStatus = ApiCallStatus.success;
        } else {
          model.value = modelData;
        }
        currentPage.value = page;
        isLoading.value = false;
      } else {
        isLoading.value = false;
      }
    }, onError: (err) {
      apiCallStatus = ApiCallStatus.error;
    });
  }

  Future<void> fetchTagQuestions(int id, bool isStartExam, int duration,
      String selectedNegativeMark, BuildContext context) async {
    apiCallStatus = ApiCallStatus.loading;
    isLoadingQuestion.value = true;
    String url = "${AppConstants.tag}/$id";

    BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
      if (response.data["status"]) {
        TagQuestionsModel tagQuestionsModel =
            TagQuestionsModel.fromJson(response.data);
        isLoadingQuestion.value = false;
        if (isStartExam) {
          StartExamModel model = StartExamModel(
            status: true,
            examName: tagQuestionsModel.tag?.name,
            type: 'random',
            duration: duration,
            startTime: DateTime.now(),
            isNegativeMark: true,
            negativeMark: double.tryParse(selectedNegativeMark),
            isSetTime: true,
            questionsCount: tagQuestionsModel.questions!.length,
            questions: tagQuestionsModel.questions!.toList(),
          );
          Navigator.pop(context);
          Get.to(ExamProcessView(examStartModel: model));
        } else {
          Navigator.pop(context);
          Get.to(
              ReadQuestionView(model: tagQuestionsModel.questions!.toList()));
        }
      }
    }, onError: (err) {
      apiCallStatus = ApiCallStatus.error;
    });
  }

  @override
  void onInit() {
    fetchLatestExam();
    super.onInit();
  }
}
