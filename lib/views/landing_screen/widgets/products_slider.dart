import 'package:flutter/cupertino.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/landing_screen/widgets/progress_indicator.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

import 'Product_card_landing_screen.dart';
import 'more.dart';

class ProductsSlider extends StatelessWidget {
  final bool isLoading;
  final List<Product> products;
  final int categoryId;
  final bool withoutOffers;

  const ProductsSlider(
      {@required this.isLoading,
      @required this.products,
      @required this.categoryId,
      @required this.withoutOffers});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ProgressIndicatorV2()
        : Column(
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: RowBuilder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                ),
              ),
              MoreButton(
                categoryId: categoryId,
                withoutOffers: withoutOffers,
              )
            ],
          );
  }
}
