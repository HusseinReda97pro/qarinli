import 'package:qarinli/models/reviews.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/models/youtube_video.dart';

class Product {
  final int id;
  final String name;
  final String price;
  final String imageUrl;
  final String description;
  final String shortDescription;
  final List<Shop> shops;
  final String bestPriceDomain;
  final List<YoutubeVideo> youtubeVideos;
  final List<String> images;
  final Reviews reviews;
  final List<dynamic> relatedIds;

  Product(
      {this.id,
      this.name,
      this.price,
      this.imageUrl,
      this.description,
      this.shortDescription,
      this.shops,
      this.bestPriceDomain,
      this.youtubeVideos,
      this.images,
      this.reviews,
      this.relatedIds});
}
