
class OrderBuyModel {
  int orderBuyID;
  double total;
  String customerAddress;
  int status;
  DateTime dateOrder;
  String customerName;
  String? paymentName;
  String? customerPhone;

  OrderBuyModel({
    required this.orderBuyID,
    required this.total,
    required this.customerAddress,
    required this.status,
    required this.dateOrder,
    required this.customerName,
    this.customerPhone,
    this.paymentName,
  });

  
}
