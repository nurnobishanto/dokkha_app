
import 'dart:convert';
import 'package:lokkha/app/models/paginator.dart';
import '../../../models/category.dart';

LectureSheetCategoriesModel lectureSheetCategoriesFromJson(String str) => LectureSheetCategoriesModel.fromJson(json.decode(str));
String lectureSheetCategoriesToJson(LectureSheetCategoriesModel data) => json.encode(data.toJson());
class LectureSheetCategoriesModel {
  final bool? status;
  final Paginator<Category>? categories;

  LectureSheetCategoriesModel({
    this.status,
    this.categories,
  });

  factory LectureSheetCategoriesModel.fromJson(Map<String, dynamic> json) => LectureSheetCategoriesModel(
    status: json["status"],
    categories: json["categories"] == null ? null : Paginator<Category>.fromJson(json["categories"],(x) => Category.fromJson(x)),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "categories": categories?.toJson((x) => (x).toJson()),
  };
}



