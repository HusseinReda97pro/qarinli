import 'package:flutter/cupertino.dart';
import 'package:qarinli/models/attribute.dart';
import 'package:qarinli/models/attribute_terms.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/tag.dart';

class Filter {
  int minPrice;
  int maxPrice;
  List<Tag> tags;
  List<Category> categories;
  bool featured;
  String search;
  Attribute attribute;
  List<AttributeTermas> attributeTermas;

  Filter(
      {this.minPrice = 0,
      this.maxPrice = 50000,
      @required this.tags,
      @required this.categories,
      this.attribute,
      this.attributeTermas,
      this.featured,
      this.search});
}
