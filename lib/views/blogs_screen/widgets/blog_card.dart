import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/blog.dart';
import 'package:qarinli/views/blog_screen/blog_screen.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

class BlogCard extends StatelessWidget {
  final Blog blog;
  const BlogCard({this.blog});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            margin: EdgeInsets.symmetric(horizontal: 40),
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
              Container(
                margin: EdgeInsets.all(15.0),
                child: blog.author.imageUrl != null
                    ? ClipOval(
                        child: FadeInImage(
                          width: 40,
                          height: 40,
                          fit: BoxFit.cover,
                          image:
                              CachedNetworkImageProvider(blog.author.imageUrl),
                          placeholder:
                              AssetImage('assets/placeholder_image.png'),
                        ),
                      )
                    : ClipOval(
                        child: Image.asset(
                          'assets/placeholder_image.png',
                          width: 40,
                          height: 40,
                        ),
                      ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    blog.date.day.toString() +
                        '/' +
                        blog.date.month.toString() +
                        '/' +
                        blog.date.year.toString(),
                    style: TextStyle(
                        color: theme == AppTheme.LIGHT
                            ? Colors.black
                            : Palette.yellow),
                  ),
                  blog.author.name != null
                      ? Text(
                          'by ' + blog.author.name,
                          style: TextStyle(
                              color: theme == AppTheme.LIGHT
                                  ? Colors.black
                                  : Palette.yellow),
                        )
                      : SizedBox.shrink()
                ],
              )
            ],
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
            margin: EdgeInsets.symmetric(horizontal: 15.0),
            child: Row(
              children: [
                RowBuilder(
                  itemCount: blog.categories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        //TODO show all blogs for same category
                        print(blog.categories[index].id);
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
                Expanded(child: SizedBox()),
                Container(
                  // margin: EdgeInsets.only(right: 15.0),
                  child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return BlogScreen(
                              blog: blog,
                            );
                          }));
                        },
                        child: Text(
                          'المزيد',
                          style: TextStyle(
                              color: theme == AppTheme.LIGHT
                                  ? Colors.black
                                  : Palette.yellow),
                        ),
                      )),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
