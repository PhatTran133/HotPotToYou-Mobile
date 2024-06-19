class IngredientModel {
  int ID;
  String Name;
  int GroupId;


  IngredientModel({
    required this.ID,
    required this.Name,
    required this.GroupId,
  
  });

  // Phương thức để chuyển đổi từ JSON sang đối tượng Dart
  factory IngredientModel.fromJson(Map<String, dynamic> json) {
    return IngredientModel(
      ID: json['id'],
      Name: json['name'],
      GroupId: json['groupId'],
    );
  }
}