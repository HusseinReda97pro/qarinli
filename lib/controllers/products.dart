import 'dart:convert';
import 'dart:io';

import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/product.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/shop.dart';

class ProductsController {
  // Get Products
  static Future<List<Product>> getProducts({int page, int categoryId}) async {
    print(categoryId);

    List<Product> products = [];
    try {
      var productsData;
      try {
        final http.Response response = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/products?page=$page&category=$categoryId',
            headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          productsData = responseBody;
        } else {
          return responseBody['message'];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var product in productsData) {
        String imageURL;
        List<Shop> shops = [];
        try {
          imageURL = product['meta_data']
              .toList()
              .firstWhere((data) => data['key'] == '_cegg_data_Offer')['value']
              .values
              .toList()[0]['img'];
        } catch (e) {
          imageURL = null;
          // print(e);
        }
        try {
          var shopsData = product['meta_data']
              .toList()
              .firstWhere((data) => data['key'] == '_cegg_data_Offer');
          for (var shopData in shopsData['value'].values.toList()) {
            try {
              shops.add(Shop(
                  domain: shopData['domain'],
                  price: shopData['price'].toString()));
            } catch (e) {
              print('ineer ' + e.toString());
              print(shopData);
              print('___________________________________');
            }
          }
        } catch (e) {
          print('outter ' + e.toString());
        }
        print(shops);
        products.add(Product(
            name: product['name'],
            price: product['price'],
            imageUrl: imageURL,
            description: product['description'],
            shortDescription: product['short_description'],
            shops: shops));
      }
    } catch (_) {}
    print(products.length);
    return products;
  }
}
