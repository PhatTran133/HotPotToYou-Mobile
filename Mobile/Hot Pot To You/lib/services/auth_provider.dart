import 'package:electronic_equipment_store/models/h_customer_model.dart';
import 'package:flutter/cupertino.dart';
import '../models/user_model.dart';

class AuthProvider with ChangeNotifier {
  bool isLoggedIn = false;
  static CustomerModel? userModel;

  void setUser(CustomerModel user) {
    userModel = user;
    isLoggedIn = true;
    notifyListeners();
  }

  void clearUser() {
    userModel = null;
    isLoggedIn = false;
    notifyListeners();
  }

}
