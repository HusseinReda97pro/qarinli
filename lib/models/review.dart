import 'package:flutter/material.dart';

class Review {
  final String id;
  final String productId;
  final String status; // approved
  final bool verified;
  final String reviewer;
  final String reviewerEmail;
  final String reviewHTML;
  final int rating;
  Review({
    this.id,
    @required this.productId,
    this.status,
    this.verified,
    @required this.rating,
    @required this.reviewHTML,
    @required this.reviewer,
    @required this.reviewerEmail,
  });
}
