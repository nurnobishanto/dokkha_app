import 'package:get/get.dart';
import '../../../../helper/api_helper.dart';

class MockExamResultController extends GetxController{

  bool checkQuestionExistInSaved(int id) {
    return favoriteQuestions.value.favoriteQuestions?.any((q) => q.id == id) ??
        false;
  }
}