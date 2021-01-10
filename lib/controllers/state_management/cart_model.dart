import 'package:flutter/material.dart';
import 'package:qarinli/controllers/cart_conttroler.dart';
import 'package:qarinli/models/product_cart.dart';

mixin CartModel on ChangeNotifier {
  CartController cartController = CartController();
  List<ProductCart> currentCart = [];
  bool currentCartIsLoading = false;
  Future<void> getCurrentCart({@required userToken}) async {
    currentCartIsLoading = true;
    notifyListeners();
    currentCart.clear();
    currentCart = await cartController.getCurrentCart(userToken: userToken);
    currentCartIsLoading = false;
    notifyListeners();
  }
}
