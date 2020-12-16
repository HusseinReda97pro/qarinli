import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/blogs_screen/widgets/blog_card.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class BlogsScreen extends StatefulWidget {
  final int categoryId;
  BlogsScreen({this.categoryId});
  @override
  _BlogsScreenState createState() => _BlogsScreenState();
}

class _BlogsScreenState extends State<BlogsScreen> {
  int pageNamber = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: model.blogsIsLoading
            ?
            //  Directionality(
            //     textDirection: TextDirection.rtl,
            //     child: ListSkeleton(
            //       style: SkeletonStyle(
            //         theme: SkeletonTheme.Light,
            //         backgroundColor: theme == AppTheme.LIGHT
            //             ? Palette.lightGrey
            //             : Palette.drakModeBackground,
            //         isShowAvatar: false,
            //         barCount: 3,
            //         colors: [
            //           Color(0xffcccccc),
            //           Palette.midBlue,
            //           Color(0xff333333)
            //         ],
            //         isAnimation: true,
            //       ),
            //     ),
            //   )
            Spinner()
            : model.blogs.length > 0
                ? ListView.builder(
                    itemCount: model.blogs.length + 1,
                    itemBuilder: (BuildContext context, int index) {
                      if (index < model.blogs.length) {
                        return BlogCard(blog: model.blogs[index]);
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
                                      await model.getBlogs(
                                          page: pageNamber,
                                          categoryId: widget.categoryId);

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
                                    await model.getBlogs(
                                        page: pageNamber,
                                        categoryId: widget.categoryId);

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
