import 'package:electronic_equipment_store/models/h_hotpot_model.dart';
import 'package:electronic_equipment_store/models/h_pot_model.dart';
import 'package:electronic_equipment_store/models/h_utensil_model.dart';
import 'package:electronic_equipment_store/models/product_model.dart';
import 'package:electronic_equipment_store/services/auth_provider.dart';
import 'package:electronic_equipment_store/services/authorized_api_service.dart';
import 'package:flutter/material.dart';

class CartProvider with ChangeNotifier {
  List<HotpotModel> _cartHotPotItems = [];
  List<HotpotModel> get cartHotPotItems => _cartHotPotItems;

  List<PotModel> _cartPotItems = [];
  List<PotModel> get cartPotItems => _cartPotItems;

  List<UtensilModel> _cartUtensilItems = [];
  List<UtensilModel> get cartUtensilItems => _cartUtensilItems;

  void fetchCart() async {
    // List<HotpotModel>? listProduct = await AuthorizedApiService.getCartByUserID(AuthProvider.userModel!.userID);
    // if (listProduct != null) {
    //   _cartItems = listProduct;
    // }
    // notifyListeners();
  }

  void removeProductFromCart(HotpotModel product) {
    _cartHotPotItems.remove(product);
    notifyListeners();
  }

  void removePotFromCart(PotModel pot) {
    _cartPotItems.remove(pot);
    notifyListeners();
  }

  void removeUtensilFromCart(UtensilModel utensil) {
    _cartUtensilItems.remove(utensil);
    notifyListeners();
  }

  void addToCart(HotpotModel product, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      product.quantityUserWantBuy = quantityUserWantBy;
      _cartHotPotItems.add(product);
      notifyListeners();
    }
  }

  void addPotToCart(PotModel pot, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      pot.quantityUserWantBuy = quantityUserWantBy;
      _cartPotItems.add(pot);
      notifyListeners();
    }
  }

  void addUtensilToCart(UtensilModel utensil, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      utensil.quantityUserWantBuy = quantityUserWantBy;
      _cartUtensilItems.add(utensil);
      notifyListeners();
    }
  }

  void addQuantityProductInCart(HotpotModel product, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartHotPotItems.length; i++) {
        if (_cartHotPotItems[i].ID == product.ID) {
          _cartHotPotItems[i].quantityUserWantBuy =
              _cartHotPotItems[i].quantityUserWantBuy! + quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  void addQuantityPotInCart(PotModel pot, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartPotItems.length; i++) {
        if (_cartPotItems[i].ID == pot.ID) {
          _cartPotItems[i].quantityUserWantBuy =
              _cartPotItems[i].quantityUserWantBuy! + quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  void addQuantityUtensilInCart(UtensilModel utensil, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartUtensilItems.length; i++) {
        if (_cartUtensilItems[i].ID == utensil.ID) {
          _cartUtensilItems[i].quantityUserWantBuy =
              _cartUtensilItems[i].quantityUserWantBuy! + quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  void updateQuantityProductInCart(
      HotpotModel product, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartHotPotItems.length; i++) {
        if (_cartHotPotItems[i].ID == product.ID) {
          _cartHotPotItems[i].quantityUserWantBuy = quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  void updateQuantityPotInCart(PotModel pot, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartPotItems.length; i++) {
        if (_cartPotItems[i].ID == pot.ID) {
          _cartPotItems[i].quantityUserWantBuy = quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  void updateQuantityUtensilInCart(
      UtensilModel utensil, int quantityUserWantBy) {
    if (AuthProvider.userModel != null) {
      for (int i = 0; i < _cartUtensilItems.length; i++) {
        if (_cartUtensilItems[i].ID == utensil.ID) {
          _cartUtensilItems[i].quantityUserWantBuy = quantityUserWantBy;
          break;
        }
      }
      notifyListeners();
    }
  }

  bool isProductInCart(int productId) {
    return _cartHotPotItems.any((item) => item.ID == productId);
  }

  bool isPotInCart(int potID) {
    return _cartPotItems.any((item) => item.ID == potID);
  }

  bool isUtensilInCart(int utensilId) {
    return _cartUtensilItems.any((item) => item.ID == utensilId);
  }

  void clearCart() {
    _cartHotPotItems.clear();
    _cartPotItems.clear();
    _cartUtensilItems.clear();
    notifyListeners();
  }
}
