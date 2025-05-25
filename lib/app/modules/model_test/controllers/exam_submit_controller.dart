import 'package:get/get.dart';

import '../../../helper/api_helper.dart';

class ExamSubmitController extends GetxController {
  bool checkQuestionExistInSaved(int id) {
    return favoriteQuestionsListModel.value.favoriteQuestions?.any((q) => q.id == id) ??
        false;
  }
}