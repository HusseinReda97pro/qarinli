import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/main.dart';
import 'package:qarinli/models/blog.dart';
import 'package:qarinli/views/blog_screen/blog_screen.dart';
import 'package:qarinli/views/blogs_screen/pop_up_blogs_screen.dart';
import 'package:qarinli/views/widgets/loading.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({this.blog});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return BlogScreen(
                blog: blog,
              );
            },
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 15.0),
        child: Card(
          color: AppThemeModel.isLight ? Colors.white : Colors.transparent,
          elevation: 2.0,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              blog.featuredImage != null
                  ? Center(
                      child: Stack(
                        children: [
                          blog.featuredImage != null
                              ? FadeInImage(
                                  // width: 60,
                                  // height: 60,
                                  image: CachedNetworkImageProvider(
                                      blog.featuredImage),
                                  placeholder: AssetImage(
                                      'assets/placeholder_image.png'),
                                )
                              : SizedBox.shrink(),
                          Positioned(
                            bottom: 15,
                            left: 5,
                            child: RowBuilder(
                              itemCount: blog.categories.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () async {
                                    loading(context, 'loading');
                                    List<Blog> blogs = await MyApp
                                        .mainModel.blogController
                                        .getBlogs(
                                            page: 1,
                                            categoryId:
                                                blog.categories[index].id);
                                    Navigator.pop(context);
                                    Navigator.push(context, MaterialPageRoute(
                                        builder: (BuildContext context) {
                                      return PopUpBlogsScreen(blogs: blogs);
                                    }));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(right: 15.0),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 6.0, vertical: 0.5),
                                    decoration: BoxDecoration(
                                      color: Palette.midBlue,
                                      shape: BoxShape.rectangle,
                                      borderRadius: new BorderRadius.all(
                                        Radius.circular(10.0),
                                      ),
                                    ),
                                    child: Text(
                                      blog.categories[index].name,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15.0),
                      child: RowBuilder(
                        itemCount: blog.categories.length,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                            onTap: () async {
                              loading(context, 'loading');
                              List<Blog> blogs =
                                  await MyApp.mainModel.blogController.getBlogs(
                                      page: 1,
                                      categoryId: blog.categories[index].id);
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) {
                                    return PopUpBlogsScreen(blogs: blogs);
                                  },
                                ),
                              );
                            },
                            child: Container(
                              margin: EdgeInsets.only(right: 15.0),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 6.0, vertical: 0.5),
                              decoration: BoxDecoration(
                                color: Palette.midBlue,
                                shape: BoxShape.rectangle,
                                borderRadius: new BorderRadius.all(
                                  Radius.circular(10.0),
                                ),
                              ),
                              child: Text(
                                blog.categories[index].name,
                                textAlign: TextAlign.center,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        },
                      ),
                    ),

              // Image.asset('assets/placeholder_image.png'),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 40),
                padding: EdgeInsets.only(top: 15.0),
                child: Text(
                  blog.title,
                  textDirection: TextDirection.rtl,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 24.0,
                      color: theme == AppTheme.LIGHT
                          ? Colors.black
                          : Theme.of(context).primaryColor),
                ),
              ),
              Container(
                margin: EdgeInsets.all(15.0),
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: Html(
                    data: blog.shortDiscription,
                    // style: {
                    //   "p": Style(
                    //     textAlign: TextAlign.center,
                    //   )
                    // },
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(left: 15.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return BlogScreen(
                            blog: blog,
                          );
                        },
                      ),
                    );
                  },
                  child: Text(
                    'المزيد',
                    style: TextStyle(
                        color: theme == AppTheme.LIGHT
                            ? Colors.black
                            : Palette.yellow),
                  ),
                ),
              ),
              SizedBox(
                height: 15.0,
              )
            ],
          ),
        ),
      ),
    );
  }
}
