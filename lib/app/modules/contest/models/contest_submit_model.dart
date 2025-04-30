
import 'dart:convert';

ContestSubmitModel contestSubmitModelFromJson(String str) => ContestSubmitModel.fromJson(json.decode(str));

String contestSubmitModelToJson(ContestSubmitModel data) => json.encode(data.toJson());

class ContestSubmitModel {
  final bool? status;
  final Summary? summary;
  final List<Result>? results;
  final String? message;

  ContestSubmitModel({
    this.status,
    this.summary,
    this.results,
    this.message,
  });

  factory ContestSubmitModel.fromJson(Map<String, dynamic> json) => ContestSubmitModel(
    status: json["status"],
    summary: json["summary"] == null ? null : Summary.fromJson(json["summary"]),
    results: json["results"] == null ? [] : List<Result>.from(json["results"]!.map((x) => Result.fromJson(x))),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "summary": summary?.toJson(),
    "results": results == null ? [] : List<dynamic>.from(results!.map((x) => x.toJson())),
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
    question: json["question"] == null ? null : Question.fromJson(json["question"]),
    userAnswer: json["user_answer"] == null ? [] : List<String?>.from(json["user_answer"]!.map((x) => x)),
    correctAnswer: json["correct_answer"] == null ? [] : List<CorrectAnswer>.from(json["correct_answer"]!.map((x) => CorrectAnswer.fromJson(x))),
    isCorrect: json["is_correct"],
    isAttempt: json["is_attempt"],
  );

  Map<String, dynamic> toJson() => {
    "question": question?.toJson(),
    "user_answer": userAnswer == null ? [] : List<dynamic>.from(userAnswer!.map((x) => x)),
    "correct_answer": correctAnswer == null ? [] : List<dynamic>.from(correctAnswer!.map((x) => x.toJson())),
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
  final String? date;
  final String? status;
  final String? customId;
  final String? comment;
  final DateTime? createdAt;


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
    this.status,
    this.customId,
    this.comment,
    this.createdAt,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
    id: json["id"],
    questionType: questionTypeValues.map[json["question_type"]]!,
    title: json["title"],
    description: json["description"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    explanation: json["explanation"],
    questionImage: json["question_image"],
    explanationImage: json["explanation_image"],
    note: json["note"],
    reference: json["reference"],

    customId: json["custom_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),

  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_type": questionTypeValues.reverse[questionType],
    "title": title,
    "description": description,
    "options": options == null ? [] : List<dynamic>.from(options!.map((x) => x.toJson())),
    "explanation": explanation,
    "question_image": questionImage,
    "explanation_image": explanationImage,
    "note": note,
    "reference": reference,
    "date": date,
    "status": status,
    "custom_id": customId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
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

enum QuestionType {
  SINGLE_CHOICE,
  MULTIPLE_CHOICE,
  FILL_IN_THE_BLANK,
}

final questionTypeValues = EnumValues({
  "single_choice": QuestionType.SINGLE_CHOICE,
  "multiple_choice": QuestionType.MULTIPLE_CHOICE,
  "fill_in_the_blank": QuestionType.FILL_IN_THE_BLANK,
});


class Summary {
  final int? total;
  final int? correct;
  final int? incorrect;
  final int? attempt;
  final double? mark;

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
    mark: json["mark"]?.toDouble(),
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
