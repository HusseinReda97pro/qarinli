import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/review.dart';
import 'package:qarinli/views/unlogedin_user.dart';
import 'package:qarinli/views/widgets/alert_message.dart';
import 'package:qarinli/views/widgets/loading.dart';

class AddReview extends StatefulWidget {
  final int productId;
  AddReview({this.productId});
  @override
  _AddReviewState createState() => _AddReviewState();
}

class _AddReviewState extends State<AddReview> {
  int rate;
  TextEditingController reviewController;

  @override
  void initState() {
    reviewController = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Card(
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              child: RatingBar.builder(
                initialRating: 0,
                minRating: 0,
                direction: Axis.horizontal,
                unratedColor:
                    AppThemeModel.isLight ? Colors.black : Colors.white,
                itemCount: 5,
                itemSize: 24.0,
                itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                itemBuilder: (context, _) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                onRatingUpdate: (rating) {
                  rate = rating.toInt();
                },
              ),
            ),
            Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextField(
                      controller: reviewController,
                      decoration: InputDecoration(
                        hintText: 'تقييمك',
                        border: InputBorder.none,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Palette.black),
                        ),
                        focusedErrorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(6.0)),
                          borderSide: BorderSide(color: Palette.black),
                        ),
                        errorBorder: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(6.0)),
                            borderSide: BorderSide(color: Colors.red),
                            gapPadding: 100),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(18.0),
                          ),
                          borderSide: BorderSide(color: Palette.black),
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                    onPressed: (reviewController.text.length > 0 &&
                            rate != null)
                        ? () async {
                            if (reviewController.text.length > 0 &&
                                rate != null) {
                              if (model.currentUser == null) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) {
                                      return UnLogedinUser(
                                        fullScreen: true,
                                      );
                                    },
                                  ),
                                );
                              } else {
                                Review review = Review(
                                    productId: widget.productId.toString(),
                                    rating: rate,
                                    reviewHTML: reviewController.text,
                                    reviewer: model.currentUser.username,
                                    reviewerEmail: model.currentUser.email);
                                loading(context, 'جاري الإرسال');
                                String message = await model.reviewController
                                    .addReview(review: review);
                                Navigator.pop(context);
                                if (message == 'approved') {
                                  showAlertMessage(
                                      context: context,
                                      title: 'تم بنجاح',
                                      message: Text(
                                          'تم إرسال التعليق في انتظار المراجعة'));
                                } else {
                                  if (message == null) {
                                    showAlertMessage(
                                        context: context,
                                        title: 'حدث خطأ ما',
                                        message: Text('حدث خطأ غير معروف'));
                                  } else {
                                    showAlertMessage(
                                        context: context,
                                        title: 'حدث خطأ ما',
                                        message: Html(
                                          data: message,
                                        ));
                                  }
                                }
                              }
                            } else {
                              if (reviewController.text.length > 0) {
                                showAlertMessage(
                                    context: context,
                                    title: 'حدث خطأ ما',
                                    message: Text('قم بكتابة تعليق'));
                              } else {
                                if (reviewController.text.length > 0) {
                                  showAlertMessage(
                                      context: context,
                                      title: 'حدث خطأ ما',
                                      message: Text('قم باختيار تقييمك'));
                                }
                              }
                            }
                          }
                        : null,
                    icon: Icon(MdiIcons.send,
                        color: AppThemeModel.isLight
                            ? Palette.midBlue
                            : Colors.white)),
              ],
            ),
          ],
        ),
      );
    });
  }
}
