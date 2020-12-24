import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/productScreen/widgets/review/add_review_card.dart';

import 'Review_card.dart';

class ReviwesList extends StatelessWidget {
  final int productId;
  ReviwesList({this.productId});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          body: Container(
            margin: EdgeInsets.only(top: 45.0),
            child: ListView(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.8 - 45.0,
                  child: model.currentReviewsIsLoading
                      ? Center(
                          child: Container(
                            width: 30,
                            height: 30,
                            child: CircularProgressIndicator(),
                          ),
                        )
                      : model.currentReviews.length > 0
                          ? ListView.builder(
                              itemCount: model.currentReviews.length,
                              itemBuilder: (BuildContext context, int index) {
                                return ReviewCard(
                                  review: model.currentReviews[index],
                                );
                              })
                          : Center(
                              child: Container(
                                width: 150,
                                height: 150,
                                child: Column(
                                  children: [
                                    Icon(
                                      MdiIcons.commentTextMultipleOutline,
                                      size: 36,
                                    ),
                                    Text(
                                      'لا توجد تقييمات بعد\n !كن أول من يقيم هذا المنتج',
                                      textAlign: TextAlign.center,
                                    )
                                  ],
                                ),
                              ),
                            ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.2,
                  child: AddReview(productId: productId,),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
