import 'package:qarinli/models/shop.dart';

class Product {
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String shortDescription;
  final List<Shop> shops;

  Product(
      {this.name,
      this.price,
      this.imageUrl,
      this.description,
      this.shortDescription,
      this.shops});
}
