import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/category_ids.dart';
import 'package:qarinli/controllers/products.dart';
import 'package:qarinli/models/product.dart';

mixin ProductModel on ChangeNotifier {
  // for landing screen
  bool choosenLanddingIsLoading = false;
  List<Product> choosenLanddingProducts = [];

  bool modaLanddingIsLoading = false;
  List<Product> modaLanddingProducts = [];

  bool laptopsLanddingIsLoading = false;
  List<Product> laptopsLanddingProducts = [];

  bool ainiaSha5siaLanddingIsLoading = false;
  List<Product> ainiaSha5siaLanddingProducts = [];

  bool atorLanddingIsLoading = false;
  List<Product> atorLanddingProducts = [];

  bool mobsLanddingIsLoading = false;
  List<Product> mobsLanddingProducts = [];

  Future<void> loadProductsLanding() async {
    loadChoosenLdnding();
    loadModaLdnding();
    loadLaptopsLdnding();
    loadAiniaSha5siaLdnding();
    loadAtorLdnding();
    loadMobsLdnding();
  }

  Future<void> loadChoosenLdnding() async {
    choosenLanddingIsLoading = true;
    notifyListeners();
    choosenLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: CHOOSEN_CAT_ID, withoutOffers: true);
    print('choossen');
    print(choosenLanddingProducts[0].imageUrl);
    choosenLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadModaLdnding() async {
    modaLanddingIsLoading = true;
    notifyListeners();
    modaLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: MODA_CAT_ID, withoutOffers: true);
    modaLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadLaptopsLdnding() async {
    laptopsLanddingIsLoading = true;
    notifyListeners();
    laptopsLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: LAPTOPS_CAT_ID);
    laptopsLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadAiniaSha5siaLdnding() async {
    ainiaSha5siaLanddingIsLoading = true;
    notifyListeners();
    ainiaSha5siaLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: AINIA_SHA5SIA_CAT_ID, withoutOffers: true);
    ainiaSha5siaLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadAtorLdnding() async {
    atorLanddingIsLoading = true;
    notifyListeners();
    atorLanddingProducts = await ProductsController.getProducts(
        page: 1, categoryId: ATOR_CAT_ID, withoutOffers: true);
    atorLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadMobsLdnding() async {
    mobsLanddingIsLoading = true;
    notifyListeners();
    mobsLanddingProducts =
        await ProductsController.getProducts(page: 1, categoryId: MOBS_CAT_ID);
    mobsLanddingIsLoading = false;
    notifyListeners();
  }

  // for products screen
  List<Product> currentProducts = [];
}
