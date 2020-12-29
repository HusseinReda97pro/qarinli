import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/top_categories/widgets/sub_category_card.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/rounded_button.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class KidsScrren extends StatefulWidget {
  @override
  _KidsScrrenState createState() => _KidsScrrenState();
}

class _KidsScrrenState extends State<KidsScrren> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      // _scrollController = _scrollControllerHomeTab;
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: ListView(
          children: [
            topCategories[7].subCategories != null
                ? Container(
                    margin: EdgeInsets.only(right: 15, top: 15.0),
                    child: Text(
                      // 'Sub Categories',
                      'الفئات الفرعية',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : SizedBox.shrink(),
            topCategories[7].subCategories != null
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 20),
                    child: ColumnBuilder(
                      itemCount: topCategories[7].subCategories.length,
                      itemBuilder: (BuildContext context, int index) {
                        return SubCategoryCard(
                            category: topCategories[7].subCategories[index]);
                      },
                    ),
                  )
                : Spinner(),
            topCategories[7].fetchedProducts.products.length > 0
                ? Container(
                    margin: EdgeInsets.only(right: 15, top: 15.0),
                    child: Text(
                      // 'Complete Catalogue',
                      'كتالوج المنتجات',
                      textDirection: TextDirection.rtl,
                      style: TextStyle(fontSize: 24),
                    ),
                  )
                : SizedBox.shrink(),
            topCategories[7].productsIsLoading
                ? Spinner()
                : topCategories[7].fetchedProducts.products.length > 0
                    ? ColumnBuilder(
                        itemCount:
                            topCategories[7].fetchedProducts.products.length +
                                2,
                        itemBuilder: (context, index) {
                          if (index == 0) {
                            return Directionality(
                              textDirection: TextDirection.rtl,
                              child: Container(
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.symmetric(horizontal: 15.0),
                                child: Text(
                                  topCategories[7]
                                          .fetchedProducts
                                          .totalResults
                                          .toString() +
                                      ' نتيجة',
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      color: AppThemeModel.isLight()
                                          ? Palette.black
                                          : Palette.yellow),
                                ),
                              ),
                            );
                          }
                          if (index <
                              topCategories[7].fetchedProducts.products.length +
                                  1) {
                            return ProductCard(
                                product: topCategories[7]
                                    .fetchedProducts
                                    .products[index - 1]);
                          } else {
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  topCategories[7].currentPage > 1
                                      ? FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(50.0),
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
                                            if (topCategories[7].currentPage >
                                                1) {
                                              model.getCurrentProducts(
                                                pageNumber: topCategories[7]
                                                        .currentPage -
                                                    1,
                                                filter: Filter(categories: [
                                                  topCategories[7]
                                                ], tags: []),
                                              );
                                              setState(() {
                                                topCategories[7].currentPage -=
                                                    1;
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
                                            categories: [topCategories[7]]),
                                      );
                                      setState(() {
                                        topCategories[7].currentPage = 1;
                                      });
                                    },
                                    title: '1',
                                    isSelceted:
                                        topCategories[7].currentPage == 1,
                                  ),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  topCategories[7].fetchedProducts.totalPages >
                                          2
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
                                                itemCount: topCategories[7]
                                                        .fetchedProducts
                                                        .totalPages -
                                                    2,
                                                itemBuilder:
                                                    (BuildContext context,
                                                        int index) {
                                                  return Container(
                                                    margin:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 3.0),
                                                    child: RoundedButton(
                                                      onPressed: () async {
                                                        model
                                                            .getCurrentProducts(
                                                          pageNumber:
                                                              (index + 2),
                                                          filter: Filter(
                                                              tags: [],
                                                              categories: [
                                                                topCategories[7]
                                                              ]),
                                                        );
                                                        setState(() {
                                                          topCategories[7]
                                                                  .currentPage =
                                                              (index + 2);
                                                        });
                                                      },
                                                      title: (index + 2)
                                                          .toString(),
                                                      isSelceted: topCategories[
                                                                  7]
                                                              .currentPage ==
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
                                  topCategories[7].fetchedProducts.totalPages >
                                          2
                                      ? RoundedButton(
                                          onPressed: () async {
                                            model.getCurrentProducts(
                                              pageNumber:
                                                  model.currentTotalpages,
                                              filter: Filter(
                                                  tags: [],
                                                  categories: [
                                                    topCategories[7]
                                                  ]),
                                            );
                                            setState(() {
                                              topCategories[7].currentPage =
                                                  topCategories[7]
                                                      .fetchedProducts
                                                      .totalPages;
                                            });
                                          },
                                          title: topCategories[7]
                                              .fetchedProducts
                                              .totalPages
                                              .toString(),
                                          isSelceted:
                                              topCategories[7].currentPage ==
                                                  model.currentTotalpages,
                                        )
                                      : SizedBox.shrink(),
                                  SizedBox(
                                    width: 4.0,
                                  ),
                                  topCategories[7].currentPage !=
                                          topCategories[7]
                                              .fetchedProducts
                                              .totalPages
                                      ? FlatButton(
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
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
                                                  topCategories[7].currentPage +
                                                      1,
                                              filter: Filter(categories: [
                                                topCategories[7]
                                              ], tags: []),
                                            );
                                            setState(() {
                                              topCategories[7].currentPage += 1;
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
