import 'dart:convert';
import 'package:electronic_equipment_store/core/constants/config_constans.dart';

import 'package:http/http.dart' as http;


class UserApiService{
  static Future<Map<String, dynamic>?> logIn(
      String email, String password) async {
    final url = Uri.parse('$apiLink/api/v1/user/login');
    final response = await http.post(
      url,
      headers: {
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'email': email, 'password': password}),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }

  static Future<Map<String, dynamic>?> getUser(String email) async {
    final url = Uri.parse('$apiLink/api/v1/customer/get-customer-by-email?email=$email');
    final response = await http.get(url, headers: {
      'accept': '*/*',
      'Content-Type': 'application/json',
    });

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      return null;
    }
  }
}