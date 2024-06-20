import 'dart:convert';
import 'package:electronic_equipment_store/core/constants/config_constans.dart';
import 'package:electronic_equipment_store/models/hotpottype_model.dart';

import 'package:http/http.dart' as http;
class HotPotTypeApiService{

  static Future<List<HotPotTypeModel>?> getAllHotPotTypes() async {
    final url = Uri.parse('$apiLink/api/v1/hotpot-type');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> hotPotTypeList = jsonResponse['data'];
          List<HotPotTypeModel> categories =
          hotPotTypeList.map((json) => HotPotTypeModel.fromJson(json)).toList();
          return categories;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all HotPot Type');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }
}