// To parse this JSON data, do
//
//     final myOrdersDetailsModel = myOrdersDetailsModelFromJson(jsonString);

import 'dart:convert';

import '../../../../models/order.dart';
import '../../../../models/payment.dart';

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



