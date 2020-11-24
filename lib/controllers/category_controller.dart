import 'dart:convert';
import 'dart:io';

import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/category.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  static Future<List<Category>> getcategories() async {
    List<Category> categories = [];

    try {
      var categoriesData;
      try {
        final http.Response response = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/products/categories?per_page=100',
            headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          categoriesData = responseBody;
        } else {
          return responseBody['message'];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var category in categoriesData) {
        String imageURL;
        try {
          imageURL = category['image']['src'];
        } catch (e) {
          imageURL = null;
          print(e);
        }
        categories.add(Category(
          id: category['id'],
          name: category['name'],
          imageUrl: imageURL,
        ));
      }
    } catch (_) {}
    return categories;
  }
}
