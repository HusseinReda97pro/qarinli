import 'package:flutter/cupertino.dart';

class ProductCart {
  final String cartKey;
  final int productId;
  final int variationId;
  final String dataHash;
  final int quantity;
  final int subtotal;
  final int subtotalTax;
  final int total;
  final int tax;
  final String productName;
  final String productTitle;
  final String productPrice;

  ProductCart(
      {@required this.cartKey,
      @required this.productId,
      @required this.variationId,
      @required this.dataHash,
      @required this.quantity,
      @required this.subtotal,
      @required this.subtotalTax,
      @required this.total,
      @required this.tax,
      @required this.productName,
      @required this.productTitle,
      @required this.productPrice});
}
