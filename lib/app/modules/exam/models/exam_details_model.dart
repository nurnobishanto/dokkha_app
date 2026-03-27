import 'dart:convert';

import '../../../models/exam.dart';

ExamDetailsModel examDetailsModelFromJson(String str) =>
    ExamDetailsModel.fromJson(json.decode(str));

String examDetailsModelToJson(ExamDetailsModel data) =>
    json.encode(data.toJson());

class ExamDetailsModel {
  final bool? status;
  final Exam? exam;

  ExamDetailsModel({
    this.status,
    this.exam,
  });

  factory ExamDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExamDetailsModel(
        status: json["status"],
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "exam": exam?.toJson(),
      };
}
