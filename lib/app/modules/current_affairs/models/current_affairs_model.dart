// To parse this JSON data, do
//
//     final currentAffairsModel = currentAffairsModelFromJson(jsonString);

import 'dart:convert';

CurrentAffairsModel currentAffairsModelFromJson(String str) => CurrentAffairsModel.fromJson(json.decode(str));

String currentAffairsModelToJson(CurrentAffairsModel data) => json.encode(data.toJson());

class CurrentAffairsModel {
  final bool? status;
  final String? message;
  final CurrentAffairs? currentAffairs;

  CurrentAffairsModel({
    this.status,
    this.message,
    this.currentAffairs,
  });

  factory CurrentAffairsModel.fromJson(Map<String, dynamic> json) => CurrentAffairsModel(
    status: json["status"],
    message: json["message"],
    currentAffairs: json["current_affairs"] == null ? null : CurrentAffairs.fromJson(json["current_affairs"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "current_affairs": currentAffairs?.toJson(),
  };
}

class CurrentAffairs {
  final List<Datum>? data;
  final int? currentPage;
  final int? perPage;
  final int? total;
  final int? lastPage;
  final int? from;
  final int? to;

  CurrentAffairs({
    this.data,
    this.currentPage,
    this.perPage,
    this.total,
    this.lastPage,
    this.from,
    this.to,
  });

  factory CurrentAffairs.fromJson(Map<String, dynamic> json) => CurrentAffairs(
    data: json["data"] == null ? [] : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
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

class Datum {
  final String? date;
  final List<Question>? questions;

  Datum({
    this.date,
    this.questions,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
    date: json["date"] ,
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "date": date,
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Question {
  final int? id;
  final String? questionType;
  final String? title;
  final dynamic description;
  final List<Option>? options;
  final String? explanation;
  final dynamic questionImage;
  final dynamic explanationImage;
  final dynamic note;
  final dynamic reference;
  final DateTime? date;
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
  final List<Subject>? subjects;
  final List<dynamic>? tags;

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
    this.subjects,
    this.tags,
  });

  factory Question.fromJson(Map<String, dynamic> json) => Question(
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
    date: json["date"] == null ? null : DateTime.parse(json["date"]),
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
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
    tags: json["tags"] == null ? [] : List<dynamic>.from(json["tags"]!.map((x) => x)),
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
    "date": "${date!.year.toString().padLeft(4, '0')}-${date!.month.toString().padLeft(2, '0')}-${date!.day.toString().padLeft(2, '0')}",
    "status":status,
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
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "tags": tags == null ? [] : List<dynamic>.from(tags!.map((x) => x)),
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



class Subject {
  final int? id;
  final String? name;
  final String? slug;
  final int? parentId;
  final dynamic image;
  final dynamic description;
  final bool? status;
  final String? metaTitle;
  final dynamic metaDescription;
  final dynamic metaKeywords;
  final dynamic metaImage;
  final dynamic metaAuthor;
  final dynamic metaUrl;
  final dynamic metaData;
  final dynamic headerCode;
  final dynamic footerCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Pivot? pivot;

  Subject({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.image,
    this.description,
    this.status,
    this.metaTitle,
    this.metaDescription,
    this.metaKeywords,
    this.metaImage,
    this.metaAuthor,
    this.metaUrl,
    this.metaData,
    this.headerCode,
    this.footerCode,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.pivot,
  });

  factory Subject.fromJson(Map<String, dynamic> json) => Subject(
    id: json["id"],
    name: json["name"],
    slug: json["slug"],
    parentId: json["parent_id"],
    image: json["image"],
    description: json["description"],
    status: json["status"],
    metaTitle: json["meta_title"],
    metaDescription: json["meta_description"],
    metaKeywords: json["meta_keywords"],
    metaImage: json["meta_image"],
    metaAuthor: json["meta_author"],
    metaUrl: json["meta_url"],
    metaData: json["meta_data"],
    headerCode: json["header_code"],
    footerCode: json["footer_code"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    pivot: json["pivot"] == null ? null : Pivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "image": image,
    "description": description,
    "status": status,
    "meta_title": metaTitle,
    "meta_description": metaDescription,
    "meta_keywords": metaKeywords,
    "meta_image": metaImage,
    "meta_author": metaAuthor,
    "meta_url": metaUrl,
    "meta_data": metaData,
    "header_code": headerCode,
    "footer_code": footerCode,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "pivot": pivot?.toJson(),
  };
}

class Pivot {
  final int? questionId;
  final int? subjectId;

  Pivot({
    this.questionId,
    this.subjectId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
    questionId: json["question_id"],
    subjectId: json["subject_id"],
  );

  Map<String, dynamic> toJson() => {
    "question_id": questionId,
    "subject_id": subjectId,
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
