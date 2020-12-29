import 'package:flutter/cupertino.dart';
import 'package:qarinli/controllers/category_controller.dart';
import 'package:qarinli/controllers/products_controller.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/models/fetchedProducts.dart';
import 'package:qarinli/models/filter.dart';

mixin CategoryModel on ChangeNotifier {
  Category currentCategory;
  List<Category> currentSubCategories;

  CategoryController categoryController = CategoryController();
  ProductsController productsController = ProductsController();

  getStartPageSubCategories() async {
    for (Category category in topCategories) {
      category.subCategories =
          await categoryController.getsubCategories(parentId: category.id);
      notifyListeners();
    }
  }

  getStartPageCategoriesProducts() async {
    for (Category category in topCategories) {
      category.productsIsLoading = true;
      notifyListeners();
      Filter filter = Filter(categories: [category], tags: []);
      productsController
          .getProducts(
        page: 1,
        filter: filter,
      )
          .then((FetchedProducts fetchedProducts) {
        category.fetchedProducts.products = fetchedProducts.products;
        category.fetchedProducts.totalPages = fetchedProducts.totalPages;
        category.fetchedProducts.totalResults = fetchedProducts.totalResults;
      });
      category.productsIsLoading = false;
      notifyListeners();
    }
  }

  getSubCategories() async {
    currentCategory.subCategories =
        await categoryController.getsubCategories(parentId: currentCategory.id);
    print(currentCategory.subCategories.length);
    notifyListeners();
  }

// moda offers
  List<Category> modaSubCategories = [];
  bool modaSubCategoriesIsloading = false;
  getModaSubCategories() async {
    modaSubCategoriesIsloading = true;
    notifyListeners();
    modaSubCategories.clear();

    modaSubCategories = await categoryController.getsubCategories(
        parentId: 797, exclude: '798,799,2163');

    modaSubCategoriesIsloading = false;
    notifyListeners();
  }
}
