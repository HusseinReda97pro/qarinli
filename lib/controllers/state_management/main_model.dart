import 'package:flutter/material.dart';
import 'package:qarinli/controllers/state_management/blog_model.dart';
import 'package:qarinli/controllers/state_management/category_model.dart';
import 'package:qarinli/controllers/state_management/product_model.dart';
import 'package:qarinli/controllers/state_management/user_model.dart';

class MainModel extends ChangeNotifier
    with ProductModel, BlogModel, CategoryModel, UserModel {}
