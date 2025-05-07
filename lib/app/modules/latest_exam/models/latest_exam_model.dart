
import 'dart:convert';

import '../../../models/tag.dart';

LatestExamModel latestExamModelFromJson(String str) => LatestExamModel.fromJson(json.decode(str));

String latestExamModelToJson(LatestExamModel data) => json.encode(data.toJson());

class LatestExamModel {
  final bool? status;
  final List<LatestExam>? latestExams;

  LatestExamModel({
    this.status,
    this.latestExams,
  });

  factory LatestExamModel.fromJson(Map<String, dynamic> json) => LatestExamModel(
    status: json["status"],
    latestExams: json["latest_exams"] == null ? [] : List<LatestExam>.from(json["latest_exams"]!.map((x) => LatestExam.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "latest_exams": latestExams == null ? [] : List<dynamic>.from(latestExams!.map((x) => x.toJson())),
  };
}

class LatestExam {
  final int? id;
  final String? title;
  final DateTime? date;
  final String? type;
  final bool? status;
  final int? tagId;
  final Tag? tag;

  LatestExam({
    this.id,
    this.title,
    this.date,
    this.type,
    this.status,
    this.tagId,
    this.tag,
  });

  factory LatestExam.fromJson(Map<String, dynamic> json) => LatestExam(
    id: json["id"],
    title: json["title"],
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    type: json["type"],
    status: json["status"],
    tagId: json["tag_id"],
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "date": date?.toIso8601String(),
    "type": type,
    "status": status,
    "tag_id": tagId,
    "tag": tag?.toJson(),
  };
}

