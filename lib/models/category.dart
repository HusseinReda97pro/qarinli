import 'package:qarinli/models/fetchedProducts.dart';

class Category {
  final int id;
  String name;
  final String imageUrl;
  List<Category> subCategories;
  int count;
  FetchedProducts fetchedProducts;
  int currentPage;
  bool productsIsLoading;
  bool isSelected;
  Category(
      {this.id,
      this.name,
      this.imageUrl,
      this.subCategories,
      this.count,
      this.fetchedProducts,
      this.currentPage,
      this.productsIsLoading,
      this.isSelected});
}
