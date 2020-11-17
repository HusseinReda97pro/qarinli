import 'package:flutter/material.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/views/categories/widgets/category_card.dart';

class CategoryScreen extends StatefulWidget {
  final List<Category> categories;
  CategoryScreen({this.categories});
  @override
  _CategoryScreenState createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  int pageNamber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            'assets/logo.png',
            width: 65,
            height: 40,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 50),
            child: Text('Qarinli Demo'),
          ),
        ]),
      ),
      body: ListView.builder(
        itemCount: widget.categories.length,
        itemBuilder: (context, index) {
          return CategoryCard(category: widget.categories[index]);
        },
      ),
    );
  }
}
