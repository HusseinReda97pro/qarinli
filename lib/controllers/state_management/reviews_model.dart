import 'package:flutter/cupertino.dart';
import 'package:qarinli/models/review.dart';

import '../review_controller.dart';

mixin ReviewModel on ChangeNotifier {
  ReviewController reviewController = ReviewController();
  List<Review> currentReviews = [];
  bool currentReviewsIsLoading = false;

  Future<void> getCurrentReviews({@required int productId}) async {
    currentReviewsIsLoading = true;
    notifyListeners();
    currentReviews = await reviewController.getReviews(productId: productId);
    currentReviewsIsLoading = false;
    notifyListeners();
  }
}
