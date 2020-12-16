import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/main.dart';
import 'package:qarinli/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

class BestPrice extends StatelessWidget {
  final Product product;
  BestPrice({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: RaisedButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Palette.midBlue, width: 2.0),
        ),
        color: theme == AppTheme.LIGHT ? Palette.grey : Palette.lightBlack,
        onPressed: () async {
          String url = product.bestPriceURL;
          if (await canLaunch(url)) {
            await launch(
              url,
              forceSafariVC: false,
              forceWebView: false,
            );
          } else {
            throw 'Could not launch $url';
          }
        },
        child: product.price.isNotEmpty
            ? Column(
                children: [
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    padding: EdgeInsets.symmetric(vertical: 5.0),
                    child: Row(
                      children: [
                        Text(
                          product.price.isNotEmpty
                              ? double.parse(product.price).toStringAsFixed(2) +
                                  ' ر.س'
                              : '',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                          ),
                        ),
                        Expanded(child: SizedBox()),
                        Container(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(right: 4.0),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.star,
                                        size: 20,
                                        color: Colors.white,
                                      ),
                                      Text(
                                        'أفضل عرض',
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 24,
                                            fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                              product.shops.length > 0
                                  ? Text(
                                      MyApp.mainModel.productsController
                                              .getCheapestPrice(product.shops)
                                              .domain +
                                          ' أفضل عرض في',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 12.0),
                                    )
                                  : SizedBox.shrink()
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )
            : Text(
                'شراء المنتج',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold),
              ),
      ),
    );
  }
}
