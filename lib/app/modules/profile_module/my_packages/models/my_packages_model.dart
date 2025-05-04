// To parse this JSON data, do
//
//     final myPackagesModel = myPackagesModelFromJson(jsonString);

import 'dart:convert';

MyPackagesModel myPackagesModelFromJson(String str) => MyPackagesModel.fromJson(json.decode(str));

String myPackagesModelToJson(MyPackagesModel data) => json.encode(data.toJson());

class MyPackagesModel {
  final bool? status;
  final List<PackageElement>? packages;

  MyPackagesModel({
    this.status,
    this.packages,
  });

  factory MyPackagesModel.fromJson(Map<String, dynamic> json) => MyPackagesModel(
    status: json["status"],
    packages: json["packages"] == null ? [] : List<PackageElement>.from(json["packages"]!.map((x) => PackageElement.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "packages": packages == null ? [] : List<dynamic>.from(packages!.map((x) => x.toJson())),
  };
}

class PackageElement {
  final int? id;
  final int? userId;
  final int? packageId;
  final String? status;
  final DateTime? subscribedAt;
  final DateTime? cancelledAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final PackagePackage? package;
  final User? user;

  PackageElement({
    this.id,
    this.userId,
    this.packageId,
    this.status,
    this.subscribedAt,
    this.cancelledAt,
    this.createdAt,
    this.updatedAt,
    this.package,
    this.user,
  });

  factory PackageElement.fromJson(Map<String, dynamic> json) => PackageElement(
    id: json["id"],
    userId: json["user_id"],
    packageId: json["package_id"],
    status: json["status"],
    subscribedAt: json["subscribed_at"] == null ? null : DateTime.parse(json["subscribed_at"]),
    cancelledAt: json["cancelled_at"] == null ? null : DateTime.parse(json["cancelled_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    package: json["package"] == null ? null : PackagePackage.fromJson(json["package"]),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "package_id": packageId,
    "status": status,
    "subscribed_at": subscribedAt?.toIso8601String(),
    "cancelled_at": cancelledAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "package": package?.toJson(),
    "user": user?.toJson(),
  };
}

class PackagePackage {
  final int? id;
  final String? name;
  final String? description;
  final String? regularPrice;
  final int? duration;
  final String? discount;
  final String? discountedPrice;
  final int? status;
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

  PackagePackage({
    this.id,
    this.name,
    this.description,
    this.regularPrice,
    this.duration,
    this.discount,
    this.discountedPrice,
    this.status,
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

  factory PackagePackage.fromJson(Map<String, dynamic> json) => PackagePackage(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    regularPrice: json["regular_price"],
    duration: json["duration"],
    discount: json["discount"],
    discountedPrice: json["discounted_price"],
    status: json["status"],
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
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
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

class User {
  final int? id;
  final String? name;
  final dynamic email;
  final String? phone;
  final dynamic emailVerifiedAt;
  final DateTime? dateOfBirth;
  final String? gender;
  final dynamic occupation;
  final dynamic organization;
  final dynamic referralCode;
  final String? userId;
  final String? image;
  final dynamic addressLine1;
  final dynamic addressLine2;
  final dynamic city;
  final dynamic state;
  final dynamic zipCode;
  final dynamic country;
  final int? points;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? jwtToken;
  final dynamic googleId;
  final dynamic facebookId;
  final dynamic githubId;
  final dynamic linkedinId;
  final dynamic twitterId;
  final dynamic avatar;
  final dynamic provider;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.dateOfBirth,
    this.gender,
    this.occupation,
    this.organization,
    this.referralCode,
    this.userId,
    this.image,
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.state,
    this.zipCode,
    this.country,
    this.points,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.jwtToken,
    this.googleId,
    this.facebookId,
    this.githubId,
    this.linkedinId,
    this.twitterId,
    this.avatar,
    this.provider,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
    gender: json["gender"],
    occupation: json["occupation"],
    organization: json["organization"],
    referralCode: json["referral_code"],
    userId: json["user_id"],
    image: json["image"],
    addressLine1: json["address_line_1"],
    addressLine2: json["address_line_2"],
    city: json["city"],
    state: json["state"],
    zipCode: json["zip_code"],
    country: json["country"],
    points: json["points"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    jwtToken: json["jwt_token"],
    googleId: json["google_id"],
    facebookId: json["facebook_id"],
    githubId: json["github_id"],
    linkedinId: json["linkedin_id"],
    twitterId: json["twitter_id"],
    avatar: json["avatar"],
    provider: json["provider"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "date_of_birth": "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
    "gender": gender,
    "occupation": occupation,
    "organization": organization,
    "referral_code": referralCode,
    "user_id": userId,
    "image": image,
    "address_line_1": addressLine1,
    "address_line_2": addressLine2,
    "city": city,
    "state": state,
    "zip_code": zipCode,
    "country": country,
    "points": points,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "jwt_token": jwtToken,
    "google_id": googleId,
    "facebook_id": facebookId,
    "github_id": githubId,
    "linkedin_id": linkedinId,
    "twitter_id": twitterId,
    "avatar": avatar,
    "provider": provider,
  };
}
