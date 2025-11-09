// import 'package:get/get.dart';
// import 'package:lokkha/app/modules/see_all_items/models/all_exam_model.dart';
// import '../../../../utils/constants.dart';
// import '../../../services/base_client.dart';
// import 'package:lokkha/app/services/api_call_status.dart';
// import '../models/all_course_model.dart';
//
// class SeeAllItemsController extends GetxController {
//   RxBool isLoading = true.obs;
//   RxBool isLoadingQuestion = false.obs;
//   RxInt currentPage = 1.obs;
//   RxBool isFavourite = false.obs;
//   RxString search = RxString("");
//   RxObjectMixin<AllCourseModel> model = AllCourseModel().obs;
//   RxObjectMixin<AllExamModel> allExamModel = AllExamModel().obs;
//
//   ApiCallStatus apiCallStatus = ApiCallStatus.holding;
//   ApiCallStatus examApiCallStatus = ApiCallStatus.holding;
//
//   Future<void> fetchAllCourses(
//       {int page = 1, String date = '', String search = ''}) async {
//     apiCallStatus = ApiCallStatus.loading;
//     isLoading.value = true;
//     String url = AppConstants.courses;
//
//     BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
//       if (response.data["status"]) {
//         AllCourseModel modelData = AllCourseModel.fromJson(response.data);
//         if (page > 1 && model.value.courses != null) {
//           // Merge new data with existing data
//           model.value.courses!.data!.addAll(modelData.courses!.data!);
//           apiCallStatus = ApiCallStatus.success;
//         } else {
//           model.value = modelData;
//         }
//         currentPage.value = page;
//         isLoading.value = false;
//       } else {
//         isLoading.value = false;
//       }
//     }, onError: (err) {
//       apiCallStatus = ApiCallStatus.error;
//     });
//   }
//
//   Future<void> fetchAllExams(
//       {int page = 1, String date = '', String search = ''}) async {
//     examApiCallStatus = ApiCallStatus.loading;
//     // isLoading.value = true;
//     String url = AppConstants.examList;
//
//     BaseClient.safeApiCall(url, RequestType.get, onSuccess: (response) {
//       if (response.data["status"]) {
//         AllExamModel modelData = AllExamModel.fromJson(response.data);
//         if (page > 1 && allExamModel.value.exams?.exam != null) {
//           // Merge and refresh
//           allExamModel.value.exams!.exam!.addAll(modelData.exams!.exam!);
//           allExamModel.refresh();
//           examApiCallStatus = ApiCallStatus.success;
//         } else {
//           allExamModel.value = modelData;
//         }
//         currentPage.value = page;
//         //isLoading.value = false;
//       } else {
//         //isLoading.value = false;
//       }
//     }, onError: (err) {
//       examApiCallStatus = ApiCallStatus.error;
//     });
//   }
//
//   @override
//   void onInit() {
//     fetchAllCourses();
//     fetchAllExams();
//     super.onInit();
//   }
// }


import 'package:get/get.dart';
import '../../../../utils/constants.dart';
import '../../../services/api_call_status.dart';
import '../../../services/base_client.dart';
import '../models/all_exam_model.dart';

class SeeAllItemsController extends GetxController {
  RxBool isLoading = true.obs;
  RxInt currentPage = 1.obs;
  RxInt totalPages = 1.obs;
  RxObjectMixin<AllExamModel> allExamModel = AllExamModel().obs;
  Rx<ApiCallStatus> examApiCallStatus = ApiCallStatus.holding.obs;

  Future<void> fetchAllExams({int page = 1}) async {
    examApiCallStatus.value = ApiCallStatus.loading;

    final url = AppConstants.examList;

    await BaseClient.safeApiCall(
      url,
      RequestType.get,
      queryParameters: {'page': page},
      onSuccess: (response) {

        if (response.data["status"] == true) {
          final modelData = AllExamModel.fromJson(response.data);
          if (page > 1 && allExamModel.value.exams?.data != null) {
            allExamModel.value.exams!.data!.addAll(modelData.exams!.data!);
            allExamModel.refresh();
          } else {
            allExamModel.value = modelData;
          }

          currentPage.value = page;
          totalPages.value = modelData.exams?.lastPage ?? 1;
          examApiCallStatus.value = ApiCallStatus.success;
        } else {
          examApiCallStatus.value = ApiCallStatus.error;
        }
      },
      onError: (err) {
        examApiCallStatus.value = ApiCallStatus.error;
      },
    );
  }

  void goToPage(int page) => fetchAllExams(page: page);
  void nextPage() => fetchAllExams(page: currentPage.value + 1);
  void previousPage() => fetchAllExams(page: currentPage.value - 1);
  void firstPage() => fetchAllExams(page: 1);
  void lastPage() => fetchAllExams(page: totalPages.value);

  @override
  void onInit() {
    fetchAllExams();
    super.onInit();
  }
}
