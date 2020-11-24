import 'package:flutter/material.dart';

class ShopCard extends StatelessWidget {
  final String imageURL;
  ShopCard({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child:
          Container(margin: EdgeInsets.all(10.0), child: Image.asset(imageURL)),
    );
  }
}
