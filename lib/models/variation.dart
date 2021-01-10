import 'package:flutter/cupertino.dart';
import 'package:qarinli/models/product_attribute.dart';

class Variation {
  final int id;
  final String link;
  final String sku;
  final String price;
  final String regularPrice;
  final String salePrice;
  final bool onSale;
  final int stockQuantity;
  final String stockStatus;
  final String shippingClass;
  final int shippingClassId;
  final List<ProductAttribute> attributes;

  Variation(
      {@required this.id,
      @required this.link,
      @required this.sku,
      @required this.price,
      @required this.regularPrice,
      @required this.salePrice,
      @required this.onSale,
      @required this.stockQuantity,
      @required this.stockStatus,
      @required this.shippingClass,
      @required this.shippingClassId,
      @required this.attributes});
}
