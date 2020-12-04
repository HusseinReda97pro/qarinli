import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';

class ShopCard extends StatelessWidget {
  final String imageURL;
  ShopCard({this.imageURL});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
        side: BorderSide(color: Palette.midBlue, width: 1),
      ),
      child: Container(
          width: 70,
          height: 70,
          margin: EdgeInsets.all(10.0),
          child: Image.asset(imageURL)),
    );
  }
}
