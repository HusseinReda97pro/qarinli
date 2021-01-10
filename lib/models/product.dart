import 'package:flutter/material.dart';
import 'package:qarinli/config/landing_categories.dart';
import 'package:qarinli/models/product_attribute.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/models/tag.dart';
import 'package:qarinli/models/youtube_video.dart';

class Product {
  final int id;
  final String link;
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String shortDescription;
  final List<Shop> shops;
  final String bestPriceURL;
  final List<YoutubeVideo> youtubeVideos;
  final List<String> images;
  final String reviewAverageRating;
  final int reviewRatingCount;
  final List<dynamic> relatedIds;
  // final dynamic historOfPricesHTML;
  final List<Tag> tags;
  final List<ProductAttribute> attributes;

  Product(
      {@required this.id,
      @required this.link,
      @required this.name,
      @required this.price,
      @required this.imageUrl,
      @required this.description,
      @required this.shortDescription,
      @required this.shops,
      @required this.bestPriceURL,
      @required this.youtubeVideos,
      @required this.images,
      @required this.reviewAverageRating,
      @required this.reviewRatingCount,
      @required this.relatedIds,
      @required this.tags,
      @required this.attributes
      // @required this.historOfPricesHTML
      });

  bool get isQarinliProduct {
    for (Tag tag in this.tags) {
      if (tag.id == QARINLI_TAG_ID) {
        return true;
      }
    }
    return false;
  }

  List<ProductAttribute> get attributesVariations {
    List<ProductAttribute> variations = [];
    for (ProductAttribute productAttribute in this.attributes) {
      if (productAttribute.isVariation) {
        variations.add(productAttribute);
      }
    }
    return variations;
  }
}
