import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/cat_ids.dart';
import 'package:qarinli/controllers/products.dart';
import 'package:qarinli/models/product.dart';

mixin ProductModel on ChangeNotifier {
  // for landing screen
  bool laptopsLanddingIsLoading = false;
  List<Product> laptopsLanddingProducts = [];

  Future<void> loadProductsLanding() async {
    loadLaptopsLdnding();
  }

  Future<void> loadLaptopsLdnding() async {
    laptopsLanddingIsLoading = true;
    notifyListeners();
    laptopsLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: LAPTOPS_CAT_ID);
    laptopsLanddingIsLoading = false;
    notifyListeners();
  }

  // for products screen
  List<Product> currentProducts = [];
}
