import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/controllers/products_controller.dart';
import 'package:qarinli/models/product.dart';
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
        List<Product> relatedProducts = [];
        try {
          for (var id in product.relatedIds) {
            var product = await MyApp.mainModel.productsController
                .getProduct(productId: id.toString());
            relatedProducts.add(product);
          }
        } catch (e) {
          print('get product error');
          print(e.toString());
        }
        Navigator.pop(context);
        Navigator.push(context,
            MaterialPageRoute(builder: (BuildContext context) {
          return ProductScreen(
            product: product,
            relatedProducts: relatedProducts,
          );
        }));
      },
      child: Card(
        // color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(),
                ),
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        product.price + ' ر.س',
                        textDirection: TextDirection.rtl,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                            color: Colors.green[700],
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                    product.shops.length > 0
                        ? Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 2),
                            width: MediaQuery.of(context).size.width * 0.65,
                            child: Text(
                              '+' +
                                  'أكثر من ' +
                                  product.shops.length.toString(),
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                fontSize: 10,
                                color: Palette.black,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          )
                        : Container(),
                    Container(
                      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                      width: MediaQuery.of(context).size.width * 0.65,
                      child: Text(
                        product.name,
                        textAlign: TextAlign.right,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.all(5.0),
                  width: 60,
                  height: 60,
                  child: product.imageUrl != null
                      ? FadeInImage(
                          image: CachedNetworkImageProvider(product.imageUrl),
                          placeholder:
                              AssetImage('assets/placeholder_image.png'),
                        )
                      : Image.asset('assets/placeholder_image.png'),
                ),
                // product.imageUrl != null
                //     ? Container(
                //         margin: EdgeInsets.all(5.0),
                //         child: Image.network(
                //           product.imageUrl,
                //           width: 60,
                //           height: 60,
                //         ),
                //       )
                //     : Container(
                //         margin: EdgeInsets.all(5.0),
                //         child: Image.asset(
                //           'assets/placeholder_image.png',
                //           width: 60,
                //           height: 60,
                //         ),
                //       ),
              ],
            ),
            product.shops.length > 0 ? Divider() : Container(),
            ColumnBuilder(
                itemCount: product.shops.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                    width: MediaQuery.of(context).size.width * 0.85,
                    child: Card(
                      // color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 2, vertical: 6),
                        child: Row(
                          children: [
                            ClipOval(
                              child: Container(
                                color: Theme.of(context).primaryColor,
                                child: Icon(
                                  Icons.arrow_right,
                                  size: 24.0,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 6.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'SAR ' + product.shops[index].price,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                Text(product.shops[index].domain,
                                    style: TextStyle(
                                        fontSize: 12.0, color: Palette.black)),
                              ],
                            )
                          ],
                        ),
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
