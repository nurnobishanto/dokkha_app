
import 'dart:convert';

import '../../../models/exam_category.dart';
ExamCategoriesModel examCategoriesModelFromJson(String str) => ExamCategoriesModel.fromJson(json.decode(str));
String examCategoriesModelToJson(ExamCategoriesModel data) => json.encode(data.toJson());

class ExamCategoriesModel {
  final bool? status;
  final List<ExamCategory>? examCategories;

  ExamCategoriesModel({
    this.status,
    this.examCategories,
  });

  factory ExamCategoriesModel.fromJson(Map<String, dynamic> json) => ExamCategoriesModel(
    status: json["status"],
    examCategories: json["exam_categories"] == null ? [] : List<ExamCategory>.from(json["exam_categories"]!.map((x) => ExamCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "exam_categories": examCategories == null ? [] : List<dynamic>.from(examCategories!.map((x) => x.toJson())),
  };
}



