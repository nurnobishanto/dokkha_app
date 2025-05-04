// To parse this JSON data, do
//
//     final myOrdersDetailsModel = myOrdersDetailsModelFromJson(jsonString);

import 'dart:convert';

MyOrdersDetailsModel myOrdersDetailsModelFromJson(String str) => MyOrdersDetailsModel.fromJson(json.decode(str));

String myOrdersDetailsModelToJson(MyOrdersDetailsModel data) => json.encode(data.toJson());

class MyOrdersDetailsModel {
  final bool? status;
  final Order? order;
  final Payment? payment;
  final String? paymentUrl;

  MyOrdersDetailsModel({
    this.status,
    this.order,
    this.payment,
    this.paymentUrl,
  });

  factory MyOrdersDetailsModel.fromJson(Map<String, dynamic> json) => MyOrdersDetailsModel(
    status: json["status"],
    order: json["order"] == null ? null : Order.fromJson(json["order"]),
    payment: json["payment"] == null ? null : Payment.fromJson(json["payment"]),
    paymentUrl: json["payment_url"],
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "order": order?.toJson(),
    "payment": payment?.toJson(),
    "payment_url": paymentUrl,
  };
}

class Order {
  final int? id;
  final String? invoiceNo;
  final int? userId;
  final int? modelId;
  final String? modelType;
  final dynamic couponId;
  final dynamic userPackageId;
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
  final dynamic response;
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
