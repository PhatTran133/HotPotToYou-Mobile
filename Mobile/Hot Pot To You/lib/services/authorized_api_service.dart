import 'dart:convert';

import 'package:electronic_equipment_store/core/constants/config_constans.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/models/order_model.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class AuthorizedApiService {
  static String getToken() {
    var tokenBox = Hive.box('tokenBox');
    String? token = tokenBox.get('token');
    if (token != null) {
      return token;
    } else {
      // ignore: avoid_print
      print('Không tìm thấy token trong box.');
      return "";
    }
  }  


  static Future updateQuantityProductInCart(int userID, int productID, int quantityUserWantBuy)async{
    final url = Uri.parse('$apiLink/api/Cart/update-quantity-by-productid-and-userid/$userID/$productID/$quantityUserWantBuy');
    final response = await http.put(
      url,
      headers: {
        'accept': '*/*',
        "Authorization": "Bearer ${getToken()}",
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future addProductToCart(
      int userID, int productID, int quantityUserWantBuy) async {
    final url = Uri.parse('$apiLink/api/Cart/add-product-into-cart');
    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${getToken()}",
      },
      body: jsonEncode({
        'productId': productID,
        'quantity': quantityUserWantBuy,
        'userId': userID
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future deleteProductFromCart(int userId, int productId) async {
  final url = Uri.parse('$apiLink/api/Cart/delete-product-id-by-user-id/$productId/$userId');
  final response = await http.delete(
      url,
      headers: <String, String>{
        'Authorization': 'Bearer ${getToken()}',
        'accept': '*/*',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<List<HotpotModel>?> getCartByUserID(int userID) async {
  final url = Uri.parse('$apiLink/api/Cart/get-by-user-id/$userID');
  try {
    final response = await http.get(url,
        headers: <String, String>{
        'Authorization': 'Bearer ${getToken()}',
        'accept': '*/*', 
      },);
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data')) {
        List<dynamic> productList = jsonResponse['data'];
        List<HotpotModel> products = productList.map((json) => HotpotModel.fromJsonGetCartByUserID(json)).toList();        
        return products;
      } else {
        throw Exception('Invalid JSON format: "data" field not found');
      }
    } else {
      throw Exception('Failed to load getCartByUserID');
    }
  } catch (e) {
    throw Exception('Error: $e');
  }
}
  static Future<void> deleteCart() async {
  final String apiUrl = '$apiLink/api/Cart/delete-all-carts-by-user-id/${AuthProvider.userModel!.ID}';
    final http.Response response = await http.delete(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
}

  static Future<int> createOrder(String name, String phone, String address, String paymentMethod, List<HotpotModel> listProduct) async {
    final url = Uri.parse('$apiLink/api/Order/create');
     final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      },
      body: jsonEncode({
        'orderDetails' : listProduct.map((product) => product.toJsonCreateOrder()).toList(),
        'orderDate' : DateTime.now().toIso8601String(),
        'status' : 2,
        'statusMessage': 'Waiting',
        'paymentName' : paymentMethod,
        'nameCustomer' : name,
        'addressCustomer': address,
        'phoneCustomer': phone,
        'userId': AuthProvider.userModel!.ID
      }),
    );
    if (response.statusCode == 200) {
      return json.decode(response.body)['data']['orderId'];
    } else {
      return 0;
    }
  }

  static Future checkOutByVnPay(int orderID) async {
  final String apiUrl = '$apiLink/api/Payment/vn-pay/${AuthProvider.userModel!.ID}/$orderID/2';
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      },
    );
    if (response.statusCode == 200) {
      return response.body;
    }
}
static Future<List<OrderBuyModel>?> getAllOrderBuyByCustomerIDAndStaus(
      int customerID, int status) async {
        final url = Uri.parse('$apiLink/api/Order/GetByUserId/${AuthProvider.userModel!.ID}?status=$status');

    try {
      final response = await http.get(url,headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${getToken()}",
      },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList.map((json) => OrderBuyModel.fromJson(json)).toList();
        }
      } else {
        throw Exception('Lấy danh sách order thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  static Future<List<ProductModel>?> getAllOrderBuyDetailByOrderBuyID(
      int orderID) async {
    final url = Uri.parse('$apiLink/api/Order/getorderdetailsbyorderid/$orderID');

    try {
      final response = await http.get(url
      ,headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
        "Authorization": "Bearer ${getToken()}",
      },);

      if (response.statusCode == 200) {
        final List<dynamic> jsonList = json.decode(response.body)['data'];
        if (jsonList.isEmpty) {
          return null;
        } else {
          return jsonList
              .map((json) => ProductModel.fromJsonGetOrderID(json))
              .toList();
        }
      } else {
        throw Exception('Lấy chi tiết đơn hàng thất bại.');
      }
    } catch (e) {
      throw Exception('Lỗi: $e');
    }
  }

  
  static Future<void> updateStatusOrder(int orderID, int status) async {
  final String apiUrl = '$apiLink/api/Order/updateStatus/$orderID/$status';
    final http.Response response = await http.put(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
        'Authorization': 'Bearer ${getToken()}',
      },
    );
    if (response.statusCode == 200) {
      return json.decode(response.body);
    }
}
}
