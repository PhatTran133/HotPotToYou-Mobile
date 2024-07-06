import 'dart:convert';
import 'package:electronic_equipment_store/core/constants/config_constans.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/h_pot_model.dart';
import 'package:electronic_equipment_store/models/h_utensil_model.dart';

import 'package:http/http.dart' as http;


class HotpotApiService{

  static Future<List<HotpotModel>?> getAllHotPots({
    String? search,
    String? sortBy,
    double? fromPrice,
    double? toPrice,
    int? flavorID,
    String? size,
    int? typeID,
    int? pageIndex,
    int? pageSize,
  }) async {
    final baseUrl = '$apiLink/api/v1/hotpot';

    // Construct query parameters based on provided inputs
    final Map<String, String> queryParams = {};
    if (search != null) queryParams['search'] = search;
    if (sortBy != null) queryParams['sortBy'] = sortBy;
    if (fromPrice != null) queryParams['fromPrice'] = fromPrice.toString();
    if (toPrice != null) queryParams['toPrice'] = toPrice.toString();
    if (flavorID != null) queryParams['flavorID'] = flavorID.toString();
    if (size != null) queryParams['size'] = size;
    if (typeID != null) queryParams['typeID'] = typeID.toString();
    if (pageIndex != null) queryParams['pageIndex'] = pageIndex.toString();
    if (pageSize != null) queryParams['pageSize'] = pageSize.toString();

    // Construct the full URL with query parameters
    final url = Uri.parse(baseUrl).replace(queryParameters: queryParams);
  print(url);
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
          throw Exception('Invalid JSON format: "value" field not found');
        }
      } else {
        throw Exception('Failed to load all HotPot: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

static Future<List<PotModel>?> getAllPots({
    String? search,
  }) async {
    final baseUrl = '$apiLink/api/v1/pot';

    // Construct query parameters based on provided inputs
    final Map<String, String> queryParams = {};
    if (search != null) queryParams['search'] = search;

    // Construct the full URL with query parameters
    final url = Uri.parse(baseUrl).replace(queryParameters: queryParams);
  print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('value')) {
          List<dynamic> productList = jsonResponse['value'];
          List<PotModel> products =
          productList.map((json) => PotModel.fromJson(json)).toList();
          return products;
        } else {
          throw Exception('Invalid JSON format: "value" field not found');
        }
      } else {
        throw Exception('Failed to load all HotPot: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
  static Future<List<UtensilModel>?> getAllUtensil({
    String? search,
  }) async {
    final baseUrl = '$apiLink/api/v1/utensil';

    // Construct query parameters based on provided inputs
    final Map<String, String> queryParams = {};
    if (search != null) queryParams['name'] = search;

    // Construct the full URL with query parameters
    final url = Uri.parse(baseUrl).replace(queryParameters: queryParams);
  print(url);
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('value')) {
          List<dynamic> productList = jsonResponse['value'];
          List<UtensilModel> products =
          productList.map((json) => UtensilModel.fromJson(json)).toList();
          return products;
        } else {
          throw Exception('Invalid JSON format: "value" field not found');
        }
      } else {
        throw Exception('Failed to load all HotPot: ${response.statusCode}');
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
}
