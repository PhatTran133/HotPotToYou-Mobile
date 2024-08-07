import 'dart:convert';
import 'package:electronic_equipment_store/core/constants/config_constans.dart';
import 'package:electronic_equipment_store/models/category_model.dart';
import 'package:electronic_equipment_store/models/feedback_model.dart';
import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_detail_model.dart';
import 'package:electronic_equipment_store/models/product_image_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/utils/asset_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ApiService {
//Not Authorize

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
  static Future<ProductModel> getProductByID(int productID) async {
    final url = Uri.parse('$apiLink/api/Product/getDetailsById/$productID');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> data = json.decode(response.body);
        Map<String, dynamic> productData = data['data']['products'];
        ProductModel productModel = ProductModel.fromJsonGetByID(productData);
        return productModel;
      } else {
        throw Exception('Failed to load product detail');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<ProductModel>?> getAllProductByCategoryID(
      int categoryId) async {
    final url =
        Uri.parse('$apiLink/api/Category/get-product-by-category/$categoryId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> productList = jsonResponse['data']['products'];
          List<ProductModel> products =
              productList.map((json) => ProductModel.fromJson(json)).toList();
          return products;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load Product by Category');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<ProductModel>?> getAllProductByProductName(
      String productName) async {
    final url = Uri.parse('$apiLink/api/Product/search?name=$productName');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> productList = jsonResponse['data']['products'];
          List<ProductModel> products =
              productList.map((json) => ProductModel.fromJson(json)).toList();
          return products;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all Product by product name');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<ProductImageModel>> getAllProductImgByProductID(
      int productID) async {
    final url = Uri.parse('$apiLink/api/Product/getDetailsById/$productID');  
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> imageList = jsonResponse['data']['images'];
          List<ProductImageModel> images = imageList
              .map((json) => ProductImageModel.fromJson(json))
              .toList();
          return images;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all getAllProductImgByProductID');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<List<ProductDetailModel>> getListProductDetailByProductByID(
      int productId) async {
    final url = Uri.parse('$apiLink/api/Product/getDetailsById/$productId');
    try {
      final response = await http.get(url);
      if (response.statusCode == 200) {
        Map<String, dynamic> jsonResponse = json.decode(response.body);
        if (jsonResponse.containsKey('data')) {
          List<dynamic> productDetailList = jsonResponse['data']['details'];
          List<ProductDetailModel> images = productDetailList
              .map((json) => ProductDetailModel.fromJson(json))
              .toList();
          return images;
        } else {
          throw Exception('Invalid JSON format: "data" field not found');
        }
      } else {
        throw Exception('Failed to load all getAllProductImgByProductID');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  static Future<CategoryModel> getCategoryNameByID(int categoryID) async {
    final String apiUrl = '$apiLink/api/Category/getNameById/$categoryID';
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      Map<String, dynamic> categoryData = data['data'];
      CategoryModel categoryModel = CategoryModel.fromJson(categoryData);
      return categoryModel;
    } else {
      throw Exception('Failed to load getCategoryNameByID');
    }
  }

  static Future saveFeedBack(FeedbackModel feedbackModel) async {
    const String apiUrl = '$apiLink/api/Review/create';
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'userId': feedbackModel.userID,
        'productId': feedbackModel.productId,
        'comment': feedbackModel.description,
        'rating': feedbackModel.ratingPoint
      }),
    );
    if (response.statusCode == 200) {
      return null;
    } else {
      throw Exception('Failed to saveFeedBack');
    }
  }

  static Future<List<FeedbackModel>> getFeedbackByProductID(
      int productID) async {
    final String apiUrl = '$apiLink/api/Review/getByProductId/$productID';
    final http.Response response = await http.get(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> jsonResponse = json.decode(response.body);
      if (jsonResponse.containsKey('data')) {
        List<dynamic> feedbackModelList = jsonResponse['data'];
        List<FeedbackModel> feedbacks = feedbackModelList
            .map((json) => FeedbackModel.fromJson(json))
            .toList();
        return feedbacks;
      } else {
        throw Exception('Invalid JSON format: "data" field not found');
      }
    } else {
      throw Exception('Failed to load all getFeedbackByProductID');
    }
  }

  static Future<int> createAccount(
      String name, String phone, String email, String password, String yearOfBirth, String gender, String address, ) async {
    const String apiUrl = '$apiLink/api/v1/customer/register';
    final http.Response response = await http.post(
      Uri.parse(apiUrl),
      headers: <String, String>{
        'accept': '*/*',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'email': email,
        'password': password,
        'name': name,
        'gender' : gender,
        'address' : address,
        'phone': phone,
        'yearOfBirth': yearOfBirth,
        'avatarUrl': AssetHelper.imageAvatarDefault,
      }),
    );    
    if (response.statusCode == 200) {
      return 1;
    } else if (response.statusCode == 400) {
      return 2;
    } else {
      return 0;
    }
  }
}
