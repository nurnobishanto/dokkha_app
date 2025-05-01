// To parse this JSON data, do
//
//     final packageCheckoutModel = packageCheckoutModelFromJson(jsonString);

import 'dart:convert';

PackageCheckoutModel packageCheckoutModelFromJson(String str) =>
    PackageCheckoutModel.fromJson(json.decode(str));

String packageCheckoutModelToJson(PackageCheckoutModel data) =>
    json.encode(data.toJson());

class PackageCheckoutModel {
  final bool? status;
  final Order? order;
  final List<OrderItemElement>? orderItem;
  final Payment? payment;
  final String? paymentUrl;

  PackageCheckoutModel({
    this.status,
    this.order,
    this.orderItem,
    this.payment,
    this.paymentUrl,
  });

  factory PackageCheckoutModel.fromJson(Map<String, dynamic> json) =>
      PackageCheckoutModel(
        status: json["status"],
        order: json["order"] == null ? null : Order.fromJson(json["order"]),
        orderItem: json["order_item"] == null
            ? []
            : List<OrderItemElement>.from(
            json["order_item"]!.map((x) => OrderItemElement.fromJson(x))),
        payment:
        json["payment"] == null ? null : Payment.fromJson(json["payment"]),
        paymentUrl: json["payment_url"],
      );

  Map<String, dynamic> toJson() => {
    "status": status,
    "order": order?.toJson(),
    "order_item": orderItem == null
        ? []
        : List<dynamic>.from(orderItem!.map((x) => x.toJson())),
    "payment": payment?.toJson(),
    "payment_url": paymentUrl,
  };
}

class Order {
  final int id;
  final int orderId;
  final int userId;
  final dynamic shippingAddressId;
  final dynamic billingAddressId;
  final String? paymentMethod;
  final String? totalAmount;
  final String? payableAmount;
  final String? paidAmount;
  final String? due;
  final String? deliveryCharge;
  final String? discount;
  final dynamic note;
  final String? ip;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final List<OrderItemElement>? items;
  final User? user;

  Order({
    required this.id,
    required this.orderId,
    required this.userId,
    this.shippingAddressId,
    this.billingAddressId,
    this.paymentMethod,
    this.totalAmount,
    this.payableAmount,
    this.paidAmount,
    this.due,
    this.deliveryCharge,
    this.discount,
    this.note,
    this.ip,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.items,
    this.user,
  });

  factory Order.fromJson(Map<String, dynamic> json) => Order(
    id: json["id"],
    orderId: json["order_id"],
    userId: json["user_id"],
    shippingAddressId: json["shipping_address_id"],
    billingAddressId: json["billing_address_id"],
    paymentMethod: json["payment_method"],
    totalAmount: json["total_amount"],
    payableAmount: json["payable_amount"],
    paidAmount: json["paid_amount"],
    due: json["due"],
    deliveryCharge: json["delivery_charge"],
    discount: json["discount"],
    note: json["note"],
    ip: json["ip"],
    status: json["status"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    items: json["items"] == null
        ? []
        : List<OrderItemElement>.from(
        json["items"]!.map((x) => OrderItemElement.fromJson(x))),
    user: json["user"] == null ? null : User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "user_id": userId,
    "shipping_address_id": shippingAddressId,
    "billing_address_id": billingAddressId,
    "payment_method": paymentMethod,
    "total_amount": totalAmount,
    "payable_amount": payableAmount,
    "paid_amount": paidAmount,
    "due": due,
    "delivery_charge": deliveryCharge,
    "discount": discount,
    "note": note,
    "ip": ip,
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "items": items == null
        ? []
        : List<dynamic>.from(items!.map((x) => x.toJson())),
    "user": user?.toJson(),
  };
}

class OrderItemElement {
  final int? id;
  final int? orderId;
  final int? itemId;
  final String? itemType;
  final String? quantity;
  final String? price;
  final String? subtotal;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final OrderItemItem? item;

  OrderItemElement({
    this.id,
    this.orderId,
    this.itemId,
    this.itemType,
    this.quantity,
    this.price,
    this.subtotal,
    this.createdAt,
    this.updatedAt,
    this.item,
  });

  factory OrderItemElement.fromJson(Map<String, dynamic> json) =>
      OrderItemElement(
        id: json["id"],
        orderId: json["order_id"],
        itemId: json["item_id"],
        itemType: json["item_type"].toString(),
        quantity: json["quantity"].toString(),
        price: json["price"].toString(),
        subtotal: json["subtotal"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
        item:
        json["item"] == null ? null : OrderItemItem.fromJson(json["item"]),
      );

  Map<String, dynamic> toJson() => {
    "id": id,
    "order_id": orderId,
    "item_id": itemId,
    "item_type": itemType,
    "quantity": quantity,
    "price": price,
    "subtotal": subtotal,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "item": item?.toJson(),
  };
}

class OrderItemItem {
  final int? id;
  final String? name;
  final dynamic nameEn;
  final dynamic description;
  final dynamic descriptionEn;
  final String? regularPrice;
  final String? price;
  final String? duration;
  final List<String>? features;
  final String? status;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;

