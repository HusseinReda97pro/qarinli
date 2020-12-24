import 'package:qarinli/models/shop.dart';
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

  Product({
    this.id,
    this.link,
    this.name,
    this.price,
    this.imageUrl,
    this.description,
    this.shortDescription,
    this.shops,
    this.bestPriceURL,
    this.youtubeVideos,
    this.images,
    this.reviewAverageRating,
    this.reviewRatingCount,
    this.relatedIds,
    // this.historOfPricesHTML
  });
}
