import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';

class BestPrice extends StatelessWidget {
  final String price;
  BestPrice({@required this.price});
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
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  margin: EdgeInsets.all(4.0),
                  child: Text(
                    price,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 30.0,
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
                      Text(
                        'amazon.com أفضل عرض في',
                        style: TextStyle(color: Colors.black, fontSize: 12.0),
                      ) //TODO Edit shop
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
              onPressed: () {
                //TODO open best price page
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
