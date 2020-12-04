import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/author.dart';
import 'package:qarinli/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/category.dart';

class BlogController {
  Future<List<Blog>> getBlogs({
    @required int page,
    int categoryId,
  }) async {
    List<Blog> blogs = [];
    try {
      var blogsData;
      try {
        http.Response response = await http.get(
            'https://www.qarinli.com/wp-json/wp/v2/posts?page=$page',
            headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          blogsData = responseBody;
        } else {
          return responseBody['message'];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var blogData in blogsData) {
        try {
          String id = blogData['id'].toString();
          // Author author = await getAuthorData(blogData['author'].toString());
          Author author = Author(id: blogData['author'].toString());

          //    String imageUrl;
          String link = blogData['link'];
          String title = blogData['title']['rendered'];
          String content = blogData['content']['rendered'];
          String shortDiscription = blogData['excerpt']['rendered'];
          // int views;
          DateTime date = DateTime.parse(blogData['date']);
          // List<dynamic> categories =
          //     await getCategoriesData(blogData['categories']);
          List<dynamic> categoriesIds = blogData['categories'];

          Blog blog = Blog(
            id: id,
            link: link,
            title: title,
            content: content,
            shortDiscription: shortDiscription,
            date: date,
            author: author,
            categoriesIds: categoriesIds,
            categories: [],
          );
          blogs.add(blog);
        } catch (_) {}
      }
    } catch (e) {
      print('blogs error');
      print(e);
    }

    return blogs;
  }

  Future<Author> getAuthorData(id) async {
    var authorData;
    Author author;
    try {
      http.Response response = await http.get(
          'https://www.qarinli.com/wp-json/wp/v2/users/$id',
          headers: <String, String>{'authorization': basicAuth});
      var responseBody = await json.decode(response.body);
      if (responseBody is List<dynamic> || responseBody['message'] == null) {
        authorData = responseBody;
      } else {
        return responseBody['message'];
      }
      String name = authorData['name'];
      String imageUrl;
      try {
        imageUrl = authorData['avatar_urls'].values.toList()[0].toString();
      } catch (_) {}
      author = Author(id: id, name: name, imageUrl: imageUrl);
    } on SocketException {
      throw Exception('No Internet connection.');
    }
    return author;
  }

// for getting categoies
  Future<List<Category>> getCategoriesData(ids) async {
    var categoryData;
    List<Category> categories = [];
    try {
      for (var id in ids) {
        try {
          http.Response response = await http.get(
              'https://www.qarinli.com/wp-json/wp/v2/categories/$id',
              headers: <String, String>{'authorization': basicAuth});

          var responseBody = await json.decode(response.body);
          if (responseBody is List<dynamic> ||
              responseBody['message'] == null) {
            categoryData = responseBody;
          } else {
            return responseBody['message'];
          }
          String name = categoryData['name'];
          Category category = Category(id: id, name: name);
          categories.add(category);
        } catch (e) {
          print('cat');
          print(e);
        }
      }
    } on SocketException {
      throw Exception('No Internet connection.');
    }
    return categories;
  }
}
