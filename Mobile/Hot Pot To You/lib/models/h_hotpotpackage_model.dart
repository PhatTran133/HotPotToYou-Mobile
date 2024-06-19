class HotPotPackageModel{
  int ID;
  int OrderId;
  int HotPotId;
  int Quantity;
  double Total;
  HotPotPackageModel({
    required this.ID,
    required this.OrderId,
    required this.HotPotId,
    required this.Quantity,
    required this.Total,
  });
  factory HotPotPackageModel.fromJson(Map<String, dynamic> json) {
    return HotPotPackageModel(
      ID: json['id'],
      OrderId: json['orderId'],
      HotPotId: json['hotPotId'],
      Quantity: json['quantity'],
      Total: json['total'].toDouble(),
    );
}
}