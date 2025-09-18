
import 'dart:convert';
ExamCategoryDetailsModel examCategoryDetailsModelFromJson(String str) =>
    ExamCategoryDetailsModel.fromJson(json.decode(str));
String examCategoryDetailsModelToJson(ExamCategoryDetailsModel data) =>
    json.encode(data.toJson());

class ExamCategoryDetailsModel {
  final bool? status;
  final ExamCategory? examCategory;
  final List<FreeExam>? freeExams;

  ExamCategoryDetailsModel({
    this.status,
    this.examCategory,
    this.freeExams,
  });

  factory ExamCategoryDetailsModel.fromJson(Map<String, dynamic> json) =>
      ExamCategoryDetailsModel(
        status: json["status"],
        examCategory: json["exam_category"] == null
            ? null
            : ExamCategory.fromJson(json["exam_category"]),
        freeExams: json["free_exams"] == null
            ? []
            : List<FreeExam>.from(
                json["free_exams"]!.map((x) => FreeExam.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "exam_category": examCategory?.toJson(),
        "free_exams": freeExams == null
            ? []
            : List<dynamic>.from(freeExams!.map((x) => x.toJson())),
      };
}

class ExamCategory {
  final int? id;
  final String? name;
  final String? slug;
  final dynamic parentId;
  final String? image;
  final dynamic description;
  final bool? status;
  final String? metaTitle;
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

  ExamCategory({
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
  });

  factory ExamCategory.fromJson(Map<String, dynamic> json) => ExamCategory(
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
      };
}

class FreeExam {
  final int? id;
  final DateTime? publishedAt;
  final bool? isPaid;
  final String? name;
  final String? image;
  final String? slug;
  final dynamic description;
  final int? duration;
  final int? positiveMark;
  final double? negativeMark;
  final dynamic examPolicy;
  final String? status;
  final int? createdBy;
  final int? updatedBy;
  final dynamic confirmedBy;
  final dynamic confirmedAt;
  final dynamic approvedBy;
  final dynamic approvedAt;
  final dynamic rejectedBy;
  final dynamic rejectedAt;
  final dynamic finalBy;
  final dynamic finalAt;
  final String? metaTitle;
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
  final int? examCategoryId;

  FreeExam({
    this.id,
    this.publishedAt,
    this.isPaid,
    this.name,
    this.image,
    this.slug,
    this.description,
    this.duration,
    this.positiveMark,
    this.negativeMark,
    this.examPolicy,
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
    this.examCategoryId,
  });

  factory FreeExam.fromJson(Map<String, dynamic> json) => FreeExam(
        id: json["id"],
        publishedAt: json["published_at"] == null
            ? null
            : DateTime.parse(json["published_at"]),
        isPaid: json["is_paid"],
        name: json["name"],
        image: json["image"],
        slug: json["slug"],
        description: json["description"],
        duration: json["duration"],
        positiveMark: json["positive_mark"],
        negativeMark: json["negative_mark"]?.toDouble(),
        examPolicy: json["exam_policy"],
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
        examCategoryId: json["exam_category_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "published_at": publishedAt?.toIso8601String(),
        "is_paid": isPaid,
        "name": name,
        "image": image,
        "slug": slug,
        "description": description,
        "duration": duration,
        "positive_mark": positiveMark,
        "negative_mark": negativeMark,
        "exam_policy": examPolicy,
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
        "exam_category_id": examCategoryId,
      };
}
