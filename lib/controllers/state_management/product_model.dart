import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/landing_categories.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/controllers/filter_controller.dart';
import 'package:qarinli/controllers/products_controller.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/fetchedProducts.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/models/tag.dart';

import '../category_controller.dart';

mixin ProductModel on ChangeNotifier {
  // for landing screen
  bool comparisonProductsLanddingIsLoading = false;
  List<Product> comparisonLanddingProducts = [];

  // bool choosenLanddingIsLoading = false;
  // List<Product> choosenLanddingProducts = [];

  bool modaLanddingIsLoading = false;
  List<Product> modaLanddingProducts = [];

  bool laptopsLanddingIsLoading = false;
  List<Product> laptopsLanddingProducts = [];

  // bool ainiaSha5siaLanddingIsLoading = false;
  // List<Product> ainiaSha5siaLanddingProducts = [];

  bool atorLanddingIsLoading = false;
  List<Product> atorLanddingProducts = [];

  bool mobsLanddingIsLoading = false;
  List<Product> mobsLanddingProducts = [];

  bool homeEquipmentsIsLoading = false;
  List<Product> homeEquipmentsLanddingProducts = [];

  ProductsController productsController = ProductsController();
  CategoryController categoryController = CategoryController();

  // for filter
  Filter currentFilter = Filter(
      minPrice: 0,
      maxPrice: 50000,
      attributeTermas: [],
      categories: [],
      tags: []);
  Filter filterToApply = Filter(
      minPrice: 0,
      maxPrice: 50000,
      attributeTermas: [],
      categories: [],
      tags: []);

  FilterController filterController = FilterController();
  int maxPriceSliderLimt = 50000;
  bool currentAttributeTermasIsLoading = false;

  Future<void> getCurrentMaxPrice(
      {List<Category> categories, List<Tag> tags}) async {
    int price =
        await filterController.getMaxPrice(cateories: categories, tags: tags);
    currentFilter.maxPrice = price;
    filterToApply.maxPrice = price;
    filterToApply.tags = tags;
    filterToApply.categories = categories;
    filterToApply.attribute = null;
    filterToApply.attributeTermas = [];

    maxPriceSliderLimt = price;
  }

  Future<void> getCurrentAttributeTermas({@required String attributeId}) async {
    currentAttributeTermasIsLoading = true;
    notifyListeners();
    filterToApply.attributeTermas = await filterController
        .getCurrentAttributeTermas(attributeId: attributeId);
    currentAttributeTermasIsLoading = false;
    notifyListeners();
  }

  void selectAttributeTermas({int index, bool selected}) {
    filterToApply.attributeTermas[index].isSelected = selected;
    notifyListeners();
  }

  // for filter by category
  List<Category> filterCategories = [];
  List<Tag> filterTags = [];

  Future<void> getFilterCategories({categoriesIds}) async {
    if (filterCategories.isEmpty) {
      filterCategories = await categoryController.getFilterCategories(
          categoriesIds: categoriesIds);
    }
  }

  void selectCategoryToFilter({@required int categoryId}) {
    Category category = filterCategories.firstWhere((Category cat) {
      return cat.id == categoryId;
    });
    filterToApply.categories.add(category);
    notifyListeners();
  }

  void removeCategoryFromFilter({@required int categoryId}) {
    filterToApply.categories.removeWhere((Category cat) {
      return cat.id == categoryId;
    });
    notifyListeners();
  }

  Future<void> getFilterTags({tagIds}) async {
    if (filterTags.isEmpty) {
      filterTags = await categoryController.getFilterTags(tagIds: tagIds);
    }
  }

  void selectTagToFilter({@required int tagId}) {
    Tag tag = filterTags.firstWhere((Tag tag) {
      return tag.id == tagId;
    });
    filterToApply.tags.add(tag);
    notifyListeners();
  }

  void removeTagFromFilter({@required int tagId}) {
    filterToApply.tags.removeWhere((Tag tag) {
      return tag.id == tagId;
    });
    notifyListeners();
  }

// for landing
  Future<void> loadProductsLanding() async {
    loadComparisonProductsLdnding();
    // loadChoosenLdnding();
    loadModaLdnding();
    loadLaptopsLdnding();
    // loadAiniaSha5siaLdnding();
    loadAtorLdnding();
    loadMobsLdnding();
    loadhomeEquipmentsLdnding();
  }

  Future<void> loadComparisonProductsLdnding() async {
    comparisonProductsLanddingIsLoading = true;
    notifyListeners();
    comparisonLanddingProducts.clear();
    Filter filter = Filter(tags: [comparisonTag], categories: []);
    productsController
        .getProducts(page: 1, filter: filter)
        .then((FetchedProducts fetchedProducts) {
      comparisonLanddingProducts = fetchedProducts.products;
      comparisonProductsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  // Future<void> loadChoosenLdnding() async {
  //   choosenLanddingIsLoading = true;
  //   notifyListeners();
  //   choosenLanddingProducts.clear();
  //   Filter filter = Filter(featured: true);
  //   productsController
  //       .getProducts(page: 1, filter: filter)
  //       .then((FetchedProducts fetchedProducts) {
  //     choosenLanddingProducts = fetchedProducts.products;
  //     choosenLanddingIsLoading = false;
  //     notifyListeners();
  //   });
  // }

  Future<void> loadModaLdnding() async {
    modaLanddingIsLoading = true;
    notifyListeners();
    modaLanddingProducts.clear();
    Filter filter = Filter(categories: [modaCat], tags: []);
    // Filter filter = Filter(categoryId: MODA_CAT_ID, featured: true);
    //TODO edit moda
    productsController
        .getProducts(page: 1, filter: filter)
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
    Filter filter = Filter(categories: [laptopsCat], tags: []);
    productsController
        .getProducts(page: 1, filter: filter)
        .then((FetchedProducts fetchedProducts) {
      laptopsLanddingProducts = fetchedProducts.products;
      laptopsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  // Future<void> loadAiniaSha5siaLdnding() async {
  //   ainiaSha5siaLanddingIsLoading = true;
  //   notifyListeners();
  //   ainiaSha5siaLanddingProducts.clear();
  //   Filter filter = Filter(categoryId: AINIA_SHA5SIA_CAT_ID);

  //   productsController
  //       .getProducts(page: 1, filter: filter)
  //       .then((FetchedProducts fetchedProducts) {
  //     ainiaSha5siaLanddingProducts = fetchedProducts.products;
  //     ainiaSha5siaLanddingIsLoading = false;
  //     notifyListeners();
  //   });
  // }

  Future<void> loadAtorLdnding() async {
    atorLanddingIsLoading = true;
    notifyListeners();
    atorLanddingProducts.clear();
    Filter filter = Filter(categories: [atorCat], tags: []);

    productsController
        .getProducts(page: 1, filter: filter)
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
    Filter filter = Filter(categories: [mobsCat], tags: []);
    productsController
        .getProducts(page: 1, filter: filter)
        .then((FetchedProducts fetchedProducts) {
      mobsLanddingProducts = fetchedProducts.products;
      mobsLanddingIsLoading = false;
      notifyListeners();
    });
  }

  Future<void> loadhomeEquipmentsLdnding() async {
    homeEquipmentsIsLoading = true;
    notifyListeners();
    homeEquipmentsLanddingProducts.clear();
    Filter filter = Filter(categories: [homeEquipmentsCat], tags: []);
    productsController
        .getProducts(page: 1, filter: filter)
        .then((FetchedProducts fetchedProducts) {
      homeEquipmentsLanddingProducts = fetchedProducts.products;
      homeEquipmentsIsLoading = false;
      notifyListeners();
    });
  }

  // for products screen
  List<Product> currentProducts = [];
  bool currentProductsIsLoading = false;
  int currentTotalResults = 0;
  int currentTotalpages = 0;
  Future<void> getCurrentProducts(
      {int pageNumber, Filter filter, String favorites}) async {
    currentProductsIsLoading = true;
    notifyListeners();
    currentProducts.clear();
    currentFilter = filter;
    productsController
        .getProducts(
            page: pageNumber,
            filter: filter,
            favorites: favorites,
            relateds: null)
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
    relatedProductsIsLoading = true;
    notifyListeners();
    relatedProducts.clear();
    String related = '';

    try {
      for (var id in relatedIds) {
        try {
          related += id.toString() + ',';
        } catch (_) {}
      }
      productsController
          .getProducts(relateds: related)
          .then((FetchedProducts fetchedProducts) {
        print(fetchedProducts.products);
        relatedProducts = fetchedProducts.products;
        print('relateds: ' + relatedProducts.length.toString());
        relatedProductsIsLoading = false;
        notifyListeners();
      });
    } catch (e) {
      print(e);
    }
  }

  // for top categories screen
  Future<void> getTopCategoryCurrentProducts(
      {@required int selectedIndex, int pageNamber, Category category}) async {
    topCategories[selectedIndex].productsIsLoading = true;
    notifyListeners();
    currentProducts.clear();
    Filter filter = Filter(categories: [category], tags: []);
    productsController
        .getProducts(page: pageNamber, filter: filter)
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

  // for Favourites screen
  List<Product> favoritesProducts = [];
}
