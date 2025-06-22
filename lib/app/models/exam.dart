import 'package:lokkha/app/models/question.dart';
import 'package:lokkha/app/models/subject.dart';

class Exam {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;
  final String? description;
  final bool? isPractice;
  final int? duration;
  final int? positiveMark;
  final double? negativeMark;
  final DateTime? startDatetime;
  final DateTime? endDatetime;
  final dynamic autoQuestionCount;
  final dynamic previousDayCount;
  final dynamic examPolicy;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final ExamModelTestPivot? examModelTestPivot;
  final List<Subject>? subjects;
  final List<Question>? questions;
  final List<Subject>? primarySubjects;
  final List<Subject>? secondarySubjects;

  Exam({
    this.id,
    this.name,
    this.image,
    this.slug,
    this.description,
    this.isPractice,
    this.duration,
    this.positiveMark,
    this.negativeMark,
    this.startDatetime,
    this.endDatetime,
    this.autoQuestionCount,
    this.previousDayCount,
    this.examPolicy,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.examModelTestPivot,
    this.subjects,
    this.questions,
    this.primarySubjects,
    this.secondarySubjects,
  });

  factory Exam.fromJson(Map<String, dynamic> json) => Exam(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        slug: json["slug"],
        description: json["description"],
        isPractice: json["is_practice"],
        duration: json["duration"],
        positiveMark: json["positive_mark"],
        negativeMark: json["negative_mark"]?.toDouble(),
        startDatetime: json["start_datetime"] == null
            ? null
            : DateTime.parse(json["start_datetime"]),
        endDatetime: json["end_datetime"] == null
            ? null
            : DateTime.parse(json["end_datetime"]),
        autoQuestionCount: json["auto_question_count"],
        previousDayCount: json["previous_day_count"],
        examPolicy: json["exam_policy"],
        status: json["status"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        examModelTestPivot: json["pivot"] == null
            ? null
            : ExamModelTestPivot.fromJson(json["pivot"]),
        subjects: json["subjects"] == null
            ? []
            : List<Subject>.from(
                json["subjects"]!.map((x) => Subject.fromJson(x))),
        questions: json["questions"] == null
            ? []
            : List<Question>.from(
                json["questions"]!.map((x) => Question.fromJson(x))),
        primarySubjects: json["primary_subjects"] == null
            ? []
            : List<Subject>.from(
                json["primary_subjects"]!.map((x) => Subject.fromJson(x))),
        secondarySubjects: json["secondary_subjects"] == null
            ? []
            : List<Subject>.from(
                json["secondary_subjects"]!.map((x) => Subject.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "slug": slug,
        "description": description,
        "is_practice": isPractice,
        "duration": duration,
        "positive_mark": positiveMark,
        "negative_mark": negativeMark,
        "start_datetime": startDatetime?.toIso8601String(),
        "end_datetime": endDatetime?.toIso8601String(),
        "auto_question_count": autoQuestionCount,
        "previous_day_count": previousDayCount,
        "exam_policy": examPolicy,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
        "pivot": examModelTestPivot?.toJson(),
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
        "questions": questions == null
            ? []
            : List<dynamic>.from(questions!.map((x) => x)),
        "primary_subjects": primarySubjects == null
            ? []
            : List<dynamic>.from(primarySubjects!.map((x) => x.toJson())),
        "secondary_subjects": secondarySubjects == null
            ? []
            : List<dynamic>.from(secondarySubjects!.map((x) => x.toJson())),
      };
}

class ExamModelTestPivot {
  final int? modelTestId;
  final int? examId;
  final int? isFree;

  ExamModelTestPivot({
    this.modelTestId,
    this.examId,
    this.isFree,
  });

  factory ExamModelTestPivot.fromJson(Map<String, dynamic> json) =>
      ExamModelTestPivot(
        modelTestId: json["model_test_id"],
        examId: json["exam_id"],
        isFree: json["is_free"],
      );

  Map<String, dynamic> toJson() => {
        "model_test_id": modelTestId,
        "exam_id": examId,
        "is_free": isFree,
      };
}
