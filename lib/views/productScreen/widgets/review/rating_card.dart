import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/product.dart';

class RatingCard extends StatelessWidget {
  final Product product;
  RatingCard({@required this.product});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RatingBarIndicator(
          rating: double.parse(product.reviewAverageRating),
          direction: Axis.horizontal,
          unratedColor: AppThemeModel.isLight() ? Colors.black : Colors.white,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 42,
        ),
        Container(
          margin: EdgeInsets.all(5.0),
          child: Text(
            '(' + product.reviewRatingCount.toString() + ')',
            style: TextStyle(
                color: AppThemeModel.isLight() ? Palette.black : Colors.white,
                fontSize: 16),
          ),
        ),
      ],
    );
  }
}
