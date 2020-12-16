import 'package:flutter/cupertino.dart';
import 'package:qarinli/controllers/category_controller.dart';
import 'package:qarinli/controllers/products_controller.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/models/fetchedProducts.dart';

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
      productsController
          .getProducts(
        page: 1,
        categoryId: category.id,
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
  List<List<Category>> modaSubCategories = [];
  bool modaSubCategoriesIsloading = false;
  getModaSubCategories(List<Category> cats) async {
    modaSubCategoriesIsloading = true;
    notifyListeners();
    for (Category cat in cats) {
      List<Category> subCategories =
          await categoryController.getsubCategories(parentId: cat.id);
      modaSubCategories.add(subCategories);
    }
    modaSubCategoriesIsloading = false;
    notifyListeners();
  }
}
