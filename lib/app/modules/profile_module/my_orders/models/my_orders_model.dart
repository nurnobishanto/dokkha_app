// To parse this JSON data, do
//
//     final myOrdersModel = myOrdersModelFromJson(jsonString);

import 'dart:convert';

MyOrdersModel myOrdersModelFromJson(String str) => MyOrdersModel.fromJson(json.decode(str));

String myOrdersModelToJson(MyOrdersModel data) => json.encode(data.toJson());

class MyOrdersModel {
  final bool? status;
  final List<Order>? orders;

  MyOrdersModel({
    this.status,
    this.orders,
  });

  factory MyOrdersModel.fromJson(Map<String, dynamic> json) => MyOrdersModel(
    status: json["status"],
    orders: json["orders"] == null ? [] : List<Order>.from(json["orders"]!.map((x) => Order.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "orders": orders == null ? [] : List<dynamic>.from(orders!.map((x) => x.toJson())),
  };
}

class Order {
  final int? id;
  final String? invoiceNo;
  final int? userId;
  final int? modelId;
  final String? modelType;
  final int? couponId;
  final int? userPackageId;
  final String? paymentMethod;
  final dynamic transactionId;
  final String? status;
  final String? subtotal;
  final String? discount;
  final String? total;
  final String? billingDetails;
  final dynamic paidAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final User? user;
  final List<Payment>? payments;

  Order({
    this.id,
    this.invoiceNo,
    this.userId,
    this.modelId,
    this.modelType,
    this.couponId,
    this.userPackageId,
    this.paymentMethod,
    this.transactionId,
    this.status,
    this.subtotal,
    this.discount,
    this.total,
    this.billingDetails,
    this.paidAt,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.user,
    this.payments,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    invoiceNo: json["invoice_no"],
    userId: json["user_id"],
    modelId: json["model_id"],
    modelType: json["model_type"],
    couponId: json["coupon_id"],
    userPackageId: json["user_package_id"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    status: json["status"],
    subtotal: json["subtotal"],
    discount: json["discount"],
    total: json["total"],
    billingDetails: json["billing_details"],
    paidAt: json["paid_at"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    user: json["user"] == null ? null : User.fromJson(json["user"]),
    payments: json["payments"] == null ? [] : List<Payment>.from(json["payments"]!.map((x) => Payment.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "invoice_no": invoiceNo,
    "user_id": userId,
    "model_id": modelId,
    "model_type": modelType,
    "coupon_id": couponId,
    "user_package_id": userPackageId,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "status": status,
    "subtotal": subtotal,
    "discount": discount,
    "total": total,
    "billing_details": billingDetails,
    "paid_at": paidAt,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "user": user?.toJson(),
    "payments": payments == null ? [] : List<dynamic>.from(payments!.map((x) => x.toJson())),
  };
}

class Payment {
  final int? id;
  final int? userId;
  final int? orderId;
  final String? transactionId;
  final String? amount;
  final String? paymentMethod;
  final String? status;
  final String? request;
  final String? response;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  Payment({
    this.id,
    this.userId,
    this.orderId,
    this.transactionId,
    this.amount,
    this.paymentMethod,
    this.status,
    this.request,
    this.response,
    this.createdAt,
    this.updatedAt,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    id: json["id"],
    userId: json["user_id"],
    orderId: json["order_id"],
    transactionId: json["transaction_id"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    request: json["request"],
    response: json["response"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "order_id": orderId,
    "transaction_id": transactionId,
    "amount": amount,
    "payment_method": paymentMethod,
    "status": status,
    "request": request,
    "response": response,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
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
