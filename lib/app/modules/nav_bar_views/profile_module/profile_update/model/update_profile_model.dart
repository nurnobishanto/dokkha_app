// To parse this JSON data, do
//
//     final profileUpdateModel = profileUpdateModelFromJson(jsonString);

import 'dart:convert';

ProfileUpdateModel profileUpdateModelFromJson(String str) => ProfileUpdateModel.fromJson(json.decode(str));

String profileUpdateModelToJson(ProfileUpdateModel data) => json.encode(data.toJson());

class ProfileUpdateModel {
  final bool? status;
  final String? message;
  final Data? data;

  ProfileUpdateModel({
    this.status,
    this.message,
    this.data,
  });

  factory ProfileUpdateModel.fromJson(Map<String, dynamic> json) => ProfileUpdateModel(
    status: json["status"],
    message: json["message"],
    data: json["data"] == null ? null : Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": data?.toJson(),
  };
}

class Data {
  final int? id;
  final String? name;
  final dynamic email;
  final String? phone;
  final dynamic emailVerifiedAt;
  final dynamic dateOfBirth;
  final dynamic gender;
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

  Data({
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

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    dateOfBirth: json["date_of_birth"],
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
    "date_of_birth": dateOfBirth,
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
