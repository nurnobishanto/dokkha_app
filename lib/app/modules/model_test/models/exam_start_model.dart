
import 'dart:convert';

import '../../../models/exam.dart';
import '../../../models/question.dart';
ExamStartModel examStartModelFromJson(String str) => ExamStartModel.fromJson(json.decode(str));
String examStartModelToJson(ExamStartModel data) => json.encode(data.toJson());

class ExamStartModel {
  final bool? status;
  final Exam? exam;
  final List<Question>? questions;

  ExamStartModel({
    this.status,
    this.exam,
    this.questions,
  });

  factory ExamStartModel.fromJson(Map<String, dynamic> json) => ExamStartModel(
    status: json["status"],
    exam: json["exam"] == null ? null : Exam.fromJson(json["exam"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "exam": exam?.toJson(),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}
