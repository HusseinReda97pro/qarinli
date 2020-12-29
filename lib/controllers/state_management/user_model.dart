import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:qarinli/config/api_authorization.dart';
import 'package:qarinli/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

mixin UserModel on ChangeNotifier {
  User currentUser;
  //  = User(
  //     token: 's',
  //     id: '67',
  //     email: "test405@test.com",
  //     username: "Test 405",
  //     favoritesProducts: [527126]);
  Future<String> signup({
    @required username,
    @required email,
    @required password,
  }) async {
    username = username.replaceAll(new RegExp(r'‎'), '');
    String url = 'https://www.qarinli.com/wp-json/wc/v3/customers/?email=' +
        email.toString() +
        '&username=' +
        username.toString() +
        '&password=' +
        password.toString();
    // Uri urlLink = Uri.parse(url);
    print(url.toString());
    String message;
    final http.Response response =
        await http.post(url, headers: <String, String>{
      'authorization': basicAuth,
    });
    var responseBody = await json.decode(response.body);

    if (responseBody is List<dynamic> || responseBody['message'] == null) {
      // user = User(
      //     id: responseBody['id'],
      //     email: responseBody['email'],
      //     username: responseBody['username']);
      login(email: email, password: password);
      message = 'successfully';
    } else {
      message = responseBody['message'];
      print(message);
    }
    return message;
  }

  Future<String> login({
    @required email,
    @required password,
  }) async {
    String message;
    final http.Response response =
        await http.post('https://www.qarinli.com/wp-json/jwt-auth/v1/token',
            // headers: <String, String>{"Content-Type": "application/json"},
            body: {"username": email, 'password': password});
    var responseBody = await json.decode(response.body);
    if (responseBody is List<dynamic> || responseBody['success'] == true) {
      if (responseBody['success']) {
        http.Response favResponse = await http.get(
            'https://www.qarinli.com/wp-json/wc/v3/customers/${responseBody['data']['id'].toString()}',
            headers: <String, String>{'authorization': basicAuth});
        var favResponseBody = await json.decode(favResponse.body);
        List<int> favoritesProducts =
            getFavorites(favResponseBody['meta_data']);
        currentUser = User(
            token: responseBody['data']['token'],
            id: responseBody['data']['id'].toString(),
            email: responseBody['data']['email'],
            username: responseBody['data']['displayName'],
            favoritesProducts: favoritesProducts);
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.setString("email", email);
        prefs.setString("username", responseBody['data']['displayName']);
        prefs.setString("password", password);
        prefs.setString("id", responseBody['data']['id'].toString());
        prefs.setString("token", responseBody['data']['token']);

        message = 'successfully';
      } else {
        message = responseBody['message'];
      }
    } else {
      message = responseBody['message'];
    }
    return message;
  }

  Future<void> autoLogin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String email = prefs.getString("email");
    final String password = prefs.getString("password");
    if (email != null && password != null) {
      login(email: email, password: password);
    }
  }

  Future<bool> logout() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      currentUser = null;
      prefs.remove('email');
      prefs.remove('username');
      prefs.remove('password');
      prefs.remove('id');
      prefs.remove('token');
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> addFavorite({@required productId}) async {
    try {
      currentUser.favoritesProducts.add(productId);
      notifyListeners();
      Map<String, List<Map>> favMap = {
        "meta_data": [
          {
            "key": "_wished_posts",
            "value": generatFavoritesMap(currentUser.favoritesProducts)
          }
        ]
      };
      await http.put(
          'https://www.qarinli.com/wp-json/wc/v3/customers/${currentUser.id}',
          headers: <String, String>{
            'authorization': basicAuth,
            "Content-Type": "application/json"
          },
          body: json.encode(favMap));
      // print(response.body);
      // print(json.encode(favMap));
      return true;
    } catch (e) {
      // print(e);
      currentUser.favoritesProducts.remove(productId);
      notifyListeners();
      return false;
    }
  }

  Future<bool> removeFavorite({@required productId}) async {
    try {
      currentUser.favoritesProducts.remove(productId);
      notifyListeners();
      Map<String, List<Map>> favMap = {
        "meta_data": [
          {
            "key": "_wished_posts",
            "value": generatFavoritesMap(currentUser.favoritesProducts)
          }
        ]
      };
      await http.put(
          'https://www.qarinli.com/wp-json/wc/v3/customers/${currentUser.id}',
          headers: <String, String>{
            'authorization': basicAuth,
            "Content-Type": "application/json"
          },
          body: json.encode(favMap));
      // print(response.body);
      // print(json.encode(favMap));
      return true;
    } catch (e) {
      // print(e);
      currentUser.favoritesProducts.add(productId);
      notifyListeners();
      return false;
    }
  }

  Map generatFavoritesMap(List<int> favs) {
    Map favMap = {};
    for (int fav in favs) {
      favMap["post-" + fav.toString()] = fav;
    }
    return favMap;
  }

  String generateFavoritesList() {
    String favs = '';
    for (int fav in currentUser.favoritesProducts) {
      favs += fav.toString() + ',';
    }
    return favs;
  }

  List<int> getFavorites(metaData) {
    List<int> favs = [];
    try {
      var favsData = metaData
          .toList()
          .firstWhere((data) => data['key'] == '_wished_posts');
      if (favsData != null) {
        for (var fav in favsData['value'].values.toList()) {
          try {
            favs.add(fav);
          } catch (_) {}
        }
      }
    } catch (_) {}
    return favs;
  }
}
