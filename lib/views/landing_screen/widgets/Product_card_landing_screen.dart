import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/product.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  ProductCard({this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(14.0),
      ),
      child: Column(
        children: [
          Container(
            width: 70,
            height: 110,
            margin: EdgeInsets.all(10.0),
            child: product.imageUrl != null
                ? FadeInImage(
                    image: CachedNetworkImageProvider(product.imageUrl),
                    placeholder: AssetImage('assets/placeholder_image.png'),
                  )
                : Image.asset('assets/placeholder_image.png'),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 3.0, horizontal: 5.0),
            width: 110,
            height: 60,
            child: Text(
              product.name,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 12.0, fontWeight: FontWeight.w600),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            width: 120,
            child: Row(
              children: [
                Text(
                  'SAR ' + product.price,
                  style: TextStyle(
                      color: Palette.green, fontWeight: FontWeight.w700),
                ),
                Expanded(child: SizedBox())
              ],
            ),
          )
        ],
      ),
    );
  }
}
