import 'package:get/get.dart';
import 'package:lokkha/app/modules/subject_sections/models/sub_sec_select_model.dart';
import '../../../data/local/my_shared_pref.dart';

class SubjectSectionController extends GetxController {

  RxList<SubjectSectionSelect> selectedSubjects = <SubjectSectionSelect>[].obs;

  Future<void> getSubjects() async {
    List<SubjectSectionSelect> fetchedSubjects = await MySharedPref.getSubjectSection();
    selectedSubjects.assignAll(fetchedSubjects);
  }

  @override
  void onInit() {
    super.onInit();
    getSubjects();
  }
}
