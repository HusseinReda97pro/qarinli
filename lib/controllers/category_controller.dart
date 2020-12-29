import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/tag.dart';

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

  Future<List<Category>> getsubCategories({parentId, String exclude}) async {
    List<Category> categories = [];

    try {
      var categoriesData;
      String url =
          'https://www.qarinli.com/wp-json/wc/v3/products/categories?parent=$parentId';
      if (exclude != null) {
        url += '&exclude=$exclude';
      }
      try {
        final http.Response response = await http
            .get(url, headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          categoriesData = responseBody;
        } else {
          return responseBody['message'];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }
      String imageUrl;

      for (var category in categoriesData) {
        try {
          imageUrl = category['image']['src'];
        } catch (_) {}
        categories.add(Category(
            id: category['id'],
            name: category['name'],
            count: category['count'],
            imageUrl: imageUrl));
      }
    } catch (_) {}
    return categories;
  }

  Future<List<Category>> getFilterCategories({@required categoriesIds}) async {
    List<Category> categories = [];
    String cats = '';
    for (int categoryId in categoriesIds) {
      cats += categoryId.toString() + ',';
    }
    try {
      var categoriesData;
      try {
        final http.Response response = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/products/categories?include=$cats&per_page=100',
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
      String imageUrl;
      for (var category in categoriesData) {
        try {
          imageUrl = category['image']['src'];
        } catch (_) {}
        categories.add(
          Category(
              id: category['id'],
              name: category['name'],
              count: category['count'],
              imageUrl: imageUrl,
              isSelected: false),
        );
      }
    } catch (_) {}
    return categories;
  }

  Future<List<Tag>> getFilterTags({@required tagIds}) async {
    List<Tag> tags = [];
    String _tags = '';
    for (int tagId in tagIds) {
      _tags += tagId.toString() + ',';
    }
    try {
      var tagsData;
      try {
        final http.Response response = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/products/tags?include=$_tags&per_page=100',
            headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          tagsData = responseBody;
        } else {
          return responseBody['message'];
        }
      } catch (_) {}
      for (var tag in tagsData) {
        tags.add(
          Tag(
            id: tag['id'],
            name: tag['name'],
            count: tag['count'],
          ),
        );
      }
    } catch (_) {}
    return tags;
  }
}
