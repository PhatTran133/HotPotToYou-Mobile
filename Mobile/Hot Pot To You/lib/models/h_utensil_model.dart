class UtensilModel {
  int ID;
  String Name;
  String material;
  String Size;
  int quantity;
  double Price;
  String Type;
  int? quantityUserWantBuy;
  String ImageUrl;

  UtensilModel({
    required this.ID,
    required this.Name,
    required this.material,
    required this.Size,
    required this.quantity,
    required this.Price,
    required this.Type,
    required this.ImageUrl,
    this.quantityUserWantBuy,
  });
  factory UtensilModel.fromJson(Map<String, dynamic> json) {
    return UtensilModel(
      ID: json['id'],
      Name: json['name'],
      material: json['material'],
      Size: json['size'],
      quantity: json['quantity'],
      Price: json['price'],
      Type: json['type'],
      ImageUrl: json['imageUrl']
    );
  }
}
