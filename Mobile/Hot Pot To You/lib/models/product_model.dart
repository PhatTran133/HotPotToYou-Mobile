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

  
}
