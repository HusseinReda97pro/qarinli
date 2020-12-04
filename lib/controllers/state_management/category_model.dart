import 'package:flutter/cupertino.dart';
import 'package:qarinli/controllers/category_controller.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/config/top_categories.dart';

mixin CategoryModel on ChangeNotifier {
  Category currentCategory;
  List<Category> currentSubCategories;
  CategoryController categoryController = CategoryController();
  getStartPageSubCategories() async {
    for (Category category in topCategories) {
      category.subCategories =
          await categoryController.getsubCategories(parentId: category.id);
      notifyListeners();
    }
  }

  getSubCategories() async {
    currentCategory.subCategories =
        await categoryController.getsubCategories(parentId: currentCategory.id);
    print(currentCategory.subCategories.length);
    notifyListeners();
  }
}
