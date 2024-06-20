import 'dart:convert';
import 'package:electronic_equipment_store/core/constants/config_constans.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/category_model.dart';
import 'package:http/http.dart' as http;

class HotpotApiSevice{

  static Future<List<HotpotModel>?> getAllHotPot() async {
    final url = Uri.parse('$apiLink/api/v1/hotpot?pageIndex=1&pageSize=10');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('value')) {
          List<dynamic> productList = jsonResponse['value'];
          List<HotpotModel> products =
          productList.map((json) => HotpotModel.fromJson(json)).toList();
          return products;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all Product');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<HotpotModel> getHotPotDetail (int ID) async{
    final url = Uri.parse('$apiLink/api/v1/hotpot/get-hotpot-by-id?id=$ID');
    final reponse = await http.get(url);
    if (reponse.statusCode == 200){
      Map<String, dynamic> data = json.decode(reponse.body);
      Map<String , dynamic> hotpotData = data['value'];
      HotpotModel hotpotModel = HotpotModel.fromJson(hotpotData);
      return hotpotModel;
    } else{
      throw Exception('lấy thông tin lẩu không thành công');
    }
  }


  static Future<List<CategoryModel>?> getAllCategory() async {
    final url = Uri.parse('$apiLink/api/Category/getall');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> categoryList = jsonResponse['data'];
          List<CategoryModel> categories =
          categoryList.map((json) => CategoryModel.fromJson(json)).toList();
          return categories;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all Category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}
