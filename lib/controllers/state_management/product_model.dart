import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/category_ids.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/controllers/products_controller.dart';
import 'package:qarinli/models/fetchedProducts.dart';
import 'package:qarinli/models/product.dart';

mixin ProductModel on ChangeNotifier {
  // for landing screen
  bool comparisonProductsLanddingIsLoading = false;
  List<Product> comparisonLanddingProducts = [];

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
    loadComparisonProductsLdnding();
    loadChoosenLdnding();
    loadModaLdnding();
    loadLaptopsLdnding();
    loadAiniaSha5siaLdnding();
    loadAtorLdnding();
    loadMobsLdnding();
  }

  Future<void> loadComparisonProductsLdnding() async {
    comparisonProductsLanddingIsLoading = true;
    notifyListeners();
    comparisonLanddingProducts.clear();
    productsController
        .getProducts(page: 1, comparison: true)
        .then((FetchedProducts fetchedProducts) {
      comparisonLanddingProducts = fetchedProducts.products;
      comparisonProductsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadChoosenLdnding() async {
    choosenLanddingIsLoading = true;
    notifyListeners();
    choosenLanddingProducts.clear();
    productsController
        .getProducts(page: 1, withoutOffers: true, choosen: true)
        .then((FetchedProducts fetchedProducts) {
      choosenLanddingProducts = fetchedProducts.products;
      choosenLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadModaLdnding() async {
    modaLanddingIsLoading = true;
    notifyListeners();
    modaLanddingProducts.clear();
    productsController
        .getProducts(
            page: 1, categoryId: MODA_CAT_ID, withoutOffers: true, moda: true)
        .then((FetchedProducts fetchedProducts) {
      print(fetchedProducts.products.length);
      modaLanddingProducts = fetchedProducts.products;
      modaLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadLaptopsLdnding() async {
    laptopsLanddingIsLoading = true;
    notifyListeners();
    laptopsLanddingProducts.clear();
    productsController
        .getProducts(page: 1, categoryId: LAPTOPS_CAT_ID)
        .then((FetchedProducts fetchedProducts) {
      laptopsLanddingProducts = fetchedProducts.products;
      laptopsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadAiniaSha5siaLdnding() async {
    ainiaSha5siaLanddingIsLoading = true;
    notifyListeners();
    ainiaSha5siaLanddingProducts.clear();
    productsController
        .getProducts(
            page: 1, categoryId: AINIA_SHA5SIA_CAT_ID, withoutOffers: true)
        .then((FetchedProducts fetchedProducts) {
      ainiaSha5siaLanddingProducts = fetchedProducts.products;
      ainiaSha5siaLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadAtorLdnding() async {
    atorLanddingIsLoading = true;
    notifyListeners();
    atorLanddingProducts.clear();
    productsController
        .getProducts(page: 1, categoryId: 794, withoutOffers: true)
        .then((FetchedProducts fetchedProducts) {
      atorLanddingProducts = fetchedProducts.products;
      atorLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadMobsLdnding() async {
    mobsLanddingIsLoading = true;
    notifyListeners();
    mobsLanddingProducts.clear();
    productsController
        .getProducts(page: 1, categoryId: MOBS_CAT_ID)
        .then((FetchedProducts fetchedProducts) {
      mobsLanddingProducts = fetchedProducts.products;
      mobsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  // for products screen
  List<Product> currentProducts = [];
  bool currentProductsIsLoading = false;
  int currentTotalResults = 0;
  int currentTotalpages = 0;
  Future<void> getCurrentProducts(
      {int pageNumber,
      int categoryId,
      bool topSales = false,
      bool withoutOffers = false,
      choosen = false,
      moda = false,
      bool comparison = false,
      String search,
      String favorites}) async {
    currentProductsIsLoading = true;
    notifyListeners();
    currentProducts.clear();
    productsController
        .getProducts(
            page: pageNumber,
            categoryId: categoryId,
            topSales: topSales,
            withoutOffers: withoutOffers,
            comparison: comparison,
            choosen: choosen,
            moda: moda,
            search: search,
            favorites: favorites)
        .then((FetchedProducts fetchedProducts) {
      currentProducts = fetchedProducts.products;
      currentTotalpages = fetchedProducts.totalPages;
      currentTotalResults = fetchedProducts.totalResults;

      currentProductsIsLoading = false;
      notifyListeners();
    });
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

  // for top categories screen
  Future<void> getTopCategoryCurrentProducts(
      {@required int selectedIndex, int pageNamber, int categoryId}) async {
    topCategories[selectedIndex].productsIsLoading = true;
    notifyListeners();
    currentProducts.clear();
    productsController
        .getProducts(page: pageNamber, categoryId: categoryId)
        .then((FetchedProducts fetchedProducts) {
      topCategories[selectedIndex].fetchedProducts.products =
          fetchedProducts.products;
      topCategories[selectedIndex].fetchedProducts.totalPages =
          fetchedProducts.totalPages;
      topCategories[selectedIndex].fetchedProducts.totalResults =
          fetchedProducts.totalResults;
      topCategories[selectedIndex].productsIsLoading = false;
      notifyListeners();
    });
  }

  // for search
  Future<void> search({searchQuery}) async {
    currentProductsIsLoading = true;
    notifyListeners();
    currentProducts.clear();
    productsController
        .getProducts(page: 1, search: searchQuery)
        .then((FetchedProducts fetchedProducts) {
      currentProducts = fetchedProducts.products;
      currentTotalpages = fetchedProducts.totalPages;
      currentTotalResults = fetchedProducts.totalResults;
      currentProductsIsLoading = false;
      notifyListeners();
    });
  }

  // for Favourites screen
  List<Product> favoritesProducts = [];
}
