
import 'dart:convert';

import '../../../models/question.dart';

VocabularyModel vocabularyModelFromJson(String str) => VocabularyModel.fromJson(json.decode(str));

String vocabularyModelToJson(VocabularyModel data) => json.encode(data.toJson());

class VocabularyModel {
  final bool? status;
  final String? message;
  final Vocabulary? vocabulary;

  VocabularyModel({
    this.status,
    this.message,
    this.vocabulary,
  });

  factory VocabularyModel.fromJson(Map<String, dynamic> json) => VocabularyModel(
    status: json["status"],
    message: json["message"],
    vocabulary: json["vocabulary"] == null ? null : Vocabulary.fromJson(json["vocabulary"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "vocabulary": vocabulary?.toJson(),
  };
}

class Vocabulary {
  final List<Data>? data;
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final int? from;
  final int? to;

  Vocabulary({
    this.data,
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.from,
    this.to,
  });

  factory Vocabulary.fromJson(Map<String, dynamic> json) => Vocabulary(
    data: json["data"] == null ? [] : List<Data>.from(json["data"]!.map((x) => Data.fromJson(x))),
    currentPage: json["current_page"],
    perPage: json["per_page"],
    total: json["total"],
    lastPage: json["last_page"],
    from: json["from"],
    to: json["to"],
  );

  Map<String, dynamic> toJson() => {
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "current_page": currentPage,
    "per_page": perPage,
    "total": total,
    "last_page": lastPage,
    "from": from,
    "to": to,
  };
}

class Data {
  final DateTime? date;
  final List<Question>? questions;

  Data({
    this.date,
    this.questions,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

