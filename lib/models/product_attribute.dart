import 'package:flutter/cupertino.dart';

class ProductAttribute {
  final int id;
  String slug;
  final String name;
  final int position;
  final bool isVisible;
  final bool isVariation;
  final List<String> options;
  var selectedValue;

  ProductAttribute(
      {@required this.id,
      @required this.name,
      @required this.position,
      @required this.isVisible,
      @required this.isVariation,
      @required this.options,
      this.selectedValue,
      this.slug});
}
