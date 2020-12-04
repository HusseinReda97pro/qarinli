class Category {
  final int id;
  String name;
  final String imageUrl;
  List<Category> subCategories;
  int count;
  Category({this.id, this.name, this.imageUrl, this.subCategories, this.count});
}
