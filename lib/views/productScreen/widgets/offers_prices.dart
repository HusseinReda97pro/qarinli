import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:url_launcher/url_launcher.dart';

class OffersPrices extends StatelessWidget {
  final List<Shop> shops;

  const OffersPrices({this.shops});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 10.0),
      child: ColumnBuilder(
        itemCount: shops.length,
        itemBuilder: (BuildContext context, int index) {
          return Container(
            margin: EdgeInsets.only(bottom: 10.0),
            child: RaisedButton(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Palette.midBlue, width: 2.0),
              ),
              color:
                  theme == AppTheme.LIGHT ? Palette.grey : Palette.lightBlack,
              onPressed: () async {
                String url = shops[index].offerLink;
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
              child: Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(5.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          shops[index].price.isNotEmpty
                              ? double.parse(shops[index].price)
                                      .toStringAsFixed(2) +
                                  ' ر.س'
                              : '',
                          textDirection: TextDirection.rtl,
                          style: TextStyle(
                              fontSize: 20,
                              color: theme == AppTheme.LIGHT
                                  ? Colors.white
                                  : Palette.yellow),
                        ),
                        Text(shops[index].domain),
                      ],
                    ),
                  ),
                  Expanded(
                    child: SizedBox(),
                  ),
                  Container(
                    margin: EdgeInsets.all(5.0),
                    height: 30,
                    width: 30,
                    child: shops[index].domain != null
                        ? FadeInImage(
                            width: 60,
                            height: 60,
                            image: CachedNetworkImageProvider(
                              'https://www.qarinli.com/wp-content/uploads/ce-logos/icon_' +
                                  shops[index]
                                      .domain
                                      .replaceAll(new RegExp(r'\.'), '-') +
                                  '.png',
                            ),
                            placeholder:
                                AssetImage('assets/placeholder_image.png'),
                          )
                        : Image.asset('assets/placeholder_image.png'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
