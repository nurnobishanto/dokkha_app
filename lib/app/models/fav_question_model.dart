import 'dart:convert';

FavQuestionListModel favQuestionListModelFromJson(String str) => FavQuestionListModel.fromJson(json.decode(str));

String favQuestionListModelToJson(FavQuestionListModel data) => json.encode(data.toJson());

class FavQuestionListModel {
  final bool? status;
  final String? message;
  final List<FavoriteQuestion>? favoriteQuestions;

  FavQuestionListModel({
    this.status,
    this.message,
    this.favoriteQuestions,
  });

  factory FavQuestionListModel.fromJson(Map<String, dynamic> json) => FavQuestionListModel(
    status: json["status"],
    message: json["message"],
    favoriteQuestions: json["favorite_questions"] == null ? [] : List<FavoriteQuestion>.from(json["favorite_questions"]!.map((x) => FavoriteQuestion.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "favorite_questions": favoriteQuestions == null ? [] : List<dynamic>.from(favoriteQuestions!.map((x) => x.toJson())),
  };
}

class FavoriteQuestion {
  final int? id;
  final String? questionType;
  final String? title;
  final dynamic description;
  final List<Option>? options;
  final dynamic explanation;
  final dynamic questionImage;
  final dynamic explanationImage;
  final dynamic note;
  final dynamic reference;
  final dynamic date;
  final String? status;
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

  FavoriteQuestion({
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

  factory FavoriteQuestion.fromJson(Map<String, dynamic> json) => FavoriteQuestion(
    id: json["id"],
    questionType: json["question_type"],
    title: json["title"],
    description: json["description"],
    options: json["options"] == null ? [] : List<Option>.from(json["options"]!.map((x) => Option.fromJson(x))),
    explanation: json["explanation"],
    questionImage: json["question_image"],
    explanationImage: json["explanation_image"],
    note: json["note"],
    reference: json["reference"],
    date: json["date"],
    status: json["status"],
    customId: json["custom_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    confirmedBy: json["confirmed_by"],
    confirmedAt: json["confirmed_at"] == null ? null : DateTime.parse(json["confirmed_at"]),
    approvedBy: json["approved_by"],
    approvedAt: json["approved_at"] == null ? null : DateTime.parse(json["approved_at"]),
    rejectedBy: json["rejected_by"],
    rejectedAt: json["rejected_at"],
    finalBy: json["final_by"],
    finalAt: json["final_at"] == null ? null : DateTime.parse(json["final_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "question_type": questionType,
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
