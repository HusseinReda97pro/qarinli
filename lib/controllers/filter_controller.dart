import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/attribute_terms.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/tag.dart';

class FilterController {
  Future<int> getMaxPrice({List<Category> cateories, List<Tag> tags}) async {
    String url = 'https://www.qarinli.com/wp-json/wc/v3/products?';

    if (tags != null) {
      if (tags.isNotEmpty) {
        String _tags = '';
        for (Tag tag in tags) {
          _tags += tag.id.toString() + ',';
        }
        url += '&category=$_tags';
      }
    }
    if (cateories != null) {
      if (cateories.isNotEmpty) {
        String cats = '';
        for (Category cat in cateories) {
          cats += cat.id.toString() + ',';
        }
        url += '&category=$cats';
      }
    }
    url += '&orderby=price&per_page=1';
    try {
      http.Response response = await http
          .get(url, headers: <String, String>{'authorization': basicAuth});

      var responseBody = await json.decode(response.body);

      // print(response.headers);
      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        int price =
            double.parse(responseBody[0]['price'].toString()).ceil().toInt();
        return price;
      } else {
        return 50000;
      }
    } catch (_) {
      return 50000;
    }
  }

  Future<List<AttributeTermas>> getCurrentAttributeTermas(
      {@required String attributeId}) async {
    List<AttributeTermas> attributeTermas = [];
    try {
      String url =
          'https://www.qarinli.com/wp-json/wc/v3/products/attributes/$attributeId/terms?hide_empty=true';
      http.Response response = await http
          .get(url, headers: <String, String>{'authorization': basicAuth});

      var responseBody = await json.decode(response.body);
      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        for (var term in responseBody) {
          try {
            attributeTermas.add(AttributeTermas(
                id: term['id'].toString(),
                name: term['name'],
                slug: term['slug'],
                count: term['count'],
                isSelected: false));
          } catch (e) {
            print(e);
          }
        }
      }
    } catch (e) {
      print(e);
    }
    return attributeTermas;
  }
}
