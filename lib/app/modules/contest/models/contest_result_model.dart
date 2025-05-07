
import 'dart:convert';

import '../../../models/subject.dart';
import '../../../models/user.dart';

ContestResultModel contestResultModelFromJson(String str) => ContestResultModel.fromJson(json.decode(str));

String contestResultModelToJson(ContestResultModel data) => json.encode(data.toJson());

class ContestResultModel {
  final bool? status;
  final Contest? contest;
  final List<ContestResult>? contestResults;

  ContestResultModel({
    this.status,
    this.contest,
    this.contestResults,
  });

  factory ContestResultModel.fromJson(Map<String, dynamic> json) => ContestResultModel(
    status: json["status"],
    contest: json["contest"] == null ? null : Contest.fromJson(json["contest"]),
    contestResults: json["contest_results"] == null ? [] : List<ContestResult>.from(json["contest_results"]!.map((x) => ContestResult.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "contest": contest?.toJson(),
    "contest_results": contestResults == null ? [] : List<dynamic>.from(contestResults!.map((x) => x.toJson())),
  };
}

class Contest {
  final int? id;
  final String? name;
  final String? image;
  final String? slug;
  final dynamic description;
  final int? duration;
  final int? positiveMark;
  final double? negativeMark;
  final DateTime? startDatetime;
  final DateTime? endDatetime;
  final int? autoQuestionCount;
  final int? previousDayCount;
  final dynamic contestPolicy;
  final String? sponsorName;
  final String? sponsorUrl;
  final String? sponsorImage;
  final dynamic sponsorDetails;
  final dynamic prizeDetails;
  final String? status;
  final List<Subject>? subjects;

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
    this.subjects,
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
    subjects: json["subjects"] == null ? [] : List<Subject>.from(json["subjects"]!.map((x) => Subject.fromJson(x))),
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
    "subjects": subjects == null ? [] : List<dynamic>.from(subjects!.map((x) => x.toJson())),
  };
}



class ContestResult {
  final int? id;
  final int? contestId;
  final int? userId;
  final int? totalQuestions;
  final int? correctAnswers;
  final int? incorrectAnswers;
  final int? positiveMark;
  final double? negativeMark;
  final int? selectDuration;
  final int? completeDuration;
  final dynamic createdAt;
  final dynamic updatedAt;
  final User? user;
  final List<dynamic>? activities;
  final Contest? contest;

  ContestResult({
    this.id,
    this.contestId,
    this.userId,
    this.totalQuestions,
    this.correctAnswers,
    this.incorrectAnswers,
    this.positiveMark,
    this.negativeMark,
    this.selectDuration,
    this.completeDuration,
    this.createdAt,
    this.updatedAt,
    this.user,
    this.activities,
    this.contest,
  });

  factory ContestResult.fromJson(Map<String, dynamic> json) => ContestResult(
    id: json["id"],
    contestId: json["contest_id"],
    userId: json["user_id"],
    totalQuestions: json["total_questions"],
    correctAnswers: json["correct_answers"],
    incorrectAnswers: json["incorrect_answers"],
    positiveMark: json["positive_mark"],
    negativeMark: json["negative_mark"]?.toDouble(),
    selectDuration: json["select_duration"],
    completeDuration: json["complete_duration"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    activities: json["activities"] == null ? [] : List<dynamic>.from(json["activities"]!.map((x) => x)),
    contest: json["contest"] == null ? null : Contest.fromJson(json["contest"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "contest_id": contestId,
    "user_id": userId,
    "total_questions": totalQuestions,
    "correct_answers": correctAnswers,
    "incorrect_answers": incorrectAnswers,
    "positive_mark": positiveMark,
    "negative_mark": negativeMark,
    "select_duration": selectDuration,
    "complete_duration": completeDuration,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "user": user?.toJson(),
    "activities": activities == null ? [] : List<dynamic>.from(activities!.map((x) => x)),
    "contest": contest?.toJson(),
  };
}

