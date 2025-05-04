// To parse this JSON data, do
//
//     final packageCheckoutModel = packageCheckoutModelFromJson(jsonString);

import 'dart:convert';

PackageCheckoutModel packageCheckoutModelFromJson(String str) => PackageCheckoutModel.fromJson(json.decode(str));

String packageCheckoutModelToJson(PackageCheckoutModel data) => json.encode(data.toJson());

class PackageCheckoutModel {
  final bool? status;
  final Order? order;
  final Payment? payment;
  final String? paymentUrl;

  PackageCheckoutModel({
    this.status,
    this.order,
    this.payment,
    this.paymentUrl,
  });

  factory PackageCheckoutModel.fromJson(Map<String, dynamic> json) => PackageCheckoutModel(
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
  final int? userId;
  final int? modelId;
  final String? modelType;
  final String? paymentMethod;
  final String? status;
  final String? subtotal;
  final String? discount;
  final String? total;
  final String? billingDetails;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? invoiceNo;

  Order({
    this.userId,
    this.modelId,
    this.modelType,
    this.paymentMethod,
    this.status,
    this.subtotal,
    this.discount,
    this.total,
    this.billingDetails,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.invoiceNo,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    userId: json["user_id"],
    modelId: json["model_id"],
    modelType: json["model_type"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    subtotal: json["subtotal"],
    discount: json["discount"],
    total: json["total"],
    billingDetails: json["billing_details"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    invoiceNo: json["invoice_no"],
  );

  Map<String, dynamic> toJson() => {
    "user_id": userId,
    "model_id": modelId,
    "model_type": modelType,
    "payment_method": paymentMethod,
    "status": status,
    "subtotal": subtotal,
    "discount": discount,
    "total": total,
    "billing_details": billingDetails,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "invoice_no": invoiceNo,
  };
}

class Payment {
  final int? orderId;
  final int? userId;
  final String? amount;
  final String? paymentMethod;
  final String? status;
  final String? request;
  final dynamic response;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;
  final String? transactionId;

  Payment({
    this.orderId,
    this.userId,
    this.amount,
    this.paymentMethod,
    this.status,
    this.request,
    this.response,
    this.updatedAt,
    this.createdAt,
    this.id,
    this.transactionId,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    orderId: json["order_id"],
    userId: json["user_id"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
    status: json["status"],
    request: json["request"],
    response: json["response"],
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    id: json["id"],
    transactionId: json["transaction_id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "user_id": userId,
    "amount": amount,
    "payment_method": paymentMethod,
    "status": status,
    "request": request,
    "response": response,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
    "transaction_id": transactionId,
  };
}
