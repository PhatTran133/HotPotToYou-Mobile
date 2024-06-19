import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/authorized_api_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<HotpotModel> _cartItems = [];
  List<HotpotModel> get cartItems => _cartItems;


  void fetchCart() async{
    // List<HotpotModel>? listProduct = await AuthorizedApiService.getCartByUserID(AuthProvider.userModel!.userID);
    // if (listProduct != null) {
    //   _cartItems = listProduct;
    // }
    // notifyListeners();
  }

  void removeProductFromCart(HotpotModel product) {
    // Thêm dữ liệu xuông BE
    AuthorizedApiService.deleteProductFromCart(AuthProvider.userModel!.ID, product.ID);
    //------------------------
    _cartItems.remove(product);
    notifyListeners();
  }

  void addToCart(HotpotModel product, int quantityUserWantBy) {
    if(AuthProvider.userModel != null){
    // Thêm dữ liệu xuông BE
    AuthorizedApiService.addProductToCart(AuthProvider.userModel!.ID, product.ID, quantityUserWantBy);
    //------------------------
    product.quantityUserWantBuy = quantityUserWantBy;
    _cartItems.add(product);
    notifyListeners();
    }
  }

  void addQuantityProductInCart(HotpotModel product, int quantityUserWantBy) {
    if(AuthProvider.userModel != null){
    // Thêm dữ liệu xuông BE
    AuthorizedApiService.addProductToCart(AuthProvider.userModel!.ID, product.ID, quantityUserWantBy);
    //------------------------
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].ID == product.ID) {
        _cartItems[i].quantityUserWantBuy = cartItems[i].quantityUserWantBuy! + quantityUserWantBy;
        break;
      }
    }
    notifyListeners();
    }
  }
  void updateQuantityProductInCart(HotpotModel product, int quantityUserWantBy) {
    if(AuthProvider.userModel != null){
    // Thêm dữ liệu xuông BE
    AuthorizedApiService.updateQuantityProductInCart(AuthProvider.userModel!.ID, product.ID, quantityUserWantBy);
    //------------------------
    for (int i = 0; i < _cartItems.length; i++) {
      if (_cartItems[i].ID == product.ID) {
        _cartItems[i].quantityUserWantBuy = quantityUserWantBy;
        break;
      }
    }
    notifyListeners();
    }
  }


  bool isProductInCart(int productId) {
    return _cartItems.any((item) => item.ID == productId);
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }
}
