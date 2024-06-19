

import 'package:flutter/material.dart';

class HotpotModel{
   int ID ;
 String Name ;
 String Size ;
 String ImageUrl ;
 String Description ;
 double Price ;
 int? TypeID ;
 
 String? TypeName;
 int? quantityUserWantBuy;

 HotpotModel({
    required this.ID,
    required this.Name,
    required this.Size,
    required this.ImageUrl,
    required this.Description,
    required this.Price,
    this.TypeID,

    this.TypeName,
    this.quantityUserWantBuy,
 });
factory HotpotModel.fromJson(Map<String, dynamic> json) {
    return HotpotModel(
      ID: json['id'],
      Name: json['name'],
      Size: json['size'],
      Description: json['description'],
      ImageUrl: json['imageUrl'],
      Price: json['price'],
      TypeName: json['type'],
    );
  }


  factory HotpotModel.fromJsonGetCartByUserID(Map<String, dynamic> json) {
    return HotpotModel(
      ID: json['productId'],
      Name: json['productName'],
      Size: json['size'],
      Description: json['description'],
      ImageUrl: json['imageUrl'],
      quantityUserWantBuy: json['quantity'],
      Price: json['price'],
    );
  }


  Map<String, dynamic> toJsonCreateOrder() {
    DateTime expiredWarranty = DateTime.now();
    return {
      'productId': ID,
      'quantity': quantityUserWantBuy,
      'expiredWarranty': expiredWarranty.toIso8601String(),
    };
  }
}

