import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/category_ids.dart';
import 'package:qarinli/controllers/products_controller.dart';
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

  ProductsController productsController = ProductsController();

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
    choosenLanddingProducts.clear();
    choosenLanddingProducts = await productsController.getProducts(
        page: 1, withoutOffers: true, choosen: true);
    choosenLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadModaLdnding() async {
    modaLanddingIsLoading = true;
    notifyListeners();
    modaLanddingProducts.clear();
    modaLanddingProducts = await productsController.getProducts(
        page: 1, categoryId: MODA_CAT_ID, withoutOffers: true, moda: true);
    modaLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadLaptopsLdnding() async {
    laptopsLanddingIsLoading = true;
    notifyListeners();
    laptopsLanddingProducts.clear();
    laptopsLanddingProducts = await productsController.getProducts(
        page: 1, categoryId: LAPTOPS_CAT_ID);
    laptopsLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadAiniaSha5siaLdnding() async {
    ainiaSha5siaLanddingIsLoading = true;
    notifyListeners();
    ainiaSha5siaLanddingProducts.clear();
    ainiaSha5siaLanddingProducts = await productsController.getProducts(
        page: 1, categoryId: AINIA_SHA5SIA_CAT_ID, withoutOffers: true);
    ainiaSha5siaLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadAtorLdnding() async {
    atorLanddingIsLoading = true;
    notifyListeners();
    atorLanddingProducts.clear();
    atorLanddingProducts = await productsController.getProducts(
        page: 1, categoryId: 794, withoutOffers: true);
    atorLanddingIsLoading = false;
    notifyListeners();
  }

  Future<void> loadMobsLdnding() async {
    mobsLanddingIsLoading = true;
    notifyListeners();
    mobsLanddingProducts.clear();
    mobsLanddingProducts =
        await productsController.getProducts(page: 1, categoryId: MOBS_CAT_ID);
    mobsLanddingIsLoading = false;
    notifyListeners();
  }

  // for products screen
  List<Product> currentProducts = [];
  bool currentProductsIsLoadin = false;
  Future<void> getCurrentProducts({int pageNamber, int categoryId}) async {
    currentProductsIsLoadin = true;
    notifyListeners();
    currentProducts.clear();
    currentProducts = await productsController.getProducts(
        page: pageNamber, categoryId: categoryId);
    currentProductsIsLoadin = false;
    notifyListeners();
  }

  // for product screen
  List<Product> relatedProducts = [];
  bool relatedProductsIsLoading = false;
  void getRelatedProducts(relatedIds) async {
    // print('enter getrelateds');
    relatedProductsIsLoading = true;
    notifyListeners();
    relatedProducts.clear();
    try {
      for (var id in relatedIds) {
        var product =
            await productsController.getProduct(productId: id.toString());
        relatedProducts.add(product);
      }
    } catch (e) {
      // print('get product error');
      // print(e.toString());
    }
    relatedProductsIsLoading = false;
    notifyListeners();
    // print('exit get relateds');
    // print('related length: ' + relatedProducts.length.toString());
  }

  // for Favourites screen
  List<Product> favoritesProducts = [];
}
