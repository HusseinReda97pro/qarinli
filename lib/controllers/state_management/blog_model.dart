import 'package:flutter/cupertino.dart';
import 'package:qarinli/controllers/blog_controller.dart';
import 'package:qarinli/models/blog.dart';

mixin BlogModel on ChangeNotifier {
  BlogController blogController = BlogController();
  List<Blog> blogs = [];
  bool blogsIsLoading;
  Future<void> getBlogs({@required int page, int categoryId}) async {
    blogsIsLoading = true;
    notifyListeners();
    blogs.clear();
    blogs = await blogController.getBlogs(page: page, categoryId: categoryId);
    blogsIsLoading = false;
    notifyListeners();
    // try {
    //   for (Blog blog in blogs) {
    //     Author author = await blogController.getAuthorData(blog.author.id);
    //     blog.author.name = author.name;
    //     blog.author.imageUrl = author.imageUrl;
    //     notifyListeners();
    //     List<dynamic> categories =
    //         await blogController.getCategoriesData(blog.categoriesIds);
    //     blog.categories = categories;
    //     notifyListeners();
    //   }
    // } catch (_) {}
  }

  List<Blog> modaBlogs = [];
  bool modaBlogsIsLoading = false;
  Future<void> getModaBlogs() async {
    modaBlogsIsLoading = true;
    notifyListeners();
    blogs.clear();
    modaBlogs = await blogController.getBlogs(moda: true);
    modaBlogsIsLoading = false;
    notifyListeners();
  }
}
