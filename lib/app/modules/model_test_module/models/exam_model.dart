import 'dart:convert';
import '../../../models/exam.dart';

ExamModel examModelFromJson(String str) => ExamModel.fromJson(json.decode(str));
String examModelToJson(ExamModel data) => json.encode(data.toJson());

class ExamModel {
  final bool? status;
  final Exam? exam;

  ExamModel({
    this.status,
    this.exam,
  });

  factory ExamModel.fromJson(Map<String, dynamic> json) => ExamModel(
        status: json["status"],
        exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "exam": exam?.toJson(),
      };
}
