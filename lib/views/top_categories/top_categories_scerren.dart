import 'package:flutter/material.dart';
import 'package:qarinli/views/landing_screen/tabs/products_tap.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class TopCategoriesScreen extends StatefulWidget {
  @override
  _TopCategoriesScreenState createState() => _TopCategoriesScreenState();
}

class _TopCategoriesScreenState extends State<TopCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      endDrawer: AppDrawer(),
      body: ProductsTab(),
    );
  }
}
