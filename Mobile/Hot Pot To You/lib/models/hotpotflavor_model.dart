class HotPotFlavorModel {
  int ID;
  String Name;

  HotPotFlavorModel({
    required this.ID,
    required this.Name,
  });
  factory HotPotFlavorModel.fromJson(Map<String, dynamic> json) {
    return HotPotFlavorModel(
      ID: json['id'],
      Name: json['name'],
    );
  }
}