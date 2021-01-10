import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/top_categories/widgets/sub_category_card.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/rounded_button.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class SubCategoryScreen extends StatefulWidget {
  @override
  _SubCategoryScreenState createState() => _SubCategoryScreenState();
}

class _SubCategoryScreenState extends State<SubCategoryScreen> {
  int _currentPageNamber = 1;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: model.currentProductsIsLoading &&
                model.currentCategory.subCategories != null
            ? Spinner()
            : ListView(
                children: [
                  Center(
                    child: Text(
                      model.currentCategory.name,
                      style: TextStyle(fontSize: 24.0),
                    ),
                  ),
                  model.currentCategory.subCategories != null
                      ? model.currentCategory.subCategories.length > 0
                          ? Container(
                              margin: EdgeInsets.only(left: 15, top: 15.0),
                              child: Text(
                                // 'Sub Categories',
                                'الفئات الفرعية',
                                textDirection: TextDirection.rtl,
                                style: TextStyle(fontSize: 24),
                              ),
                            )
                          : SizedBox.shrink()
                      : SizedBox.shrink(),
                  model.currentCategory.subCategories != null
                      ? model.currentCategory.subCategories.length > 0
                          ? Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: ColumnBuilder(
                                itemCount:
                                    model.currentCategory.subCategories.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return SubCategoryCard(
                                    category: model
                                        .currentCategory.subCategories[index],
                                    isSubcategoryScreen: true,
                                  );
                                },
                              ),
                            )
                          : SizedBox.shrink()
                      // : Spinner(),

