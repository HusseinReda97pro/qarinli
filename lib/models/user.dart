import 'package:flutter/material.dart';

class User {
  final String token;
  final String id;
  final String email;
  final String username;
  List<int> favoritesProducts;
  User(
      {@required this.token,
      @required this.id,
      @required this.username,
      @required this.email,
      this.favoritesProducts});
}
