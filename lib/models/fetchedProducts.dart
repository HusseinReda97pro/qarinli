import 'package:flutter/material.dart';
import 'package:qarinli/models/product.dart';

class FetchedProducts {
  List<Product> products;
  int totalPages;
  int totalResults;
  FetchedProducts({
    @required this.products,
    @required this.totalPages,
    @required this.totalResults,
  });
}
