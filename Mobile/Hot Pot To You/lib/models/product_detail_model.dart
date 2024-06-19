class ProductDetailModel {
  int productID;
  String name;
  String value;
 

  ProductDetailModel({
    required this.productID,
    required this.name,
    required this.value
    
  });
  

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) {
    return ProductDetailModel(
      productID: json['id'],
      name: json['name'],
      value: json['value'],
    );
  }

}