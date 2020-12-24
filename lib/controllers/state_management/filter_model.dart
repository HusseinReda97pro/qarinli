import 'package:flutter/material.dart';
import 'package:qarinli/models/filter.dart';

mixin FilterModel on ChangeNotifier {
  Filter currentFilter = Filter();
}
