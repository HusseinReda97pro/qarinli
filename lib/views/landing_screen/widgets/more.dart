import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';
import 'package:qarinli/views/widgets/loading.dart';

class MoreButton extends StatelessWidget {
  final int categoryId;
  final bool withoutOffers;
  MoreButton({this.categoryId, this.withoutOffers});
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
                    loading(context, 'looding');
                    model.currentProducts.clear();
                    model.currentProducts = await model.productsController
                        .getProducts(
                            page: 2,
                            categoryId: categoryId,
                            withoutOffers: withoutOffers);
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return ProductsScreen(
                            categoryId: categoryId,
                            withoutOffers: withoutOffers,
                          );
                        },
                      ),
                    );
                  },
                  child: Icon(
                    Icons.more,
                    size: 24,
                    color: Theme.of(context).primaryColor,
                  )
                  // Text(
                  //   'المزيد',
                  //   style: TextStyle(
                  //       color: Theme.of(context).primaryColor,
                  //       fontSize: 18.0,
                  //       decoration: TextDecoration.underline),
                  // ),
                  ),
            )
          ],
        );
      },
    );
  }
}