                      : SizedBox.shrink(),
                  model.currentProducts.length > 0
                      ? Container(
                          margin: EdgeInsets.only(left: 15, top: 15.0),
                          child: Text(
                            // 'Complete Catalogue',
                            'كتالوج المنتجات',
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 24),
                          ),
                        )
                      : SizedBox.shrink(),
                  // model.currentProductsIsLoading
                  //     ? Spinner()
                  //     : model.currentProducts.length > 0
                  //         ? ColumnBuilder(
                  //             itemCount: model.currentProducts.length + 1,
                  //             itemBuilder: (context, index) {
                  //               if (index < model.currentProducts.length) {
                  //                 return ProductCard(
                  //                     product: model.currentProducts[index]);
                  //               } else {
                  //                 return Container(
                  //                   margin: EdgeInsets.symmetric(horizontal: 20),
                  //                   child: Row(
                  //                     mainAxisAlignment: MainAxisAlignment.center,
                  //                     children: [
                  //                       FlatButton(
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(50.0),
                  //                           ),
                  //                           height: 25,
                  //                           minWidth: 15,
                  //                           color: AppThemeModel.isLight()
                  //                               ? Palette.midBlue
                  //                               : Colors.white,
                  //                           child: Icon(
                  //                             Icons.arrow_left,
                  //                             size: 18,
                  //                             color: AppThemeModel.isLight()
                  //                                 ? Colors.white
                  //                                 : Palette.midBlue,
                  //                           ),
                  //                           onPressed: () async {
                  //                             if (pageNamber > 1) {
                  //                               model.getCurrentProducts(
                  //                                 pageNumber: pageNamber + 1,
                  //                                 categoryId:
                  //                                     model.currentCategory.id,
                  //                               );
                  //                               setState(() {
                  //                                 pageNamber += 1;
                  //                               });
                  //                             }
                  //                           }),
                  //                       SizedBox(
                  //                         width: 4.0,
                  //                       ),
                  //                       FlatButton(
                  //                           shape: RoundedRectangleBorder(
                  //                             borderRadius:
                  //                                 BorderRadius.circular(25.0),
                  //                           ),
                  //                           height: 25,
                  //                           minWidth: 15,
                  //                           color: theme == AppTheme.LIGHT
                  //                               ? Palette.midBlue
                  //                               : Colors.white,
                  //                           child: Icon(
                  //                             Icons.arrow_right,
                  //                             size: 18,
                  //                             color: theme == AppTheme.LIGHT
                  //                                 ? Colors.white
                  //                                 : Palette.midBlue,
                  //                           ),
                  //                           onPressed: () async {
                  //                             model.getCurrentProducts(
                  //                                 pageNumber: pageNamber + 1,
                  //                                 categoryId:
                  //                                     model.currentCategory.id);
                  //                             setState(() {
                  //                               pageNamber += 1;
                  //                             });
                  //                           }),
                  //                     ],
                  //                   ),
                  //                 );
                  //               }
                  //             },
                  //           )
                  //         : Center(
                  //             child: Text('لا توجد نتائج'),
                  //           ),
                  model.currentProductsIsLoading
                      ? Spinner()
                      : model.currentProducts.length > 0
                          ? ColumnBuilder(
                              itemCount: model.currentProducts.length + 2,
                              itemBuilder: (context, index) {
                                if (index == 0) {
                                  return Row(
                                    children: [
                                      Expanded(child: SizedBox()),
                                      Directionality(
                                        textDirection: TextDirection.rtl,
                                        child: Container(
                                          margin: EdgeInsets.symmetric(
                                              horizontal: 15.0),
                                          child: Text(
                                            model.currentTotalResults
                                                    .toString() +
                                                ' نتيجة',
                                            style: TextStyle(
                                                fontSize: 16.0,
                                                color: AppThemeModel.isLight
                                                    ? Palette.black
                                                    : Palette.yellow),
                                          ),
                                        ),
                                      )
                                    ],
                                  );
                                }
                                if (index < model.currentProducts.length + 1) {
                                  return ProductCard(
                                      product:
                                          model.currentProducts[index - 1]);
                                } else {
                                  return Container(
                                    margin:
                                        EdgeInsets.symmetric(horizontal: 20),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        _currentPageNamber > 1
                                            ? FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          50.0),
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
                                                  if (_currentPageNamber > 1) {
                                                    model.getCurrentProducts(
                                                      pageNumber:
                                                          _currentPageNamber -
                                                              1,
                                                      filter: Filter(
                                                          tags: [],
                                                          categories: [
                                                            model
                                                                .currentCategory
                                                          ]),
                                                    );
                                                    setState(() {
                                                      _currentPageNamber -= 1;
                                                    });
                                                  }
                                                })
                                            : SizedBox.shrink(),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        RoundedButton(
                                          onPressed: () async {
                                            model.getCurrentProducts(
                                              pageNumber: 1,
                                              filter: Filter(
                                                  tags: [],
                                                  categories: [
                                                    model.currentCategory
                                                  ]),
                                            );
                                            setState(() {
                                              _currentPageNamber = 1;
                                            });
                                          },
                                          title: '1',
                                          isSelceted: _currentPageNamber == 1,
                                        ),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        model.currentTotalpages > 2
                                            ? Container(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.3,
                                                height: 25.0,
                                                child:
                                                    // SingleChildScrollView(
                                                    //   scrollDirection: Axis.horizontal,
                                                    //   child:
                                                    // RowBuilder(
                                                    Row(children: [
                                                  Expanded(
                                                    child: ListView.builder(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      itemCount: model
                                                              .currentTotalpages -
                                                          2,
                                                      itemBuilder:
                                                          (BuildContext context,
                                                              int index) {
                                                        return Container(
                                                          margin: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      3.0),
                                                          child: RoundedButton(
                                                            onPressed:
                                                                () async {
                                                              model
                                                                  .getCurrentProducts(
                                                                pageNumber:
                                                                    (index + 2),
                                                                filter: Filter(
                                                                    tags: [],
                                                                    categories: [
                                                                      model
                                                                          .currentCategory
                                                                    ]),
                                                              );
                                                              setState(() {
                                                                _currentPageNamber =
                                                                    (index + 2);
                                                              });
                                                            },
                                                            title: (index + 2)
                                                                .toString(),
                                                            isSelceted:
                                                                _currentPageNamber ==
                                                                    (index + 2),
                                                          ),
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ]),
                                                // ),
                                              )
                                            : SizedBox.shrink(),
                                        model.currentTotalpages > 2
                                            ? RoundedButton(
                                                onPressed: () async {
                                                  model.getCurrentProducts(
                                                    pageNumber:
                                                        model.currentTotalpages,
                                                    filter: Filter(
                                                        tags: [],
                                                        categories: [
                                                          model.currentCategory
                                                        ]),
                                                  );
                                                  setState(() {
                                                    _currentPageNamber =
                                                        model.currentTotalpages;
                                                  });
                                                },
                                                title: model.currentTotalpages
                                                    .toString(),
                                                isSelceted:
                                                    _currentPageNamber ==
                                                        model.currentTotalpages,
                                              )
                                            : SizedBox.shrink(),
                                        SizedBox(
                                          width: 4.0,
                                        ),
                                        _currentPageNamber !=
                                                model.currentTotalpages
                                            ? FlatButton(
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          25.0),
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
                                                  model.getCurrentProducts(
                                                    pageNumber:
                                                        _currentPageNamber + 1,
                                                    filter: Filter(
                                                        tags: [],
                                                        categories: [
                                                          model.currentCategory
                                                        ]),
                                                  );
                                                  setState(() {
                                                    _currentPageNamber += 1;
                                                  });
                                                })
                                            : SizedBox.shrink(),
                                      ],
                                    ),
                                  );
                                }
                              },
                            )
                          : Center(
                              child: Text('لا توجد نتائج'),
                            ),
                  SizedBox(
                    height: 100,
                  ),
                ],
              ),
      );
    });
  }
}
