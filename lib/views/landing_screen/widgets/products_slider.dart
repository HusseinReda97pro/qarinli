import 'package:flutter/cupertino.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/landing_screen/widgets/progress_indicator.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

import 'Product_card_landing_screen.dart';

class ProductsSlider extends StatelessWidget {
  final bool isLoading;
  final List<Product> products;
  final int categoryId;
  final bool withoutOffers;
  final TextDirection textDirection;

  const ProductsSlider(
      {@required this.isLoading,
      @required this.products,
      this.categoryId,
      this.withoutOffers,
      this.textDirection = TextDirection.rtl});

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? ProgressIndicatorV2()
        : Directionality(
            textDirection: textDirection,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0),
                child: IntrinsicHeight(
                  child: RowBuilder(
                    itemCount: products.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(product: products[index]);
                    },
                  ),
                ),
              ),
            ),
          );
  }
}
