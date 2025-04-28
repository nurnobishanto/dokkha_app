
import 'dart:convert';

MockStartExamModel mockStartExamModelFromJson(String str) =>
    MockStartExamModel.fromJson(json.decode(str));

String mockStartExamModelToJson(MockStartExamModel data) =>
    json.encode(data.toJson());

class MockStartExamModel {
  final bool? status;
  final String? type;
  final int? duration;
  final DateTime? startTime;
  final bool? negativeMark;
  final bool? isSetTime;
  final int? questionsCount;
  final List<Question>? questions;

  MockStartExamModel({
    this.status,
    this.type,
    this.duration,
    this.startTime,
    this.negativeMark,
    this.isSetTime,
    this.questionsCount,
    this.questions,
  });

  factory MockStartExamModel.fromJson(Map<String, dynamic> json) =>
      MockStartExamModel(
        status: json["status"],
        type: json["type"],
        duration: json["duration"],
        startTime: json["start_time"] == null
            ? null
            : DateTime.parse(json["start_time"]),
        negativeMark: json["negative_mark"],
        isSetTime: json["is_set_time"],
        questionsCount: json["questions_count"],
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "type": type,
        "duration": duration,
        "start_time": startTime?.toIso8601String(),
        "negative_mark": negativeMark,
        "is_set_time": isSetTime,
        "questions_count": questionsCount,
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x.toJson())),
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

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
