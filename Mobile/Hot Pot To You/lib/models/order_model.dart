
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

  factory OrderBuyModel.fromJson(Map<String, dynamic> json) {
    return OrderBuyModel(
      orderBuyID: json['orderId'],
      total: json['totalPrice'].toDouble(),
      status: json['status'],
      paymentName: json['paymentName'],
      customerName: json['nameCustomer'],
      customerAddress: json['addressCustomer'],
      customerPhone: json['phoneCustomer'],      
      dateOrder: DateTime.parse(json['orderDate']),
      
    );
  }
}
