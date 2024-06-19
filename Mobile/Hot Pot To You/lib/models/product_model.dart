import 'package:electronic_equipment_store/core/extensions/date_ext.dart';

class ProductModel {
  int productID;
  String productName;
  String? productDecription;
  String? productImage;
  int quantity;
  double price;
  int? warrantyPeriod;
  int? categoryID;

  int? quantityUserWantBuy;
  DateTime? expiredWarranty;

  ProductModel(
      {required this.productID,
      required this.productName,
      this.productDecription,
      this.productImage,
      required this.quantity,
      required this.price,
      this.warrantyPeriod,
      this.categoryID,
      this.quantityUserWantBuy,
      this.expiredWarranty});

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['id'],
      productName: json['name'],
      productDecription: json['description'],
      productImage: json['imageUrl'],
      quantity: json['quantity'],
      price: json['price'],
    );
  }
  factory ProductModel.fromJsonGetByID(Map<String, dynamic> json) {
    return ProductModel(
        productID: json['id'],
        productName: json['name'],
        productDecription: json['description'],
        quantity: json['quantity'],
        productImage: json['imageUrl'],
        price: json['price'],
        warrantyPeriod: json['warrantyPeriod'],
        categoryID: json['categoryID']);
  }

  factory ProductModel.fromJsonGetCartByUserID(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['productId'],
      productName: json['productName'],
      productImage: json['imageUrl'],
      quantityUserWantBuy: json['quantity'],
      price: json['price'],
      quantity: 10000,
    );
  }

  factory ProductModel.fromJsonGetOrderID(Map<String, dynamic> json) {
    return ProductModel(
      productID: json['product']['id'],
      productName: json['product']['name'],
      productImage: json['product']['imageUrl'],
      quantityUserWantBuy: json['quantity'],
      price: json['price'],
      expiredWarranty: DateTime.parse(json['expiredWarranty']),
      quantity: 10000,
    );
  }

  Map<String, dynamic> toJsonCreateOrder() {
    DateTime expiredWarranty = DateTime.now();
    if(warrantyPeriod != null) expiredWarranty = DateExtension.addMonths(expiredWarranty, warrantyPeriod!);
    return {
      'productId': productID,
      'quantity': quantityUserWantBuy,
      'expiredWarranty': expiredWarranty.toIso8601String(),
    };
  }
}
