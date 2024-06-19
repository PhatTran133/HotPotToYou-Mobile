class ProductImageModel {
  int productId;
  String imageUrl;

  ProductImageModel({
    required this.productId,
    required this.imageUrl,
  });
  factory ProductImageModel.fromJson(Map<String, dynamic> json) {
    return ProductImageModel(
      productId: json['id'],
      imageUrl: json['url'],
    );
  }
}
