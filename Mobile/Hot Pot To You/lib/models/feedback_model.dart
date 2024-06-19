
class FeedbackModel {
  String? imgUrl;
  int productId;
  int? userID;
  int ratingPoint;
  String description;
  String? nameUser;

  FeedbackModel({
    required this.productId,
    this.userID,
    required this.ratingPoint,
    required this.description,
    this.nameUser,
    this.imgUrl
  });

  factory FeedbackModel.fromJson(Map<String, dynamic> json) {
    return FeedbackModel(
      nameUser: json['nameUser'],
      imgUrl: json['imageUrl'],
      productId: json['productId'],
      description: json['comment'],
      ratingPoint: json['rating'],
    );
  }
}
