class Package {
  final int? id;
  final String? name;
  final String? description;
  final String? regularPrice;
  final int? duration;
  final String? discount;
  final String? discountedPrice;
  final int? status;
  final int? isMega;
  final int? isFemale;
  final int? isFeatured;
  final String? features;
  final int? isTrial;
  final dynamic trialDuration;
  final String? termsAndConditions;
  final dynamic metaTitle;
  final String? metaDescription;
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

  Package({
    this.id,
    this.name,
    this.description,
    this.regularPrice,
    this.duration,
    this.discount,
    this.discountedPrice,
    this.status,
    this.isMega,
    this.isFemale,
    this.isFeatured,
    this.features,
    this.isTrial,
    this.trialDuration,
    this.termsAndConditions,
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

  factory Package.fromJson(Map<String, dynamic> json) => Package(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        regularPrice: json["regular_price"],
        duration: json["duration"],
        discount: json["discount"],
        discountedPrice: json["discounted_price"],
        status: json["status"],
        isMega: json["is_mega"],
        isFemale: json["is_female"],
        isFeatured: json["is_featured"],
        features: json["features"],
        isTrial: json["is_trial"],
        trialDuration: json["trial_duration"],
        termsAndConditions: json["terms_and_conditions"],
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
        "description": description,
        "regular_price": regularPrice,
        "duration": duration,
        "discount": discount,
        "discounted_price": discountedPrice,
        "status": status,
        "is_mega": isMega,
        "is_female": isFemale,
        "is_featured": isFeatured,
        "features": features,
        "is_trial": isTrial,
        "trial_duration": trialDuration,
        "terms_and_conditions": termsAndConditions,
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
