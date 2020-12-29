import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/review.dart';
import 'package:http/http.dart' as http;

class ReviewController {
  Future<List<Review>> getReviews({@required int productId}) async {
    List<Review> reviews = [];
    try {
      var reviewsData;
      // int totalResults = 0;
      // int totalPages = 0;
      try {
        http.Response response;
        response = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/products/reviews?product=$productId&per_page=100',
            headers: <String, String>{'authorization': basicAuth});

        // try {
        //   totalResults = int.parse(response.headers['x-wp-total']);
        // } catch (_) {
        // }
        // try {
        //   totalPages = int.parse(response.headers['x-wp-totalpages']);
        // } catch (_) {}

        var responseBody = await json.decode(response.body);

        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          reviewsData = responseBody;
        } else {
          return [];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var reviewData in reviewsData) {
        try {
          Review review = Review(
              id: reviewData['id'].toString(),
              productId: reviewData['product_id'].toString(),
              status: reviewData['status'],
              verified: reviewData['verified'],
              rating: reviewData['rating'],
              reviewHTML: reviewData['review'],
              reviewer: reviewData['reviewer'],
              reviewerEmail: reviewData['reviewer_email']);
          // if (review.verified) {
          reviews.add(review);
          // }
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
    return reviews;
  }

  Future<String> addReview({@required Review review}) async {
    var body = {
      "product_id": review.productId,
      "review": review.reviewHTML,
      "reviewer": review.reviewer,
      "reviewer_email": review.reviewerEmail,
      "rating": review.rating.toString()
    };
    try {
      http.Response response;
      response = await http.post(
          'https://www.qarinli.com/wp-json/wc/v3/products/reviews',
          headers: <String, String>{'authorization': basicAuth},
          body: body);
      var responseBody = await json.decode(response.body);

      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        var reviewData = responseBody;
        try {
          Review review = Review(
              id: reviewData['id'].toString(),
              productId: reviewData['product_id'].toString(),
              status: reviewData['status'],
              verified: reviewData['verified'],
              rating: reviewData['rating'],
              reviewHTML: reviewData['review'],
              reviewer: reviewData['reviewer'],
              reviewerEmail: reviewData['reviewer_email']);
          print(reviewData);
          if (review.status == 'approved') {
            return 'approved';
          }
        } catch (e) {
          print(e);
          return null;
        }
      } else {
        print('Error');
        return responseBody['message'];
      }
    } catch (e) {
      return null;
    }
    return null;
  }
}
