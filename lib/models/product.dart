import 'package:qarinli/models/shop.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String shortDescription;
  final List<Shop> shops;
  final String bestPriceDomain;

  Product(
      {this.id,
      this.name,
      this.price,
      this.imageUrl,
      this.description,
      this.shortDescription,
      this.shops,
      this.bestPriceDomain});
}
