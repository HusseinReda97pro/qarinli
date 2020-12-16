import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/blog.dart';
import 'package:qarinli/views/blogs_screen/widgets/blog_card.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class PopUpBlogsScreen extends StatefulWidget {
  final List<Blog> blogs;
  PopUpBlogsScreen({@required this.blogs});
  @override
  _PopUpBlogsScreenState createState() => _PopUpBlogsScreenState();
}

class _PopUpBlogsScreenState extends State<PopUpBlogsScreen> {
  int pageNamber = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: widget.blogs.length > 0
            ? ListView.builder(
                itemCount: widget.blogs.length + 1,
                itemBuilder: (BuildContext context, int index) {
                  if (index < widget.blogs.length) {
                    return BlogCard(blog: widget.blogs[index]);
                  } else {
                    return Container(
                      margin: EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50.0),
                              ),
                              height: 25,
                              minWidth: 15,
                              color: theme == AppTheme.LIGHT
                                  ? Palette.midBlue
                                  : Colors.white,
                              child: Icon(
                                Icons.arrow_left,
                                size: 18,
                                color: theme == AppTheme.LIGHT
                                    ? Colors.white
                                    : Palette.midBlue,
                              ),
                              onPressed: () async {
                                if (pageNamber > 1) {
                                  await model.getBlogs(page: pageNamber);

                                  setState(() {
                                    pageNamber -= 1;
                                  });
                                }
                              }),
                          SizedBox(
                            width: 4.0,
                          ),
                          FlatButton(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(25.0),
                              ),
                              height: 25,
                              minWidth: 15,
                              color: theme == AppTheme.LIGHT
                                  ? Palette.midBlue
                                  : Colors.white,
                              child: Icon(
                                Icons.arrow_right,
                                size: 18,
                                color: theme == AppTheme.LIGHT
                                    ? Colors.white
                                    : Palette.midBlue,
                              ),
                              onPressed: () async {
                                await model.getBlogs(page: pageNamber);

                                setState(() {
                                  pageNamber += 1;
                                });
                              }),
                        ],
                      ),
                    );
                  }
                })
            : Center(
                child: Text('لا توجد نتائج'),
              ),
      );
    });
  }
}
