import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/productScreen/widgets/review/rating_card.dart';
import 'package:qarinli/views/productScreen/widgets/review/reviwes_list.dart';

class ReviewsCard extends StatelessWidget {
  final Product product;
  ReviewsCard({@required this.product});

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(
              child: ReviwesList(
                productId: product.id,
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.only(top: 15, right: 10),
            child: Text(
              // 'User Reviews',
              'تقييمات المستخدم',
              textDirection: TextDirection.rtl,
              style: TextStyle(
                fontSize: 24.0,
              ),
            ),
          ),
          RatingCard(product: product),
          GestureDetector(
            onTap: () {
              model.getCurrentReviews(productId: product.id);
              displayBottomSheet(context);
            },
            child: Container(
              margin: EdgeInsets.all(5.0),
              child: Text(
                'قيم المنتج',
                style: TextStyle(
                    color:
                        AppThemeModel.isLight() ? Colors.black : Palette.yellow,
                    fontSize: 16.0),
              ),
            ),
          )
        ],
      );
    });
  }
}
