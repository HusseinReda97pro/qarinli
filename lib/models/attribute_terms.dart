import 'package:flutter/cupertino.dart';

class AttributeTermas {
  final String id;
  final String name;
  final String slug;
  final int count;
  bool isSelected;
  AttributeTermas({
    @required this.id,
    @required this.name,
    @required this.slug,
    @required this.count,
    @required this.isSelected,
  });
}
