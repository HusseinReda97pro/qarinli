import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/review.dart';

class ReviewCard extends StatelessWidget {
  final Review review;
  ReviewCard({@required this.review});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(5.0),
      child: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              children: [
                review.reviewer != null && review.reviewer.length > 0
                    ? CircleAvatar(
                        backgroundColor: AppThemeModel.isLight()
                            ? Colors.black
                            : Colors.white,
                        child: Text(review.reviewer[0].toUpperCase()),
                      )
                    : SizedBox.shrink(),
                Container(
                  margin: EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      RatingBarIndicator(
                        rating: review.rating.toDouble(),
                        direction: Axis.horizontal,
                        unratedColor: AppThemeModel.isLight()
                            ? Colors.black
                            : Colors.white,
                        itemBuilder: (context, index) => Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                        itemCount: 5,
                        itemSize: 10,
                      ),
                      review.reviewer != null && review.reviewer.length > 0
                          ? Text(review.reviewer)
                          : SizedBox.shrink(),
                    ],
                  ),
                )
              ],
            ),
            Container(
              // child: Directionality(
              //   textDirection: TextDirection.rtl,
              child: Html(
                data: review.reviewHTML,
              ),
              // ),
            )
          ],
        ),
      ),
    );
  }
}
