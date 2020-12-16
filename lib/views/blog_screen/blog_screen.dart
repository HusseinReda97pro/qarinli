import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/blog.dart';
import 'package:qarinli/views/blogs_screen/pop_up_blogs_screen.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/loading.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';
import 'package:share/share.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../main.dart';

class BlogScreen extends StatelessWidget {
  final Blog blog;
  BlogScreen({this.blog});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      endDrawer: AppDrawer(),
      body: ListView(
        children: [
          blog.featuredImage != null
              ? Stack(
                  children: [
                    blog.featuredImage != null
                        ? FadeInImage(
                            // width: 60,
                            // height: 60,
                            image:
                                CachedNetworkImageProvider(blog.featuredImage),
                            placeholder:
                                AssetImage('assets/placeholder_image.png'),
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
                              List<Blog> blogs =
                                  await MyApp.mainModel.blogController.getBlogs(
                                      page: 1,
                                      categoryId: blog.categories[index].id);
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

          // : Image.asset('assets/placeholder_image.png'),
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
          Row(
            children: [
              // Container(
              //     margin: EdgeInsets.all(15.0),
              //     child: blog.author.imageUrl != null
              //         ? ClipOval(
              //             child: FadeInImage(
              //               width: 40,
              //               height: 40,
              //               fit: BoxFit.cover,
              //               image: CachedNetworkImageProvider(
              //                   blog.author.imageUrl),
              //               placeholder:
              //                   AssetImage('assets/placeholder_image.png'),
              //             ),
              //           )
              //         : SizedBox.shrink()
              //     // : ClipOval(
              //     //     child: Image.asset(
              //     //       'assets/placeholder_image.png',
              //     //       width: 40,
              //     //       height: 40,
              //     //     ),
              //     //   ),
              //     ),
              // Column(
              //   crossAxisAlignment: CrossAxisAlignment.start,
              //   children: [
              //     Text(
              //       blog.date.day.toString() +
              //           '/' +
              //           blog.date.month.toString() +
              //           '/' +
              //           blog.date.year.toString(),
              //       style: TextStyle(
              //           color: theme == AppTheme.LIGHT
              //               ? Colors.black
              //               : Palette.yellow),
              //     ),
              //     blog.author.name != null
              //         ? Text(
              //             'by ' + blog.author.name,
              //             style: TextStyle(
              //                 color: theme == AppTheme.LIGHT
              //                     ? Colors.black
              //                     : Palette.yellow),
              //           )
              //         : SizedBox.shrink()
              //   ],
              // ),
              Expanded(child: SizedBox()),
              Container(
                // margin: EdgeInsets.symmetric(horizontal: 30.0),
                // width: 8.0,
                child: IconButton(
                  color:
                      theme == AppTheme.LIGHT ? Colors.black : Palette.yellow,
                  padding: EdgeInsets.all(0),
                  icon: Icon(Icons.share),
                  onPressed: () {
                    Share.share(blog.link);
                  },
                ),
              ),
            ],
          ),
          Container(
            margin: EdgeInsets.all(15.0),
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Html(
                data: blog.content,
                onLinkTap: (link) async {
                  if (await canLaunch(link)) {
                    await launch(
                      link,
                      forceSafariVC: false,
                      forceWebView: false,
                    );
                  } else {}
                },
                // style: {
                //   "p": Style(
                //     textAlign: TextAlign.center,
                //   )
                // },
              ),
            ),
          ),
          SizedBox(
            height: 25,
          )
        ],
      ),
    );
  }
}
