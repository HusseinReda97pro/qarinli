import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';

class MoreButton extends StatelessWidget {
  final Category category;
  final bool withoutOffers;
  MoreButton({this.category, this.withoutOffers});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
      builder: (context, model, chlild) {
        return Row(
          children: [
            Expanded(child: SizedBox()),
            Container(
              margin: EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () async {
                    model.getCurrentProducts(
                        pageNumber: 2,
                        filter: Filter(categories: [category], tags: []));
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductsScreen();
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.more,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  )),
            )
          ],
        );
      },
    );
  }
}
