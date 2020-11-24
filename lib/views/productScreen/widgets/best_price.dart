import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/main.dart';
import 'package:qarinli/models/product.dart';
import 'package:url_launcher/url_launcher.dart';

class BestPrice extends StatelessWidget {
  final Product product;
  BestPrice({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 10.0),
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.all(4.0),
                  child: Text(
                    'ر.س',
                    style: TextStyle(
                        color: Palette.green,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  child: Text(
                    product.price,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Expanded(child: SizedBox()),
                Container(
                  // margin: EdgeInsets.all(3.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(right: 4.0),
                        child: Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 24,
                              color: Theme.of(context).primaryColor,
                            ),
                            Text(
                              'أفضل عرض',
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                      product.shops.length > 0
                          ? Text(
                              MyApp.mainModel.productsController
                                      .getCheapestPrice(product.shops)
                                      .domain +
                                  ' أفضل عرض في',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 12.0),
                            )
                          : SizedBox.shrink()
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
            width: MediaQuery.of(context).size.width,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () async {
                String url = product.bestPriceURL;
                if (await canLaunch(url)) {
                  await launch(url);
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: Text(
                'أشتري بأفضل سعر',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          )
        ],
      ),
    );
  }
}
