// To parse this JSON data, do
//
//     final payloadCreateOrder = payloadCreateOrderFromJson(jsonString);

import 'dart:convert';


class PayloadCreateOrder {
  DateTime? purchaseDate;
  int? customerId;
  String? adress;
  double? totalPrice;
  int? paymentId;
  

  PayloadCreateOrder({
    this.purchaseDate,
    this.customerId,
    this.adress,
    this.totalPrice,
    this.paymentId,
    
  });

  PayloadCreateOrder copyWith({
    DateTime? purchaseDate,
    int? customerId,
    String? adress,
    double? totalPrice,
    int? paymentId,
    
  }) =>
      PayloadCreateOrder(
        purchaseDate: purchaseDate ?? this.purchaseDate,
        customerId: customerId ?? this.customerId,
        adress: adress ?? this.adress,
        totalPrice: totalPrice ?? this.totalPrice,
        paymentId: paymentId ?? this.paymentId,

      );

  
}
