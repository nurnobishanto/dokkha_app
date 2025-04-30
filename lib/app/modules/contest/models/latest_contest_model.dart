// To parse this JSON data, do
//
//     final latestContestModel = latestContestModelFromJson(jsonString);

import 'dart:convert';

LatestContestModel latestContestModelFromJson(String str) =>
    LatestContestModel.fromJson(json.decode(str));

String latestContestModelToJson(LatestContestModel data) =>
    json.encode(data.toJson());

class LatestContestModel {
  final bool? status;
  final Contest? contest;

  LatestContestModel({
    this.status,
    this.contest,
  });

  factory LatestContestModel.fromJson(Map<String, dynamic> json) =>
      LatestContestModel(
        status: json["status"],
        contest:
            json["contest"] == null ? null : Contest.fromJson(json["contest"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "contest": contest?.toJson(),
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
  final dynamic createdBy;
  final dynamic updatedBy;
  final dynamic confirmedBy;
  final dynamic confirmedAt;
  final dynamic approvedBy;
  final dynamic approvedAt;
  final dynamic rejectedBy;
  final dynamic rejectedAt;
  final dynamic finalBy;
  final dynamic finalAt;
  final dynamic metaTitle;
  final dynamic metaDescription;
  final dynamic metaKeywords;
  final String? metaImage;
  final dynamic metaAuthor;
  final dynamic metaUrl;
  final dynamic metaData;
  final dynamic headerCode;
  final dynamic footerCode;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
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
        startDatetime: json["start_datetime"] == null
            ? null
            : DateTime.parse(json["start_datetime"]),
        endDatetime: json["end_datetime"] == null
            ? null
            : DateTime.parse(json["end_datetime"]),
        autoQuestionCount: json["auto_question_count"],
        previousDayCount: json["previous_day_count"],
        contestPolicy: json["contest_policy"],
        sponsorName: json["sponsor_name"],
        sponsorUrl: json["sponsor_url"],
        sponsorImage: json["sponsor_image"],
        sponsorDetails: json["sponsor_details"],
        prizeDetails: json["prize_details"],
        status: json["status"],
        createdBy: json["created_by"],
        updatedBy: json["updated_by"],
        confirmedBy: json["confirmed_by"],
        confirmedAt: json["confirmed_at"],
        approvedBy: json["approved_by"],
        approvedAt: json["approved_at"],
        rejectedBy: json["rejected_by"],
        rejectedAt: json["rejected_at"],
        finalBy: json["final_by"],
        finalAt: json["final_at"],
        metaTitle: json["meta_title"],
        metaDescription: json["meta_description"],
        metaKeywords: json["meta_keywords"],
        metaImage: json["meta_image"],
        metaAuthor: json["meta_author"],
        metaUrl: json["meta_url"],
        metaData: json["meta_data"],
        headerCode: json["header_code"],
        footerCode: json["footer_code"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        subjects: json["subjects"] == null
            ? []
            : List<Subject>.from(
                json["subjects"]!.map((x) => Subject.fromJson(x))),
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
        "created_by": createdBy,
        "updated_by": updatedBy,
        "confirmed_by": confirmedBy,
        "confirmed_at": confirmedAt,
        "approved_by": approvedBy,
        "approved_at": approvedAt,
        "rejected_by": rejectedBy,
        "rejected_at": rejectedAt,
        "final_by": finalBy,
        "final_at": finalAt,
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
        "subjects": subjects == null
            ? []
            : List<dynamic>.from(subjects!.map((x) => x.toJson())),
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
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
  final int? contestId;
  final int? subjectId;

  Pivot({
    this.contestId,
    this.subjectId,
  });

  factory Pivot.fromJson(Map<String, dynamic> json) => Pivot(
        contestId: json["contest_id"],
        subjectId: json["subject_id"],
      );

  Map<String, dynamic> toJson() => {
        "contest_id": contestId,
        "subject_id": subjectId,
      };
}
