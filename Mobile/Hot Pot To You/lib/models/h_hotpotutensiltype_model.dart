class HotPotUtensilTypeModel {
  int ID;
  int HotPotTypeId;
  int UtensilId;

  HotPotUtensilTypeModel({
    required this.ID,
    required this.HotPotTypeId,
    required this.UtensilId,
  });

  // Phương thức để chuyển đổi từ JSON sang đối tượng Dart
  factory HotPotUtensilTypeModel.fromJson(Map<String, dynamic> json) {
    return HotPotUtensilTypeModel(
      ID: json['id'],
      HotPotTypeId: json['hotPotTypeId'],
      UtensilId: json['utensilId'],
    );
  }
}