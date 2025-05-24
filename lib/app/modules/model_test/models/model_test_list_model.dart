import 'dart:convert';

import 'package:lokkha/app/models/question.dart';
import 'package:lokkha/app/models/subject.dart';

import '../../../models/category.dart';
import '../../../models/exam.dart';

ModelTestListModel modelTestListModelFromJson(String str) => ModelTestListModel.fromJson(json.decode(str));

String modelTestListModelToJson(ModelTestListModel data) => json.encode(data.toJson());

class ModelTestListModel {
  final bool? status;
  final Data? data;

  ModelTestListModel({
    this.status,
    this.data,
  });

  factory ModelTestListModel.fromJson(Map<String, dynamic> json) => ModelTestListModel(
    status: json["status"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "data": data?.toJson(),
  };
}

class Data {
  final int? currentPage;
  final List<ModelTest>? data;
  final String? firstPageUrl;
  final int? from;
  final int? lastPage;
  final String? lastPageUrl;
  final List<Link>? links;
  final dynamic nextPageUrl;
  final String? path;
  final int? perPage;
  final dynamic prevPageUrl;
  final int? to;
  final int? total;

  Data({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.links,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    currentPage: json["current_page"],
    data: json["data"] == null ? [] : List<ModelTest>.from(json["data"]!.map((x) => ModelTest.fromJson(x))),
    firstPageUrl: json["first_page_url"],
    from: json["from"],
    lastPage: json["last_page"],
    lastPageUrl: json["last_page_url"],
    links: json["links"] == null ? [] : List<Link>.from(json["links"]!.map((x) => Link.fromJson(x))),
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: json["per_page"],
    prevPageUrl: json["prev_page_url"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? [] : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "links": links == null ? [] : List<dynamic>.from(links!.map((x) => x.toJson())),
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

class ModelTest {
  final int? id;
  final String? title;
  final String? slug;
  final String? description;
  final int? categoryId;
  final String? image;
  final int? order;
  final int? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final List<Exam>? exams;
  final Category? category;

  ModelTest({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.categoryId,
    this.image,
    this.order,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.exams,
    this.category,
  });

  factory ModelTest.fromJson(Map<String, dynamic> json) => ModelTest(
    id: json["id"],
    title: json["title"],
    slug: json["slug"],
    description: json["description"],
    categoryId: json["category_id"],
    image: json["image"],
    order: json["order"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    exams: json["exams"] == null ? [] : List<Exam>.from(json["exams"]!.map((x) => Exam.fromJson(x))),
    category: json["category"] == null ? null : Category.fromJson(json["category"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "slug": slug,
    "description": description,
    "category_id": categoryId,
    "image": image,
    "order": order,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "exams": exams == null ? [] : List<dynamic>.from(exams!.map((x) => x.toJson())),
    "category": category?.toJson(),
  };
}

class Link {
  final String? url;
  final String? label;
  final bool? active;

  Link({
    this.url,
    this.label,
    this.active,
  });

  factory Link.fromJson(Map<String, dynamic> json) => Link(
    url: json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "url": url,
    "label": label,
    "active": active,
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
