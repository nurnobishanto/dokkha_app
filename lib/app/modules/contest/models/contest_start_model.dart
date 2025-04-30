
import 'dart:convert';

ContestStartModel contestStartModelFromJson(String str) => ContestStartModel.fromJson(json.decode(str));

String contestStartModelToJson(ContestStartModel data) => json.encode(data.toJson());

class ContestStartModel {
  final bool? status;
  final Contest? contest;
  final List<Question>? questions;

  ContestStartModel({
    this.status,
    this.contest,
    this.questions,
  });

  factory ContestStartModel.fromJson(Map<String, dynamic> json) => ContestStartModel(
    status: json["status"],
    contest: json["contest"] == null ? null : Contest.fromJson(json["contest"]),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "contest": contest?.toJson(),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
  };
}

class Contest {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;
  final String? description;
  final int? duration;
  final int? positiveMark;
  final double? negativeMark;
  final DateTime? startDatetime;
  final DateTime? endDatetime;
  final int? autoQuestionCount;
  final int? previousDayCount;
  final String? contestPolicy;
  final String? sponsorName;
  final String? sponsorUrl;
  final String? sponsorImage;
  final String? sponsorDetails;
  final String? prizeDetails;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Subject>? subjects;
  final List<Question>? questions;

  Contest({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.description,
    this.duration,
    this.positiveMark,
    this.negativeMark,
    this.startDatetime,
    this.endDatetime,
    this.autoQuestionCount,
    this.previousDayCount,
    this.contestPolicy,
    this.sponsorName,
    this.sponsorUrl,
    this.sponsorImage,
    this.sponsorDetails,
    this.prizeDetails,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.subjects,
    this.questions,
  });

  factory Contest.fromJson(Map<String, dynamic> json) => Contest(
    id: json["id"],
    name: json["name"],
    image: json["image"],
    slug: json["slug"],
    description: json["description"],
    duration: json["duration"],
    positiveMark: json["positive_mark"],
    negativeMark: json["negative_mark"]?.toDouble(),
    startDatetime: json["start_datetime"] == null ? null : DateTime.parse(json["start_datetime"]),
    endDatetime: json["end_datetime"] == null ? null : DateTime.parse(json["end_datetime"]),
    autoQuestionCount: json["auto_question_count"],
    previousDayCount: json["previous_day_count"],
    contestPolicy: json["contest_policy"],
    sponsorName: json["sponsor_name"],
    sponsorUrl: json["sponsor_url"],
    sponsorImage: json["sponsor_image"],
    sponsorDetails: json["sponsor_details"],
    prizeDetails: json["prize_details"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
    questions: json["questions"] == null ? [] : List<Question>.from(json["questions"]!.map((x) => Question.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "image": image,
    "slug": slug,
    "description": description,
    "duration": duration,
    "positive_mark": positiveMark,
    "negative_mark": negativeMark,
    "start_datetime": startDatetime?.toIso8601String(),
    "end_datetime": endDatetime?.toIso8601String(),
    "auto_question_count": autoQuestionCount,
    "previous_day_count": previousDayCount,
    "contest_policy": contestPolicy,
    "sponsor_name": sponsorName,
    "sponsor_url": sponsorUrl,
    "sponsor_image": sponsorImage,
    "sponsor_details": sponsorDetails,
    "prize_details": prizeDetails,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
    "questions": questions == null ? [] : List<dynamic>.from(questions!.map((x) => x.toJson())),
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
  final DateTime? updatedAt;
  final int? createdBy;
  final int? updatedBy;

  final QuestionPivot? pivot;

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
    this.createdBy,
    this.updatedBy,
    this.pivot,
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
    date: json["date"] ,
    status: json["status"],
    customId: json["custom_id"],
    comment: json["comment"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdBy: json["created_by"],
    updatedBy: json["updated_by"],
    pivot: json["pivot"] == null ? null : QuestionPivot.fromJson(json["pivot"]),
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
    "updated_at": updatedAt?.toIso8601String(),
    "created_by": createdBy,
    "updated_by": updatedBy,
    "pivot": pivot?.toJson(),
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

class QuestionPivot {
  final int? contestId;
  final int? questionId;

  QuestionPivot({
    this.contestId,
    this.questionId,
  });

  factory QuestionPivot.fromJson(Map<String, dynamic> json) => QuestionPivot(
    contestId: json["contest_id"],
    questionId: json["question_id"],
  );

  Map<String, dynamic> toJson() => {
    "contest_id": contestId,
    "question_id": questionId,
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


class Subject {
  final int? id;
  final String? name;
  final String? slug;
  final int? parentId;
  final String? image;
  final String? description;
  final bool? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  final SubjectPivot? pivot;

  Subject({
    this.id,
    this.name,
    this.slug,
    this.parentId,
    this.image,
    this.description,
    this.status,
    this.createdAt,
    this.updatedAt,
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    pivot: json["pivot"] == null ? null : SubjectPivot.fromJson(json["pivot"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "slug": slug,
    "parent_id": parentId,
    "image": image,
    "description": description,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "pivot": pivot?.toJson(),
  };
}

class SubjectPivot {
  final int? contestId;
  final int? subjectId;

  SubjectPivot({
    this.contestId,
    this.subjectId,
  });

  factory SubjectPivot.fromJson(Map<String, dynamic> json) => SubjectPivot(
    contestId: json["contest_id"],
    subjectId: json["subject_id"],
  );

  Map<String, dynamic> toJson() => {
    "contest_id": contestId,
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
