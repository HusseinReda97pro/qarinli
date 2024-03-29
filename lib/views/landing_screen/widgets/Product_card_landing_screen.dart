import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:qarinli/views/productScreen/product_screen.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/loading.dart';

import '../../../main.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({this.product});

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
        color: Palette.lightGrey,
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
                margin: EdgeInsets.only(bottom: 10.0),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14.0),
                  child: product.imageUrl != null
                      ? Image.network(
                          product.imageUrl,
                          // height: 110,
                          // width: 140,
                          // fit: BoxFit.fill,
                        )
                      // FadeInImage(
                      //     image: CachedNetworkImageProvider(product.imageUrl),
                      //     placeholder: AssetImage('assets/placeholder_image.png'),
                      //   )
                      : Image.asset('assets/placeholder_image.png'),
                )),
            product.price.isNotEmpty
                ? Container(
                    margin: EdgeInsets.all(10.0),
                    width: 120,
                    child: Row(
                      children: [
                        Text(
                          double.parse(product.price).toStringAsFixed(2) +
                              ' ر.س',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor
                              // theme == AppTheme.LIGHT
                              //     ? Colors.black
                              //     : Palette.yellow
                              ,
                              fontSize: 18.0),
                        ),
                        Expanded(child: SizedBox())
                      ],
                    ),
                  )
                : SizedBox.shrink(),
            Container(
              margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
              width: 110,
              height: 80,
              child: Text(
                product.name,
                overflow: TextOverflow.clip,
                textDirection: TextDirection.rtl,
                style: TextStyle(
                    fontSize: 12.0, color: Theme.of(context).primaryColor),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ColumnBuilder(
                itemCount: product.shops.length,
                itemBuilder: (BuildContext context, int index) {
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(color: Palette.black, width: 0.5),
                    ),
                    color: Palette.lightGrey,
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 4.0),
                      child: Row(
                        children: [
                          Container(
                            margin: EdgeInsets.all(5.0),
                            height: 25,
                            width: 25,
                            child: product.shops[index].domain != null
                                ? FadeInImage(
                                    // width: 60,
                                    // height: 60,
                                    image: CachedNetworkImageProvider(
                                      'https://www.qarinli.com/wp-content/uploads/ce-logos/icon_' +
                                          product.shops[index].domain
                                              .replaceAll(
                                                  new RegExp(r'\.'), '-') +
                                          '.png',
                                    ),
                                    placeholder: AssetImage(
                                        'assets/placeholder_image.png'),
                                  )
                                : Image.asset('assets/placeholder_image.png'),
                          ),
                          SizedBox(
                            width: 4.0,
                          ),
                          Text(
                            double.parse(product.shops[index].price)
                                    .toStringAsFixed(2) +
                                ' ر.س',
                            style: TextStyle(
                                fontSize: 12,
                                color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
