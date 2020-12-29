import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/blog.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';
import 'package:qarinli/views/blog_screen/blog_screen.dart';
import 'package:qarinli/views/moda_offers/widgets/moda_category_card.dart';
import 'package:qarinli/views/sub_category_screen/sub_category_screen.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class ModaOffersScreen extends StatefulWidget {
  // final ScrollController scrollController;
  // ModaOffersScreen({this.scrollController});

  @override
  _ModaOffersScreenState createState() => _ModaOffersScreenState();
}

class _ModaOffersScreenState extends State<ModaOffersScreen> {
  int _selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      endDrawer: AppDrawer(),
      body: Consumer<MainModel>(
        builder: (context, model, chlild) {
          // _scrollController = _scrollControllerHomeTab;
          return ListView(
            // controller: widget.scrollController,
            children: [
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'مكانك النهائي للبحث عن اخر صيحات الموضة',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              Row(
                // crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      // model.getCurrentProducts(
                      //   pageNumber: 1,
                      //   categoryId: 799,
                      // );
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //     builder: (BuildContext context) {
                      //       return KidsScrren();
                      //     },
                      //   ),
                      // );
                      model.getCurrentProducts(
                        pageNumber: 1,
                        filter: Filter(tags: [], categories: [
                          Category(id: 2163, name: 'أزياء الأطفال')
                        ]),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProductsScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/moda/kids.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'أزياء الأطفال',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      model.getCurrentProducts(
                        pageNumber: 1,
                        filter: Filter(tags: [], categories: [
                          Category(id: 799, name: 'أزياء المرأه')
                        ]),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProductsScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/moda/women.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'أزياء المرأة',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      model.getCurrentProducts(
                        pageNumber: 1,
                        filter: Filter(tags: [], categories: [
                          Category(id: 798, name: 'أزياء الرجل')
                        ]),
                      );
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return ProductsScreen();
                          },
                        ),
                      );
                    },
                    child: Card(
                      margin: EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          Image.asset(
                            'assets/moda/man.png',
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                          ),
                          Text(
                            'أزياء الرجل',
                            style: TextStyle(fontSize: 18.0),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
              model.modaSubCategories.length > 0
                  ? Container(
                      margin: EdgeInsets.only(right: 15, top: 15.0),
                      child: Text(
                        // 'Sub Categories',
                        'الفئات الأساسية',
                        textDirection: TextDirection.rtl,
                        style: TextStyle(fontSize: 24),
                      ),
                    )
                  : SizedBox.shrink(),
              model.modaSubCategoriesIsloading
                  ? Spinner()
                  : model.modaSubCategories.length > 0
                      ? Directionality(
                          textDirection: TextDirection.rtl,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Container(
                              margin: EdgeInsets.only(right: 20),
                              child: RowBuilder(
                                itemCount: model.modaSubCategories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          model.currentCategory =
                                              model.modaSubCategories[index];
                                          model.getCurrentProducts(
                                            pageNumber: 1,
                                            filter: Filter(
                                                tags: [],
                                                categories: [
                                                  model.modaSubCategories[index]
                                                ]),
                                          );
                                          model.getSubCategories();

                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (BuildContext context) {
                                                return SubCategoryScreen();
                                              },
                                            ),
                                          );

                                          _selectedIndex = index;
                                        });
                                      },
                                      child: ModaCategoryCard(
                                        category:
                                            model.modaSubCategories[index],
                                        isSelected: _selectedIndex == index,
                                      ));
                                },
                              ),
                            ),
                          ),
                        )
                      : Spinner(),
              Container(
                margin: EdgeInsets.symmetric(vertical: 15.0),
                child: Center(
                  child: Text(
                    'نصائح الموضة',
                    style: TextStyle(fontSize: 22.0),
                  ),
                ),
              ),
              model.modaBlogsIsLoading
                  ? Spinner()
                  : Directionality(
                      textDirection: TextDirection.rtl,
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Container(
                          margin: EdgeInsets.all(20.0),
                          child: RowBuilder(
                            itemCount: model.modaBlogs.length,
                            itemBuilder: (BuildContext cintext, int index) {
                              Blog blog = model.modaBlogs[index];
                              return Container(
                                  constraints: BoxConstraints(
                                      minHeight: 170, maxHeight: 190),
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
                                    child: Card(
                                      child: Column(
                                        children: [
                                          blog.featuredImage != null
                                              ? FadeInImage(
                                                  width: 180.0,
                                                  // height: 120.0,
                                                  image:
                                                      CachedNetworkImageProvider(
                                                          blog.featuredImage),
                                                  placeholder: AssetImage(
                                                      'assets/placeholder_image.png'),
                                                )
                                              : SizedBox.shrink(),
                                          Container(
                                              width: 180.0,
                                              child: Text(
                                                blog.title,
                                                textAlign: TextAlign.center,
                                                textDirection:
                                                    TextDirection.rtl,
                                                style:
                                                    TextStyle(fontSize: 18.0),
                                              ))
                                        ],
                                      ),
                                    ),
                                  ));
                            },
                          ),
                        ),
                      ),
                    ),
              SizedBox(
                height: 100,
              ),
            ],
          );
        },
      ),
    );
  }
}
