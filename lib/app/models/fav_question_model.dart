import 'dart:convert';

import 'package:lokkha/app/models/question.dart';

FavQuestionListModel favQuestionListModelFromJson(String str) => FavQuestionListModel.fromJson(json.decode(str));

String favQuestionListModelToJson(FavQuestionListModel data) => json.encode(data.toJson());

class FavQuestionListModel {
  final bool? status;
  final String? message;
  final List<Question>? favoriteQuestions;

  FavQuestionListModel({
    this.status,
    this.message,
    this.favoriteQuestions,
  });

  factory FavQuestionListModel.fromJson(Map<String, dynamic> json) => FavQuestionListModel(
    status: json["status"],
    message: json["message"],
    favoriteQuestions: json["favorite_questions"] == null ? [] : List<Question>.from(json["favorite_questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "favorite_questions": favoriteQuestions == null ? [] : List<dynamic>.from(favoriteQuestions!.map((x) => x.toJson())),
  };
}

