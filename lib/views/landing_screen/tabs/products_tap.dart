import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/config/top_categories.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/top_categories/widgets/sub_category_card.dart';
import 'package:qarinli/views/top_categories/widgets/top_categories_card.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/rounded_button.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class ProductsTab extends StatefulWidget {
  // final ScrollController scrollController;
  // ProductsTab({this.scrollController});

  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      // _scrollController = _scrollControllerHomeTab;
      return ListView(
        // controller: widget.scrollController,
        children: [
          Container(
            margin: EdgeInsets.only(right: 15, top: 15.0),
            child: Text(
              // 'Top Categories',
              'الفئات الأساسية',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 24),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                margin: EdgeInsets.only(right: 20),
                child: RowBuilder(
                  itemCount: topCategories.length,
                  itemBuilder: (BuildContext context, int index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedIndex = index;
                        });
                      },
                      child: TopCategoryCard(
                        category: topCategories[index],
                        isSelected: topCategories[_selectedIndex].id ==
                            topCategories[index].id,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          topCategories[_selectedIndex].subCategories != null
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
          topCategories[_selectedIndex].subCategories != null
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ColumnBuilder(
                    itemCount:
                        topCategories[_selectedIndex].subCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SubCategoryCard(
                          category: topCategories[_selectedIndex]
                              .subCategories[index]);
                    },
                  ),
                )
              : Spinner(),
          topCategories[_selectedIndex].fetchedProducts.products.length > 0
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
          topCategories[_selectedIndex].productsIsLoading
              ? Spinner()
              : topCategories[_selectedIndex].fetchedProducts.products.length >
                      0
                  ? ColumnBuilder(
                      itemCount: topCategories[_selectedIndex]
                              .fetchedProducts
                              .products
                              .length +
                          2,
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return Directionality(
                            textDirection: TextDirection.rtl,
                            child: Container(
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.symmetric(horizontal: 15.0),
                              child: Text(
                                topCategories[_selectedIndex]
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
                            topCategories[_selectedIndex]
                                    .fetchedProducts
                                    .products
                                    .length +
                                1) {
                          return ProductCard(
                              product: topCategories[_selectedIndex]
                                  .fetchedProducts
                                  .products[index - 1]);
                        } else {
                          return
                              //  Container(
                              //   margin: EdgeInsets.symmetric(horizontal: 20),
                              //   child: Row(
                              //     mainAxisAlignment: MainAxisAlignment.center,
                              //     children: [
                              //       FlatButton(
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(50.0),
                              //           ),
                              //           height: 25,
                              //           minWidth: 15,
                              //           color: theme == AppTheme.LIGHT
                              //               ? Palette.midBlue
                              //               : Colors.white,
                              //           child: Icon(
                              //             Icons.arrow_left,
                              //             size: 18,
                              //             color: theme == AppTheme.LIGHT
                              //                 ? Colors.white
                              //                 : Palette.midBlue,
                              //           ),
                              //           onPressed: () async {
                              //             if (topCategories[_selectedIndex]
                              //                     .currentPage >
                              //                 1) {
                              //               model.getTopCategoryCurrentProducts(
                              //                 selectedIndex: _selectedIndex,
                              //                 pageNamber:
                              //                     topCategories[_selectedIndex]
                              //                             .currentPage -
                              //                         1,
                              //                 categoryId:
                              //                     topCategories[_selectedIndex].id,
                              //               );
                              //               setState(() {
                              //                 topCategories[_selectedIndex]
                              //                     .currentPage -= 1;
                              //               });
                              //             }
                              //           }),
                              //       SizedBox(
                              //         width: 4.0,
                              //       ),
                              //       FlatButton(
                              //           shape: RoundedRectangleBorder(
                              //             borderRadius: BorderRadius.circular(25.0),
                              //           ),
                              //           height: 25,
                              //           minWidth: 15,
                              //           color: theme == AppTheme.LIGHT
                              //               ? Palette.midBlue
                              //               : Colors.white,
                              //           child: Icon(
                              //             Icons.arrow_right,
                              //             size: 18,
                              //             color: theme == AppTheme.LIGHT
                              //                 ? Colors.white
                              //                 : Palette.midBlue,
                              //           ),
                              //           onPressed: () async {
                              //             model.getTopCategoryCurrentProducts(
                              //               selectedIndex: _selectedIndex,
                              //               pageNamber:
                              // topCategories[_selectedIndex]
                              //         .currentPage +
                              //                       1,
                              //               categoryId:
                              //                   topCategories[_selectedIndex].id,
                              //             );
                              //             setState(() {
                              //               topCategories[_selectedIndex]
                              //                   .currentPage += 1;
                              //             });
                              //           }),
                              //     ],
                              //   ),
                              // );
                              Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                topCategories[_selectedIndex].currentPage > 1
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
                                          if (topCategories[_selectedIndex]
                                                  .currentPage >
                                              1) {
                                            model.getCurrentProducts(
                                                pageNumber: topCategories[
                                                            _selectedIndex]
                                                        .currentPage -
                                                    1,
                                                categoryId: topCategories[
                                                        _selectedIndex]
                                                    .id);
                                            setState(() {
                                              topCategories[_selectedIndex]
                                                  .currentPage -= 1;
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
                                      categoryId:
                                          topCategories[_selectedIndex].id,
                                    );
                                    setState(() {
                                      topCategories[_selectedIndex]
                                          .currentPage = 1;
                                    });
                                  },
                                  title: '1',
                                  isSelceted: topCategories[_selectedIndex]
                                          .currentPage ==
                                      1,
                                ),
                                SizedBox(
                                  width: 4.0,
                                ),
                                topCategories[_selectedIndex]
                                            .fetchedProducts
                                            .totalPages >
                                        2
                                    ? Container(
                                        width:
                                            MediaQuery.of(context).size.width *
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
                                              scrollDirection: Axis.horizontal,
                                              itemCount:
                                                  topCategories[_selectedIndex]
                                                          .fetchedProducts
                                                          .totalPages -
                                                      2,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return Container(
                                                  margin: EdgeInsets.symmetric(
                                                      horizontal: 3.0),
                                                  child: RoundedButton(
                                                    onPressed: () async {
                                                      model.getCurrentProducts(
                                                        pageNumber: (index + 2),
                                                        categoryId: topCategories[
                                                                _selectedIndex]
                                                            .id,
                                                      );
                                                      setState(() {
                                                        topCategories[
                                                                    _selectedIndex]
                                                                .currentPage =
                                                            (index + 2);
                                                      });
                                                    },
                                                    title:
                                                        (index + 2).toString(),
                                                    isSelceted: topCategories[
                                                                _selectedIndex]
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
                                topCategories[_selectedIndex]
                                            .fetchedProducts
                                            .totalPages >
                                        2
                                    ? RoundedButton(
                                        onPressed: () async {
                                          model.getCurrentProducts(
                                            pageNumber: model.currentTotalpages,
                                            categoryId:
                                                topCategories[_selectedIndex]
                                                    .currentPage,
                                          );
                                          setState(() {
                                            topCategories[_selectedIndex]
                                                    .currentPage =
                                                topCategories[_selectedIndex]
                                                    .fetchedProducts
                                                    .totalPages;
                                          });
                                        },
                                        title: topCategories[_selectedIndex]
                                            .fetchedProducts
                                            .totalPages
                                            .toString(),
                                        isSelceted:
                                            topCategories[_selectedIndex]
                                                    .currentPage ==
                                                model.currentTotalpages,
                                      )
                                    : SizedBox.shrink(),
                                SizedBox(
                                  width: 4.0,
                                ),
                                topCategories[_selectedIndex].currentPage !=
                                        topCategories[_selectedIndex]
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
                                                topCategories[_selectedIndex]
                                                        .currentPage +
                                                    1,
                                            categoryId:
                                                topCategories[_selectedIndex]
                                                    .id,
                                          );
                                          setState(() {
                                            topCategories[_selectedIndex]
                                                .currentPage += 1;
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
      );
    });
  }
}
