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
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class ProductsTab extends StatefulWidget {
  // final ScrollController scrollController;
  // ProductsTab({this.scrollController});

  @override
  _ProductsTabState createState() => _ProductsTabState();
}

class _ProductsTabState extends State<ProductsTab> {
  int _sectedIndex = 0;

  int pageNamber = 2;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      // _scrollController = _scrollControllerHomeTab;
      return ListView(
        // controller: widget.scrollController,
        children: [
          Container(
            margin: EdgeInsets.only(left: 15, top: 15.0),
            child: Text(
              'Top Categories',
              style: TextStyle(fontSize: 24),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.only(left: 20),
              child: RowBuilder(
                itemCount: topCategories.length,
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _sectedIndex = index;
                      });
                    },
                    child: TopCategoryCard(
                      category: topCategories[index],
                      isSelected: topCategories[_sectedIndex].id ==
                          topCategories[index].id,
                    ),
                  );
                },
              ),
            ),
          ),
          topCategories[_sectedIndex].subCategories != null
              ? Container(
                  margin: EdgeInsets.only(left: 15, top: 15.0),
                  child: Text(
                    'Sub Categories',
                    style: TextStyle(fontSize: 24),
                  ),
                )
              : SizedBox.shrink(),
          topCategories[_sectedIndex].subCategories != null
              ? Container(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  child: ColumnBuilder(
                    itemCount: topCategories[_sectedIndex].subCategories.length,
                    itemBuilder: (BuildContext context, int index) {
                      return SubCategoryCard(
                          category:
                              topCategories[_sectedIndex].subCategories[index]);
                    },
                  ),
                )
              : Spinner(),
          // model.currentProducts.length > 0
          //     ? Container(
          //         margin: EdgeInsets.only(left: 15, top: 15.0),
          //         child: Text(
          //           'Complete Catalogue',
          //           style: TextStyle(fontSize: 24),
          //         ),
          //       )
          //     : SizedBox.shrink(),
          // model.currentProducts.length > 0
          //     ? ColumnBuilder(
          //         itemCount: model.currentProducts.length + 1,
          //         itemBuilder: (context, index) {
          //           if (index < model.currentProducts.length) {
          //             return ProductCard(product: model.currentProducts[index]);
          //           } else {
          //             return Container(
          //               margin: EdgeInsets.symmetric(horizontal: 20),
          //               child: Row(
          //                 mainAxisAlignment: MainAxisAlignment.center,
          //                 children: [
          //                   FlatButton(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(50.0),
          //                       ),
          //                       height: 25,
          //                       minWidth: 15,
          //                       color: theme == AppTheme.LIGHT
          //                           ? Palette.midBlue
          //                           : Colors.white,
          //                       child: Icon(
          //                         Icons.arrow_left,
          //                         size: 18,
          //                         color: theme == AppTheme.LIGHT
          //                             ? Colors.white
          //                             : Palette.midBlue,
          //                       ),
          //                       onPressed: () async {
          //                         if (pageNamber > 1) {
          //                           model.getCurrentProducts(
          //                             pageNamber: pageNamber - 1,
          //                             categoryId:
          //                                 topCategories[_sectedIndex].id,
          //                           );
          //                           setState(() {
          //                             pageNamber -= 1;
          //                           });
          //                         }
          //                       }),
          //                   SizedBox(
          //                     width: 4.0,
          //                   ),
          //                   FlatButton(
          //                       shape: RoundedRectangleBorder(
          //                         borderRadius: BorderRadius.circular(25.0),
          //                       ),
          //                       height: 25,
          //                       minWidth: 15,
          //                       color: theme == AppTheme.LIGHT
          //                           ? Palette.midBlue
          //                           : Colors.white,
          //                       child: Icon(
          //                         Icons.arrow_right,
          //                         size: 18,
          //                         color: theme == AppTheme.LIGHT
          //                             ? Colors.white
          //                             : Palette.midBlue,
          //                       ),
          //                       onPressed: () async {
          //                         model.getCurrentProducts(
          //                           pageNamber: pageNamber + 1,
          //                           categoryId: topCategories[_sectedIndex].id,
          //                         );
          //                         setState(() {
          //                           pageNamber += 1;
          //                         });
          //                       }),
          //                 ],
          //               ),
          //             );
          //           }
          //         },
          //       )
          //     : Center(
          //         child: Text('لا توجد نتائج'),
          // ),

          SizedBox(
            height: 100,
          ),
        ],
      );
    });
  }
}
