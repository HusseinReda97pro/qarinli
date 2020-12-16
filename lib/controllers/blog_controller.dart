import 'dart:convert';
import 'dart:io';

import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/author.dart';
import 'package:qarinli/models/blog.dart';
import 'package:http/http.dart' as http;
import 'package:qarinli/models/category.dart';

class BlogController {
  Future<List<Blog>> getBlogs({
    int page,
    int categoryId,
    bool moda = false,
  }) async {
    List<Blog> blogs = [];
    try {
      var blogsData;
      try {
        String url;
        if (moda) {
          url =
              'https://www.qarinli.com/wp-json/wp/v2/posts?_embed&categories=1370&per_page=3';
        } else {
          if (categoryId != null) {
            url =
                'https://www.qarinli.com/wp-json/wp/v2/posts?_embed&page=$page&categories=$categoryId';
          } else {
            url =
                'https://www.qarinli.com/wp-json/wp/v2/posts?_embed&page=$page';
          }
        }
        http.Response response = await http
            .get(url, headers: <String, String>{'authorization': basicAuth});
        var responseBody = await json.decode(response.body);
        if (responseBody is List<dynamic> || responseBody['message'] == null) {
          blogsData = responseBody;
        } else {
          print(responseBody['message']);
          return [];
        }
      } on SocketException {
        throw Exception('No Internet connection.');
      }

      for (var blogData in blogsData) {
        try {
          String id = blogData['id'].toString();
          // Author author = await getAuthorData(blogData['author'].toString());
          String name;
          try {
            name = blogData['_embedded']['author'][0]['name'];
          } catch (e) {
            name = '';
          }
          String authorImageUrl;
          try {
            authorImageUrl =
                blogData['_embedded']['author'][0]['avatar_urls']['96'];
          } catch (_) {}
          Author author = Author(
            id: blogData['author'].toString(),
            name: name,
            imageUrl: authorImageUrl,
          );
          String featuredImage;
          try {
            featuredImage =
                blogData['_embedded']['wp:featuredmedia'][0]['source_url'];
          } catch (_) {}

          //    String imageUrl;
          String link = blogData['link'];
          String title = blogData['title']['rendered'];
          String content = blogData['content']['rendered'];
          String shortDiscription = blogData['excerpt']['rendered'];
          // int views;
          DateTime date = DateTime.parse(blogData['date']);
          List<Category> categories = [];
          try {
            for (var cat in blogData['_embedded']['wp:term'][0]) {
              try {
                categories.add(Category(id: cat['id'], name: cat['name']));
              } catch (_) {}
            }
          } catch (_) {}
          // List<dynamic> categoriesIds = blogData['categories'];

          Blog blog = Blog(
            id: id,
            link: link,
            featuredImage: featuredImage,
            title: title,
            content: content,
            shortDiscription: shortDiscription,
            date: date,
            author: author,
            categories: categories,
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

  // Future<Author> getAuthorData(id) async {
  //   var authorData;
  //   Author author;
  //   try {
  //     http.Response response = await http.get(
  //         'https://www.qarinli.com/wp-json/wp/v2/users/$id',
  //         headers: <String, String>{'authorization': basicAuth});
  //     var responseBody = await json.decode(response.body);
  //     if (responseBody is List<dynamic> || responseBody['message'] == null) {
  //       authorData = responseBody;
  //     } else {
  //       return responseBody['message'];
  //     }
  //     String name = authorData['name'];
  //     String imageUrl;
  //     try {
  //       imageUrl = authorData['avatar_urls'].values.toList()[0].toString();
  //     } catch (_) {}
  //     author = Author(id: id, name: name, imageUrl: imageUrl);
  //   } on SocketException {
  //     throw Exception('No Internet connection.');
  //   }
  //   return author;
  // }

// for getting categoies
  // Future<List<Category>> getCategoriesData(ids) async {
  //   var categoryData;
  //   List<Category> categories = [];
  //   try {
  //     for (var id in ids) {
  //       try {
  //         http.Response response = await http.get(
  //             'https://www.qarinli.com/wp-json/wp/v2/categories/$id',
  //             headers: <String, String>{'authorization': basicAuth});

  //         var responseBody = await json.decode(response.body);
  //         if (responseBody is List<dynamic> ||
  //             responseBody['message'] == null) {
  //           categoryData = responseBody;
  //         } else {
  //           return responseBody['message'];
  //         }
  //         String name = categoryData['name'];
  //         Category category = Category(id: id, name: name);
  //         categories.add(category);
  //       } catch (e) {
  //         print('cat');
  //         print(e);
  //       }
  //     }
  //   } on SocketException {
  //     throw Exception('No Internet connection.');
  //   }
  //   return categories;
  // }
}
