import 'package:qarinli/models/author.dart';
import 'package:qarinli/models/category.dart';

class Blog {
  final String id;
  final Author author;
  final String imageUrl;
  final String link;
  final String title;
  final String content;
  final String shortDiscription;
  final int views;
  final DateTime date;
  final List<dynamic> categoriesIds;
  List<Category> categories;

  Blog(
      {this.author,
      this.imageUrl,
      this.categoriesIds,
      this.categories,
      this.id,
      this.link,
      this.title,
      this.content,
      this.shortDiscription,
      this.views,
      this.date});
}
