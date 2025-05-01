import 'dart:convert';
SubjectSectionModel subjectSectionModelFromJson(String str) => SubjectSectionModel.fromJson(json.decode(str));
String subjectSectionModelToJson(SubjectSectionModel data) => json.encode(data.toJson());

class SubjectSectionModel {
  final bool? status;
  final List<SubjectSection>? subjectSections;

  SubjectSectionModel({
    this.status,
    this.subjectSections,
  });

  factory SubjectSectionModel.fromJson(Map<String, dynamic> json) => SubjectSectionModel(
    status: json["status"],
    subjectSections: json["subject_sections"] == null ? [] : List<SubjectSection>.from(json["subject_sections"]!.map((x) => SubjectSection.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "subject_sections": subjectSections == null ? [] : List<dynamic>.from(subjectSections!.map((x) => x.toJson())),
  };
}

class SubjectSection {
  final int? id;
  final int? subjectId;
  final String? name;
  final int? sorting;
  final int? status;
  final dynamic deletedAt;
  final dynamic createdAt;
  final dynamic updatedAt;
  final Subject? subject;

  SubjectSection({
    this.id,
    this.subjectId,
    this.name,
    this.sorting,
    this.status,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.subject,
  });

  factory SubjectSection.fromJson(Map<String, dynamic> json) => SubjectSection(
    id: json["id"],
    subjectId: json["subject_id"],
    name: json["name"],
    sorting: json["sorting"],
    status: json["status"],
    deletedAt: json["deleted_at"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
    subject: json["subject"] == null ? null : Subject.fromJson(json["subject"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "subject_id": subjectId,
    "name": name,
    "sorting": sorting,
    "status": status,
    "deleted_at": deletedAt,
    "created_at": createdAt,
    "updated_at": updatedAt,
    "subject": subject?.toJson(),
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
  final List<Subject>? children;

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
    this.children,
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
    children: json["children"] == null ? [] : List<Subject>.from(json["children"]!.map((x) => Subject.fromJson(x))),
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
    "children": children == null ? [] : List<dynamic>.from(children!.map((x) => x.toJson())),
  };
}
