class HotPotTypeModel {
  int ID;
  String Name;

  HotPotTypeModel({
    required this.ID,
    required this.Name,
  });
  factory HotPotTypeModel.fromJson(Map<String, dynamic> json) {
    return HotPotTypeModel(
      ID: json['id'],
      Name: json['name'],
    );
  }
}