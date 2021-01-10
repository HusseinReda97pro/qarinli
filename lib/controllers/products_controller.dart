import 'dart:convert';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/attribute_terms.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/fetchedProducts.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/product_attribute.dart';
import 'package:qarinli/models/shop.dart';
import 'package:qarinli/models/tag.dart';
import 'package:qarinli/models/youtube_video.dart';

class ProductsController {
  Future<FetchedProducts> getProducts(
      {Filter filter, String favorites, int page, String relateds}) async {
    http.Response response;
    try {
      String url = 'https://www.qarinli.com/wp-json/wc/v3/products?';
      // 'https://www.qarinli.com/wp-json/wc/v3/products?tag_exclude=2164';
      //Add tag
      if (filter?.tags != null) {
        if (filter.tags.isNotEmpty) {
          String tags = '';
          for (Tag tag in filter.tags) {
            tags += tag.id.toString() + ',';
          }
          url += '&tag=$tags';
        }
      }
      //Add Category
      if (filter?.categories != null) {
        if (filter.categories.isNotEmpty) {
          String cats = '';
          for (Category cat in filter.categories) {
            cats += cat.id.toString() + ',';
          }
          url += '&category=$cats';
        }
      }
      //Add featured
      if (filter?.featured != null) {
        url += '&featured=${filter.featured}';
      }
      //Search
      if (filter?.search != null) {
        url += '&search=${filter.search}';
      }
      //favorites
      if (favorites != null) {
        url += '&include=$favorites';
      }
      if (relateds != null) {
        url += '&include=$relateds';
      }
      if (filter?.attribute != null && filter?.attributeTermas != null) {
        String attributeTerms = '';
        for (AttributeTermas term in filter.attributeTermas) {
          if (term.isSelected) {
            attributeTerms += term.id.toString() + ',';
          }
        }
        url +=
            '&attribute=${filter.attribute.slug}&attribute_term=$attributeTerms';
      }
      //Add page and status
      if (favorites == null && relateds == null) {
        url += '&status=publish&page=$page';
        url += '&min_price=${filter.minPrice}&max_price=${filter.maxPrice + 1}';
      }

      print('URL: ' + url);

      response = await http
          .get(url, headers: <String, String>{'authorization': basicAuth});
    } catch (e) {
      print('get Products Error: ' + e.toString());
      return FetchedProducts(products: [], totalPages: 0, totalResults: 0);
    }
    return extractProductData(response);
  }

  Future<FetchedProducts> extractProductData(response) async {
    List<Product> products = [];
    int totalPages = 0;
    int totalResults = 0;
    var productsData;

    try {
      totalResults = int.parse(response.headers['x-wp-total']);
    } catch (_) {}
    try {
      totalPages = int.parse(response.headers['x-wp-totalpages']);
    } catch (_) {}

    var responseBody = await json.decode(response.body);

    try {
      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        productsData = responseBody;
        // if (moda) {
        //   var responseBody_2 = await json.decode(response_2.body);
        //   productsData += responseBody_2;
        //   // print(productsData);
        // }
      } else {
        return FetchedProducts(
            products: [], totalPages: totalPages, totalResults: totalResults);
      }
    } catch (_) {
      return FetchedProducts(
          products: [], totalPages: totalPages, totalResults: totalResults);
    }

