import 'package:lokkha/app/models/coupon.dart';
import 'package:lokkha/app/models/payment.dart';
import 'package:lokkha/app/models/user.dart';
import 'package:lokkha/app/models/package.dart';

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
  final dynamic total;
  final String? billingDetails;
  final dynamic paidAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final Package? package;
  final User? user;
  final List<Payment>? payments;
  final Coupon? coupon;

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
    this.package,
    this.user,
    this.payments,
    this.coupon,
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
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        deletedAt: json["deleted_at"],
        package: json["model"] == null ? null : Package.fromJson(json["model"]),
        user: json["user"] == null ? null : User.fromJson(json["user"]),
        payments: json["payments"] == null
            ? []
            : List<Payment>.from(
                json["payments"]!.map((x) => Payment.fromJson(x))),
        coupon: json["coupon"] == null ? null : Coupon.fromJson(json["coupon"]),
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
        "package": package?.toJson(),
        "payments": payments == null
            ? []
            : List<dynamic>.from(payments!.map((x) => x.toJson())),
        "coupon": coupon?.toJson(),
      };
}
