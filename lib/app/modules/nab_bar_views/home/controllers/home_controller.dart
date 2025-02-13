import 'package:get/get.dart';
import '../../../../routes/app_pages.dart';

class HomeController extends GetxController {
  final List<String> gridViewTitle = [
    'প্রশ্ন ব্যাংক',
    'মক পরীক্ষা',
    'আজকের পরীক্ষা',
    'চাকরির আপডেট',
    'আজকের বিশ্ব',
    'নোটিশ বোর্ড',
  ];

  final List<String> gridViewRoutePage = [
     Routes.QUESTION_BANK,
     Routes.MOCK_TEST,
     Routes.AJKER_PORIKKHA,
     Routes.JOBS_UPDATE,
     Routes.AJKER_BISSHO,
     Routes.NOTICE_BOARD,
  ];

  List<String> images = [
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
    "seamless_pattern.png",
  ];
}
