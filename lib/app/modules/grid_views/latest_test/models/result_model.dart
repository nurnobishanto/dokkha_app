// To parse this JSON data, do
//
//     final resultModel = resultModelFromJson(jsonString);

import 'dart:convert';

ResultModel resultModelFromJson(String str) =>
    ResultModel.fromJson(json.decode(str));

String resultModelToJson(ResultModel data) =>
    json.encode(data.toJson());

class ResultModel {
  final bool? status;
  final Summary? summary;
  final bool? negativeMark;
  final List<Result>? results;
  final String? message;

  ResultModel({
    this.status,
    this.summary,
    this.negativeMark,
    this.results,
    this.message,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) =>
      ResultModel(
        status: json["status"],
        summary:
            json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        negativeMark: json["negative_mark"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
                json["results"]!.map((x) => Result.fromJson(x))),
        message: json["message"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "summary": summary?.toJson(),
        "negative_mark": negativeMark,
        "results": results == null
            ? []
            : List<dynamic>.from(results!.map((x) => x.toJson())),
        "message": message,
      };
}

class Result {
  final Question? question;
  final List<String?>? userAnswer;
  final List<CorrectAnswer>? correctAnswer;
  final bool? isCorrect;
  final bool? isAttempt;

  Result({
    this.question,
    this.userAnswer,
    this.correctAnswer,
    this.isCorrect,
    this.isAttempt,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        question: json["question"] == null
            ? null
            : Question.fromJson(json["question"]),
        userAnswer: json["user_answer"] == null ? [] : List<String?>.from(json["user_answer"]!.map((x) => x)),
        correctAnswer: json["correct_answer"] == null
            ? []
            : List<CorrectAnswer>.from(
                json["correct_answer"]!.map((x) => CorrectAnswer.fromJson(x))),
        isCorrect: json["is_correct"],
        isAttempt: json["is_attempt"],
      );

  Map<String, dynamic> toJson() => {
        "question": question?.toJson(),
        "user_answer": userAnswer == null
            ? []
            : List<dynamic>.from(userAnswer!.map((x) => x)),
        "correct_answer": correctAnswer == null
            ? []
            : List<dynamic>.from(correctAnswer!.map((x) => x.toJson())),
        "is_correct": isCorrect,
        "is_attempt": isAttempt,
      };
}

class CorrectAnswer {
  final int? answer;

  CorrectAnswer({
    this.answer,
  });

  factory CorrectAnswer.fromJson(Map<String, dynamic> json) => CorrectAnswer(
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "answer": answer,
      };
}

class Question {
  final int? id;
  final QuestionType? questionType;
  final String? title;
  final String? description;
  final List<Option>? options;
  final String? explanation;
  final String? questionImage;
  final String? explanationImage;
  final String? note;
  final String? reference;
  final DateTime? date;
  final String? customId;
  final String? comment;

  Question({
    this.id,
    this.questionType,
    this.title,
    this.description,
    this.options,
    this.explanation,
    this.questionImage,
    this.explanationImage,
    this.note,
    this.reference,
    this.date,
    this.customId,
    this.comment,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
        id: json["id"],
        questionType: questionTypeValues.map[json["question_type"]]!,
        title: json["title"],
        description: json["description"],
        options: json["options"] == null
            ? []
            : List<Option>.from(
                json["options"]!.map((x) => Option.fromJson(x))),
        explanation: json["explanation"],
        questionImage: json["question_image"],
        explanationImage: json["explanation_image"],
        note: json["note"],
        reference: json["reference"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        customId: json["custom_id"],
        comment: json["comment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "question_type": questionTypeValues.reverse[questionType],
        "title": title,
        "description": description,
        "options": options == null
            ? []
            : List<dynamic>.from(options!.map((x) => x.toJson())),
        "explanation": explanation,
        "question_image": questionImage,
        "explanation_image": explanationImage,
        "note": note,
        "reference": reference,
        "date":
            "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
        "custom_id": customId,
        "comment": comment,
      };
}

class Option {
  final int? key;
  final String? value;
  final bool? isCorrect;

  Option({
    this.key,
    this.value,
    this.isCorrect,
  });

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        key: json["key"],
        value: json["value"],
        isCorrect: json["is_correct"],
      );

  Map<String, dynamic> toJson() => {
        "key": key,
        "value": value,
        "is_correct": isCorrect,
      };
}

enum QuestionType { SINGLE_CHOICE }

final questionTypeValues =
    EnumValues({"single_choice": QuestionType.SINGLE_CHOICE});

enum Status { FINAL }

final statusValues = EnumValues({"final": Status.FINAL});

class Summary {
  final int? total;
  final int? correct;
  final int? incorrect;
  final int? attempt;
  final int? mark;

  Summary({
    this.total,
    this.correct,
    this.incorrect,
    this.attempt,
    this.mark,
  });

  factory Summary.fromJson(Map<String, dynamic> json) => Summary(
        total: json["total"],
        correct: json["correct"],
        incorrect: json["incorrect"],
        attempt: json["attempt"],
        mark: json["mark"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "correct": correct,
        "incorrect": incorrect,
        "attempt": attempt,
        "mark": mark,
      };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
