import 'package:get/get.dart';
import '../../../../../helper/api_helper.dart';

class MockExamResultController extends GetxController{

  bool checkQuestionExistInSaved(int id) {
    return favoriteQuestionsModel.value.favoriteQuestions?.any((q) => q.id == id) ??
        false;
  }
}