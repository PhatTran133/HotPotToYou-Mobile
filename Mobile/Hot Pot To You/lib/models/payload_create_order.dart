// To parse this JSON data, do
//
//     final payloadCreateOrder = payloadCreateOrderFromJson(jsonString);

import 'dart:convert';

PayloadCreateOrder payloadCreateOrderFromJson(String str) =>
    PayloadCreateOrder.fromJson(json.decode(str));

String payloadCreateOrderToJson(PayloadCreateOrder data) =>
    json.encode(data.toJson());

class PayloadCreateOrder {
  DateTime? purchaseDate;
  int? customerId;
  String? adress;
  double? totalPrice;
  int? paymentId;
  List<Item>? items;

  PayloadCreateOrder({
    this.purchaseDate,
    this.customerId,
    this.adress,
    this.totalPrice,
    this.paymentId,
    this.items,
  });

  PayloadCreateOrder copyWith({
    DateTime? purchaseDate,
    int? customerId,
    String? adress,
    double? totalPrice,
    int? paymentId,
    List<Item>? items,
  }) =>
      PayloadCreateOrder(
        purchaseDate: purchaseDate ?? this.purchaseDate,
        customerId: customerId ?? this.customerId,
        adress: adress ?? this.adress,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentId: paymentId ?? this.paymentId,
        items: items ?? this.items,
      );

  factory PayloadCreateOrder.fromJson(Map<String, dynamic> json) =>
      PayloadCreateOrder(
        purchaseDate: json["purchaseDate"] == null
            ? null
            : DateTime.parse(json["purchaseDate"]),
        customerId: json["customerID"],
        adress: json["adress"],
        totalPrice: json["totalPrice"],
        paymentId: json["paymentID"],
        items: json["items"] == null
            ? []
            : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "purchaseDate": purchaseDate?.toIso8601String(),
        "customerID": customerId,
        "adress": adress,
        "totalPrice": totalPrice,
        "paymentID": paymentId,
        "items": items == null ? [] : (items!.map((x) => x.toJson())).toList(),
      };
}

class Item {
  String? type;
  int? id;
  int? quantity;
  double? total;
  bool? isPackage;

  Item({
    this.type,
    this.id,
    this.quantity,
    this.total,
    this.isPackage,
  });

  Item copyWith({
    String? type,
    int? id,
    int? quantity,
    double? total,
    bool? isPackage,
  }) =>
      Item(
        type: type ?? this.type,
        id: id ?? this.id,
        quantity: quantity ?? this.quantity,
        total: total ?? this.total,
        isPackage: isPackage ?? this.isPackage,
      );

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        type: json["type"],
        id: json["id"],
        quantity: json["quantity"],
        total: json["total"],
        isPackage: json["isPackage"],
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "id": id,
        "quantity": quantity,
        "total": total,
        "isPackage": isPackage,
      };
}
