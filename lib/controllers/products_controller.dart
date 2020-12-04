import 'dart:convert';
import 'dart:io';

import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/reviews.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/models/youtube_video.dart';

class ProductsController {
  // Get Products with offers
  Future<List<Product>> getProducts({
    int page,
    int categoryId,
    bool withoutOffers = false,
    choosen = false,
    moda = false,
  }) async {
    // print(categoryId);

    List<Product> products = [];
    try {
      var productsData;
      try {
        http.Response response;
        if (choosen) {
          response = await http.get(
              'https://www.qarinli.com/wp-json/wc/v3/products?featured=true',
              headers: <String, String>{'authorization': basicAuth});
        } else {
          if (moda) {
            response = await http.get(
                'https://www.qarinli.com/wp-json/wc/v3/products?category=$categoryId&featured=true',
                headers: <String, String>{'authorization': basicAuth});
          } else {
            response = await http.get(
                'https://www.qarinli.com/wp-json/wc/v3/products?page=$page&category=$categoryId',
                headers: <String, String>{'authorization': basicAuth});
          }
        }
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          productsData = responseBody;
        } else {
          // return responseBody['message'];
          print(page);
          print(categoryId);
          print(
              '________________________________________________   Error  for products api _______________________');
          print(responseBody['message']);
          return [];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var product in productsData) {
        try {
          var metaData = product['meta_data'];
          String imageURL = getMainImage(
              metaData: metaData,
              images: product['images'],
              withoutOffers: withoutOffers);
          if (imageURL == null) {
            imageURL = getMainImage(
                metaData: metaData,
                images: product['images'],
                withoutOffers: true);
          }
          List<Shop> shops = getShopsOffers(metaData: metaData);
          List<YoutubeVideo> youtubeVideos =
              getYutubeVideos(metaData: metaData);
          List<String> images = getGoogleImages(metaData: metaData);
          Reviews reviews = getReviews(productData: product);
          // print(product['related_ids']);
          List<dynamic> relatedIds = product['related_ids'];
          // dynamic historOfPricesHTML =
          //     await getHistorOfPricesHTML(product['permalink']);
          String bestPriceURL = product['external_url'];
          if (bestPriceURL.isEmpty) {
            bestPriceURL = getCheapestPrice(shops).offerLink;
          }

          // print(shops);
          products.add(Product(
              id: product['id'],
              link: product['permalink'],
              name: product['name'],
              price: product['price'],
              imageUrl: imageURL,
              description: product['description'],
              shortDescription: product['short_description'],
              shops: shops,
              youtubeVideos: youtubeVideos,
              images: images,
              reviews: reviews,
              relatedIds: relatedIds,
              bestPriceURL: bestPriceURL
              // historOfPricesHTML: historOfPricesHTML
              ));
        } catch (_) {}
      }
    } catch (e) {
      print(
          '________________________________________________   Error  _______________________');
      print(e.toString());
    }

    return products;
  }

