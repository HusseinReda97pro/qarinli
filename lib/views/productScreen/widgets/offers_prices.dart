import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersPrices extends StatelessWidget {
  final List<Shop> shops;

  const OffersPrices({this.shops});
  @override
  Widget build(BuildContext context) {
    return ColumnBuilder(
      itemCount: shops.length,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8.0),
                child: RaisedButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18.0),
                  ),
                  color: Theme.of(context).primaryColor,
                  onPressed: () async {
                    String url = shops[index].offerLink;
                    if (await canLaunch(url)) {
                      await launch(url);
                    } else {
                      throw 'Could not launch $url';
                    }
                  },
                  child: Text(
                    'الشراء الأن',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
            Container(
              width: 1.0,
              height: 40.0,
              child: VerticalDivider(
                color: Palette.black,
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'SAR ',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Palette.green),
                      ),
                      Text(
                        shops[index].price,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Text(shops[index].domain),
                ],
              ),
            ),
            Container(
              width: 1.0,
              height: 40.0,
              child: VerticalDivider(
                color: Palette.black,
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.all(5.0),
                height: 75,
                width: 75,
                child: shops[index].domain != null
                    ? FadeInImage(
                        // width: 60,
                        // height: 60,
                        image: CachedNetworkImageProvider(
                          'https://www.qarinli.com/wp-content/uploads/ce-logos/icon_' +
                              shops[index]
                                  .domain
                                  .replaceAll(new RegExp(r'\.'), '-') +
                              '.png',
                        ),
                        placeholder: AssetImage('assets/placeholder_image.png'),
                      )
                    : Image.asset('assets/placeholder_image.png'),
              ),
            ),
          ],
        );
      },
    );
  }
}