  OrderItemItem({
    this.id,
    this.name,
    this.nameEn,
    this.description,
    this.descriptionEn,
    this.regularPrice,
    this.price,
    this.duration,
    this.features,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
  });

  factory OrderItemItem.fromJson(Map<String, dynamic> json) => OrderItemItem(
    id: json["id"],
    name: json["name"],
    nameEn: json["name_en"],
    description: json["description"],
    descriptionEn: json["description_en"],
    regularPrice: json["regular_price"],
    price: json["price"],
    duration: json["duration"],
    features: json["features"] == null
        ? []
        : List<String>.from(json["features"]!.map((x) => x)),
    status: json["status"],
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
    "name_en": nameEn,
    "description": description,
    "description_en": descriptionEn,
    "regular_price": regularPrice,
    "price": price,
    "duration": duration,
    "features":
    features == null ? [] : List<dynamic>.from(features!.map((x) => x)),
    "status": status,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
  };
}

class User {
  final int? id;
  final String? name;
  final String? email;
  final String? phone;
  final dynamic emailVerifiedAt;
  final String? address;
  final String? image;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final dynamic deletedAt;
  final String? gender;
  final dynamic countryCode;
  final String? username;
  final dynamic dob;
  final dynamic phoneOffice;
  final dynamic nid;
  final dynamic utin;
  final dynamic addressPresent;
  final dynamic addressPermanent;
  final dynamic fatherName;
  final dynamic motherName;
  final dynamic spouseName;
  final dynamic spouseTin;

  User({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.emailVerifiedAt,
    this.address,
    this.image,
    this.createdAt,
    this.updatedAt,
    this.deletedAt,
    this.gender,
    this.countryCode,
    this.username,
    this.dob,
    this.phoneOffice,
    this.nid,
    this.utin,
    this.addressPresent,
    this.addressPermanent,
    this.fatherName,
    this.motherName,
    this.spouseName,
    this.spouseTin,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    name: json["name"],
    email: json["email"],
    phone: json["phone"],
    emailVerifiedAt: json["email_verified_at"],
    address: json["address"],
    image: json["image"],
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    deletedAt: json["deleted_at"],
    gender: json["gender"],
    countryCode: json["country_code"],
    username: json["username"],
    dob: json["dob"],
    phoneOffice: json["phone_office"],
    nid: json["nid"],
    utin: json["utin"],
    addressPresent: json["address_present"],
    addressPermanent: json["address_permanent"],
    fatherName: json["father_name"],
    motherName: json["mother_name"],
    spouseName: json["spouse_name"],
    spouseTin: json["spouse_tin"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "email": email,
    "phone": phone,
    "email_verified_at": emailVerifiedAt,
    "address": address,
    "image": image,
    "created_at": createdAt?.toIso8601String(),
    "updated_at": updatedAt?.toIso8601String(),
    "deleted_at": deletedAt,
    "gender": gender,
    "country_code": countryCode,
    "username": username,
    "dob": dob,
    "phone_office": phoneOffice,
    "nid": nid,
    "utin": utin,
    "address_present": addressPresent,
    "address_permanent": addressPermanent,
    "father_name": fatherName,
    "mother_name": motherName,
    "spouse_name": spouseName,
    "spouse_tin": spouseTin,
  };
}

class Payment {
  final int? orderId;
  final String? amount;
  final String? paymentMethod;
  final String? transactionId;
  final String? status;
  final DateTime? updatedAt;
  final DateTime? createdAt;
  final int? id;

  Payment({
    this.orderId,
    this.amount,
    this.paymentMethod,
    this.transactionId,
    this.status,
    this.updatedAt,
    this.createdAt,
    this.id,
  });

  factory Payment.fromJson(Map<String, dynamic> json) => Payment(
    orderId: json["order_id"],
    amount: json["amount"],
    paymentMethod: json["payment_method"],
    transactionId: json["transaction_id"],
    status: json["status"],
    updatedAt: json["updated_at"] == null
        ? null
        : DateTime.parse(json["updated_at"]),
    createdAt: json["created_at"] == null
        ? null
        : DateTime.parse(json["created_at"]),
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "order_id": orderId,
    "amount": amount,
    "payment_method": paymentMethod,
    "transaction_id": transactionId,
    "status": status,
    "updated_at": updatedAt?.toIso8601String(),
    "created_at": createdAt?.toIso8601String(),
    "id": id,
  };
}