  // get single product
  Future<Product> getProduct(
      {String productId, bool withoutOffers = false}) async {
    Product product;
    String url = 'https://www.qarinli.com/wp-json/wc/v3/products/$productId';

    try {
      var productData;
      try {
        final http.Response response = await http
            .get(url, headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          productData = responseBody;
        } else {
          return responseBody['message'];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      // print(productData);

      var metaData = productData['meta_data'];
      String imageURL = getMainImage(
          metaData: metaData,
          images: productData['images'],
          withoutOffers: withoutOffers);
      if (imageURL == null) {
        imageURL = getMainImage(
            metaData: metaData,
            images: productData['images'],
            withoutOffers: true);
      }
      List<Shop> shops = getShopsOffers(metaData: metaData);
      List<YoutubeVideo> youtubeVideos = getYutubeVideos(metaData: metaData);
      List<String> images = getGoogleImages(metaData: metaData);
      Reviews reviews = getReviews(productData: product);
      List<dynamic> relatedIds = productData['related_ids'];
      // dynamic historOfPricesHTML =
      //     await getHistorOfPricesHTML(productData['permalink']);
      String bestPriceURL = productData['external_url'];
      if (bestPriceURL.isEmpty) {
        bestPriceURL = getCheapestPrice(shops).offerLink;
      }

      product = Product(
          id: productData['id'],
          link: productData['permalink'],
          name: productData['name'],
          price: productData['price'],
          imageUrl: imageURL,
          description: productData['description'],
          shortDescription: productData['short_description'],
          shops: shops,
          youtubeVideos: youtubeVideos,
          images: images,
          reviews: reviews,
          relatedIds: relatedIds,
          bestPriceURL: bestPriceURL

          // historOfPricesHTML: historOfPricesHTML
          );
    } catch (_) {}

    return product;
  }

  // get main image URL
  String getMainImage({images, metaData, bool withoutOffers = false}) {
    String imageURL;
    try {
      if (withoutOffers) {
        imageURL = images[0]['src'];
      } else {
        imageURL = metaData
            .toList()
            .firstWhere((data) => data['key'] == '_cegg_data_Offer')['value']
            .values
            .toList()[0]['img'];
      }
    } catch (e) {
      imageURL = null;
    }
    return imageURL;
  }

  // shop offers
  List<Shop> getShopsOffers({metaData}) {
    List<Shop> shops = [];
    try {
      var shopsData = metaData
          .toList()
          .firstWhere((data) => data['key'] == '_cegg_data_Offer');
      for (var shopData in shopsData['value'].values.toList()) {
        try {
          shops.add(
            Shop(
                domain: shopData['domain'],
                price: shopData['price'].toString(),
                offerLink: shopData['url']),
          );
        } catch (e) {}
      }
    } catch (e) {}
    return shops;
  }

  // youtube videos
  List<YoutubeVideo> getYutubeVideos({metaData}) {
    List<YoutubeVideo> youtubeVideos = [];
    try {
      var youtubeVideosData = metaData
          .toList()
          .firstWhere((data) => data['key'] == '_cegg_data_Youtube');
      for (var video in youtubeVideosData['value'].values.toList()) {
        try {
          youtubeVideos.add(YoutubeVideo(
              url: video['url'],
              title: video['title'],
              description: video['description']));
        } catch (e) {}
      }
    } catch (e) {
      // print('outter 1 : ' + e.toString());
    }
    return youtubeVideos;
  }

  // Google images
  List<String> getGoogleImages({metaData}) {
    List<String> images = [];
    try {
      var googleImagesData = metaData
          .toList()
          .firstWhere((data) => data['key'] == '_cegg_data_GoogleImages');
      for (var image in googleImagesData['value'].values.toList()) {
        try {
          images.add(image['img']);
        } catch (e) {}
      }
    } catch (e) {
      // print('outter  2 :' + e.toString());
    }
    return images;
  }

  // Reviews
  Reviews getReviews({productData}) {
    Reviews reviews;
    try {
      reviews = Reviews(
          averageRating: productData['average_rating'],
          ratingCount: productData['rating_count']);
    } catch (e) {
      // print('outter  3' + e.toString());
      reviews = Reviews(averageRating: '0', ratingCount: 0);
    }
    return reviews != null
        ? reviews
        : Reviews(averageRating: '0', ratingCount: 0);
  }

  // Future<dynamic> getHistorOfPricesHTML(String productLink) async {
  //   dynamic historOfPricesHTML;
  //   try {
  //     http.Response response = await http.get(productLink);
  //     var html = parse(response.body)
  //         .querySelector('#section-woo-ce-pricehistory')
  //         .outerHtml;
  //     historOfPricesHTML = HtmlEditor.merageTwoTDs(html);
  //   } catch (e) {
  //     print('scrap error');
  //     print(e);
  //   }
  //   return historOfPricesHTML;
  // }

  // get lowest product price
  Shop getCheapestPrice(List<Shop> shops) {
    double min = double.infinity;
    int cheapestPriceIndex = 0;
    try {
      for (int index = 0; index < shops.length; index++) {
        if (double.parse(shops[index].price) < min) {
          min = double.parse(shops[index].price);
          cheapestPriceIndex = index;
        }
      }
    } catch (e) {
      print('get Cheapest Price Error:');
      print(e);
    }
    return shops.length > 0 ? shops[cheapestPriceIndex] : null;
  }
}
