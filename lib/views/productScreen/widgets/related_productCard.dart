import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qarinli/views/productScreen/product_screen.dart';
import 'package:qarinli/views/widgets/loading.dart';

import '../../../main.dart';

class RelatedProductCard extends StatelessWidget {
  final Product product;
  RelatedProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        loading(context, 'loaading');

        MyApp.mainModel.getRelatedProducts(product.relatedIds);

        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ProductScreen(
            product: product,
          );
        }));
      },
      child: Card(
        // color: Palette.lightGrey,
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14.0),
          side: BorderSide(color: Palette.midBlue, width: 1),
        ),
        child: Column(
          children: [
            Container(
              width: 140,
              height: 110,
              // margin: EdgeInsets.all(10.0),
              child: product.imageUrl != null
                  ? FadeInImage(
                      image: CachedNetworkImageProvider(product.imageUrl),
                      placeholder: AssetImage('assets/placeholder_image.png'),
                    )
                  : Image.asset('assets/placeholder_image.png'),
            ),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
              width: 120,
              height: 75,
              child: Text(
                product.name,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                  fontSize: 14.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.all(10.0),
              width: 120,
              child: Row(
                children: [
                  Text(
                    product.price.isNotEmpty
                        ? double.parse(product.price).toStringAsFixed(2) +
                            ' ر.س'
                        : '',
                    textDirection: TextDirection.rtl,
                    style: TextStyle(
                        color: theme == AppTheme.LIGHT
                            ? Colors.black
                            : Palette.yellow,
                        fontSize: 18.0),
                  ),
                  Expanded(child: SizedBox())
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
