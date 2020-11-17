import 'package:flutter/material.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';
import 'package:qarinli/views/widgets/loading.dart';
import 'package:qarinli/controllers/products.dart';

class CategoryCard extends StatelessWidget {
  final Category category;
  CategoryCard({this.category});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        loading(context, 'looding');
        print(category.id);
        List<Product> products =
            await ProductsController.getProducts(1, category.id);
        Navigator.of(context).pop();
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ProductsScreen(
            products: products,
            categoryId: category.id,
          );
        }));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 6.0),
        child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  category.name,
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: 12.0,
                ),
                category.imageUrl != null
                    ? Image.network(
                        category.imageUrl,
                        width: 25,
                        height: 25,
                      )
                    : Container()
              ],
            )),
      ),
    );
  }
}
