
import 'dart:convert';
import '../../../models/question.dart';
import '../../../models/tag.dart';

TagQuestionsModel tagQuestionsModelFromJson(String str) => TagQuestionsModel.fromJson(json.decode(str));
String tagQuestionsModelToJson(TagQuestionsModel data) => json.encode(data.toJson());

class TagQuestionsModel {
  final bool? status;
  final Tag? tag;
  final List<Question>? questions;

  TagQuestionsModel({
    this.status,
    this.tag,
    this.questions,
  });

  factory TagQuestionsModel.fromJson(Map<String, dynamic> json) => TagQuestionsModel(
    status: json["status"],
    tag: json["tag"] == null ? null : Tag.fromJson(json["tag"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "tag": tag?.toJson(),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

