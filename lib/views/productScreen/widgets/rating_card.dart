import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/reviews.dart';

class RatingCard extends StatelessWidget {
  final Reviews reviews;
  RatingCard({@required this.reviews});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.all(5.0),
          child: Text(
            '(' + reviews.ratingCount.toString() + ')',
            style: TextStyle(color: Palette.black, fontSize: 24),
          ),
        ),
        RatingBarIndicator(
          rating: double.parse(reviews.averageRating),
          direction: Axis.horizontal,
          itemBuilder: (context, index) => Icon(
            Icons.star,
            color: Colors.amber,
          ),
          itemCount: 5,
          itemSize: 24,
        ),
      ],
    );
  }
}
