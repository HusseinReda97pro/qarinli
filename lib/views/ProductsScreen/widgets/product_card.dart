import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/productScreen/product_screen.dart';
import 'package:qarinli/views/widgets/alert_message.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/loading.dart';

import '../../../main.dart';
import '../../unlogedin_user.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({this.product});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
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
          // color: Colors.black,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    // color: Colors.red,
                    // width: 8.0,
                    child: IconButton(
                      color: theme == AppTheme.LIGHT
                          ? Colors.black
                          : Palette.yellow,
                      padding: EdgeInsets.all(0),
                      icon: Icon(model.currentUser == null
                          ? Icons.favorite_outline
                          : model.currentUser.favoritesProducts
                                  .contains(product.id)
                              ? Icons.favorite
                              : Icons.favorite_outline),
                      onPressed: () async {
                        if (model.currentUser == null) {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return UnLogedinUser(
                              fullScreen: true,
                            );
                          }));
                        } else {
                          if (model.currentUser.favoritesProducts
                              .contains(product.id)) {
                            bool done = await model.removeFavorite(
                                productId: product.id);
                            if (!done) {
                              showAlertMessage(
                                  context: context,
                                  title: 'حدث خطأ ما',
                                  message: Text(
                                    'حدث خطأ غير معروف',
                                    textAlign: TextAlign.center,
                                  ));
                            }
                          } else {
                            bool done =
                                await model.addFavorite(productId: product.id);
                            if (!done) {
                              showAlertMessage(
                                  context: context,
                                  title: 'حدث خطأ ما',
                                  message: Text(
                                    'حدث خطأ غير معروف',
                                    textAlign: TextAlign.center,
                                  ));
                            }
                          }
                        }
                      },
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Column(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          product.name,
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                            fontSize: 16,
                            color: AppThemeModel.isLight()
                                ? Colors.black
                                : Palette.yellow,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      product.shops.length > 0
                          ? Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 2),
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: Text(
                                '+' +
                                    'أكثر من ' +
                                    product.shops.length.toString(),
                                textAlign: TextAlign.right,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: theme == AppTheme.LIGHT
                                      ? Palette.black
                                      : Colors.white,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            )
                          : Container(),
                      Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 2),
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Text(
                          product.price.isNotEmpty
                              ? double.parse(product.price).toStringAsFixed(2) +
                                  ' ر.س'
                              : '',
                          textDirection: TextDirection.rtl,
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: theme == AppTheme.LIGHT
                                  ? Palette.midBlue
                                  : Palette.yellow,
                              fontWeight: FontWeight.w700),
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
                        elevation: 3.0,
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
                                  color: theme == AppTheme.LIGHT
                                      ? Palette.midBlue
                                      : Colors.white,
                                  child: Icon(
                                    Icons.arrow_right,
                                    size: 24.0,
                                    color: theme == AppTheme.LIGHT
                                        ? Colors.white
                                        : Palette.midBlue,
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
                                    product.shops[index].price + ' ر.س',
                                    textDirection: TextDirection.rtl,
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  Text(product.shops[index].domain,
                                      style: TextStyle(
                                        fontSize: 12.0,
                                        color: theme == AppTheme.LIGHT
                                            ? Palette.black
                                            : Colors.white,
                                      )),
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
    });
  }
}