    for (var product in productsData) {
      try {
        var metaData = product['meta_data'];
        String imageURL =
            getMainImage(metaData: metaData, images: product['images']);
        if (imageURL == null) {
          imageURL =
              getMainImage(metaData: metaData, images: product['images']);
        }

        List<Shop> shops = getShopsOffers(metaData: metaData);
        List<YoutubeVideo> youtubeVideos = getYutubeVideos(metaData: metaData);
        List<String> images = [];
        if (product['images'].length > 0) {
          for (var image in product['images']) {
            try {
              images.add(image['src']);
            } catch (e) {
              print('**************************');
              print(e);
            }
          }
        } else {
          images = getGoogleImages(metaData: metaData);
        }
        String averageRating;
        int ratingCount;
        try {
          averageRating = product['average_rating'];
          ratingCount = product['rating_count'];
        } catch (e) {
          averageRating = '0';
          ratingCount = 0;
        }

        List<dynamic> relatedIds = product['related_ids'];
        String bestPriceURL = product['external_url'];
        if (bestPriceURL.isEmpty && shops.length > 0) {
          bestPriceURL = getCheapestPrice(shops).offerLink;
        }
        if (imageURL == null) {
          imageURL = images[0];
        }

        // tags
        List<Tag> tags = [];
        try {
          for (var tag in product['tags']) {
            tags.add(Tag(id: tag['id'], name: tag['name'], count: 0));
          }
        } catch (_) {}
        // attributes
        List<ProductAttribute> attributes = [];
        try {
          for (var attribute in product['attributes']) {
            try {
              ProductAttribute productAttribute = ProductAttribute(
                id: attribute['id'],
                name: attribute['name'],
                position: attribute['position'],
                isVisible: attribute['visible'],
                isVariation: attribute['variation'],
                options: attribute['options'].cast<String>().toList(),
              );
              if (productAttribute.isVisible) {
                attributes.add(productAttribute);
              }
            } catch (e) {
              print(e);
            }
          }
        } catch (_) {}
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
          reviewAverageRating: averageRating,
          reviewRatingCount: ratingCount,
          relatedIds: relatedIds,
          bestPriceURL: bestPriceURL,
          tags: tags,
          attributes: attributes,
        ));
      } catch (_) {}
    }

    return FetchedProducts(
        products: products, totalPages: totalPages, totalResults: totalResults);
  }

  // // get single product
  // Future<Product> getProduct(
  //     {String productId, bool withoutOffers = false}) async {
  //   Product product;
  //   String url = 'https://www.qarinli.com/wp-json/wc/v3/products/$productId';

  //   try {
  //     var productData;
  //     try {
  //       final http.Response response = await http
  //           .get(url, headers: <String, String>{'authorization': basicAuth});
  //       var responseBody = await json.decode(response.body);
  //       if (responseBody is List<dynamic> || responseBody['message'] == null) {
  //         productData = responseBody;
  //       } else {
  //         return responseBody['message'];
  //       }
  //     } on SocketException {
  //       throw Exception('No Internet connection.');
  //     }

  //     // print(productData);

  //     var metaData = productData['meta_data'];
  //     String imageURL =
  //         getMainImage(metaData: metaData, images: productData['images']);
  //     if (imageURL == null) {
  //       imageURL =
  //           getMainImage(metaData: metaData, images: productData['images']);
  //     }
  //     List<Shop> shops = getShopsOffers(metaData: metaData);
  //     List<YoutubeVideo> youtubeVideos = getYutubeVideos(metaData: metaData);
  //     List<String> images = getGoogleImages(metaData: metaData);
  //     String averageRating;
  //     int ratingCount;
  //     try {
  //       averageRating = productData['average_rating'];
  //       ratingCount = productData['rating_count'];
  //     } catch (e) {
  //       averageRating = '0';
  //       ratingCount = 0;
  //     }
  //     List<dynamic> relatedIds = productData['related_ids'];
  //     // dynamic historOfPricesHTML =
  //     //     await getHistorOfPricesHTML(productData['permalink']);
  //     String bestPriceURL = productData['external_url'];
  //     if (bestPriceURL.isEmpty) {
  //       bestPriceURL = getCheapestPrice(shops).offerLink;
  //     }
  //     product = Product(
  //         id: productData['id'],
  //         link: productData['permalink'],
  //         name: productData['name'],
  //         price: productData['price'],
  //         imageUrl: imageURL,
  //         description: productData['description'],
  //         shortDescription: productData['short_description'],
  //         shops: shops,
  //         youtubeVideos: youtubeVideos,
  //         images: images,
  //         reviewAverageRating: averageRating,
  //         reviewRatingCount: ratingCount,
  //         relatedIds: relatedIds,
  //         bestPriceURL: bestPriceURL

  //         // historOfPricesHTML: historOfPricesHTML
  //         );
  //   } catch (_) {}

  //   return product;
  // }

  // get main image URL
  String getMainImage({images, metaData}) {
    String imageURL;
    try {
      if (images.length > 0) {
        imageURL = images[0]['src'];
      } else {
        imageURL = metaData
            .toList()
            .firstWhere((data) => data['key'] == '_cegg_data_Offer')['value']
            .values
            .toList()[0]['img'];
      }
    } catch (e) {
      print('Error from image');
      print(e);
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
        } catch (_) {}
      }
    } catch (_) {}
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
        } catch (_) {}
      }
    } catch (_) {}
    return images;
  }

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
    } catch (_) {}
    return shops.length > 0 ? shops[cheapestPriceIndex] : null;
  }
}
