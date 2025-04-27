import 'dart:convert';

MockExamResultModel mockExamResultModelFromJson(String str) =>
    MockExamResultModel.fromJson(json.decode(str));

String mockExamResultModelToJson(MockExamResultModel data) =>
    json.encode(data.toJson());

class MockExamResultModel {
  final bool? status;
  final Summary? summary;
  final bool? negativeMark;
  final List<Result>? results;

  MockExamResultModel({
    this.status,
    this.summary,
    this.negativeMark,
    this.results,
  });

  factory MockExamResultModel.fromJson(Map<String, dynamic> json) =>
      MockExamResultModel(
        status: json["status"],
        summary:
        json["summary"] == null ? null : Summary.fromJson(json["summary"]),
        negativeMark: json["negative_mark"],
        results: json["results"] == null
            ? []
            : List<Result>.from(
            json["results"]!.map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "summary": summary?.toJson(),
    "negative_mark": negativeMark,
    "results": results == null
        ? []
        : List<dynamic>.from(results!.map((x) => x.toJson())),
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
    userAnswer: json["user_answer"] == null
        ? []
        : List<String?>.from(json["user_answer"]!.map((x) => x)),
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
  final String? answer;

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
  final dynamic description;
  final List<Option>? options;
  final dynamic explanation;
  final dynamic questionImage;
  final dynamic explanationImage;
  final dynamic note;
  final dynamic reference;
  final dynamic date;
  final Status? status;
  final String? customId;
  final dynamic comment;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final int? createdBy;
  final int? updatedBy;
  final int? confirmedBy;
  final DateTime? confirmedAt;
  final int? approvedBy;
  final DateTime? approvedAt;
  final dynamic rejectedBy;
  final dynamic rejectedAt;
  final int? finalBy;
  final DateTime? finalAt;

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
    this.updatedAt,
    this.deletedAt,
    this.createdBy,
    this.updatedBy,
    this.confirmedBy,
    this.confirmedAt,
    this.approvedBy,
    this.approvedAt,
    this.rejectedBy,
    this.rejectedAt,
    this.finalBy,
    this.finalAt,
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
    date: json["date"],
    status: statusValues.map[json["status"]]!,
    customId: json["custom_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    confirmedBy: json["confirmed_by"],
    confirmedAt: json["confirmed_at"] == null
        ? null
        : DateTime.parse(json["confirmed_at"]),
    approvedBy: json["approved_by"],
    approvedAt: json["approved_at"] == null
        ? null
        : DateTime.parse(json["approved_at"]),
    rejectedBy: json["rejected_by"],
    rejectedAt: json["rejected_at"],
    finalBy: json["final_by"],
    finalAt:
    json["final_at"] == null ? null : DateTime.parse(json["final_at"]),
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
    "date": date,
    "status": statusValues.reverse[status],
    "custom_id": customId,
    "comment": comment,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "created_by": createdBy,
    "updated_by": updatedBy,
    "confirmed_by": confirmedBy,
    "confirmed_at": confirmedAt?.toIso8601String(),
    "approved_by": approvedBy,
    "approved_at": approvedAt?.toIso8601String(),
    "rejected_by": rejectedBy,
    "rejected_at": rejectedAt,
    "final_by": finalBy,
    "final_at": finalAt?.toIso8601String(),
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

enum Status { FINAL, PENDING }

final statusValues =
EnumValues({"final": Status.FINAL, "pending": Status.PENDING});



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
