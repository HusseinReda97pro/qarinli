import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/ProductsScreen/widgets/filter_sheet.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/rounded_button.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final bool withoutOffers;
  final bool comparison;
  final bool choosen;
  final bool moda;
  final String search;
  final bool topSales;

  ProductsScreen(
      {this.categoryId,
      this.withoutOffers,
      this.choosen = false,
      this.moda = false,
      this.comparison = false,
      this.search,
      this.topSales = false});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int _currentPageNamber = 1;

  void displayFlitterBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        // isScrollControlled: true,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height,
            child: Center(child: FilterSheet()),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(context: context),
        endDrawer: AppDrawer(),
        body: model.currentProductsIsLoading
            ? Spinner()
            : model.currentProducts.length > 0
                ? ListView.builder(
                    itemCount: model.currentProducts.length + 3,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Row(
                          children: [
                            Expanded(child: SizedBox()),
                            Container(
                              width: 120,
                              margin: EdgeInsets.symmetric(horizontal: 10.0),
                              child: RaisedButton(
                                color: AppThemeModel.isLight()
                                    ? Palette.midBlue
                                    : Colors.white,
                                onPressed: () {
                                  displayFlitterBottomSheet(context);
                                },
                                child: Text(
                                  'تصفية المنتجات',
                                  style: TextStyle(
                                      color: AppThemeModel.isLight()
                                          ? Colors.white
                                          : Palette.midBlue),
                                ),
                              ),
                            ),
                          ],
                        );
                      }
                      if (index == 1) {
                        return Directionality(
                          textDirection: TextDirection.rtl,
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 15.0),
                            child: Text(
                              model.currentTotalResults.toString() + ' نتيجة',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color: AppThemeModel.isLight()
                                      ? Palette.black
                                      : Palette.yellow),
                            ),
                          ),
                        );
                      }
                      if (index < model.currentProducts.length + 2) {
                        return ProductCard(
                            product: model.currentProducts[index - 2]);
                      } else {
                        return Container(
                          margin: EdgeInsets.symmetric(horizontal: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _currentPageNamber > 1
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
                                        if (_currentPageNamber > 1) {
                                          model.getCurrentProducts(
                                              pageNumber:
                                                  _currentPageNamber - 1,
                                              categoryId: widget.categoryId,
                                              withoutOffers:
                                                  widget.withoutOffers,
                                              comparison: widget.comparison,
                                              choosen: widget.choosen,
                                              moda: widget.moda,
                                              search: widget.search,
                                              topSales: widget.topSales);
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
                                      categoryId: widget.categoryId,
                                      withoutOffers: widget.withoutOffers,
                                      comparison: widget.comparison,
                                      choosen: widget.choosen,
                                      moda: widget.moda,
                                      search: widget.search,
                                      topSales: widget.topSales);
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
                                      width: MediaQuery.of(context).size.width *
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
                                                model.currentTotalpages - 2,
                                            itemBuilder: (BuildContext context,
                                                int index) {
                                              return Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 3.0),
                                                child: RoundedButton(
                                                  onPressed: () async {
                                                    model.getCurrentProducts(
                                                        pageNumber: (index + 2),
                                                        categoryId:
                                                            widget.categoryId,
                                                        withoutOffers: widget
                                                            .withoutOffers,
                                                        comparison:
                                                            widget.comparison,
                                                        choosen: widget.choosen,
                                                        moda: widget.moda,
                                                        search: widget.search,
                                                        topSales:
                                                            widget.topSales);
                                                    setState(() {
                                                      _currentPageNamber =
                                                          (index + 2);
                                                    });
                                                  },
                                                  title: (index + 2).toString(),
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
                                            pageNumber: model.currentTotalpages,
                                            categoryId: widget.categoryId,
                                            withoutOffers: widget.withoutOffers,
                                            comparison: widget.comparison,
                                            choosen: widget.choosen,
                                            moda: widget.moda,
                                            search: widget.search,
                                            topSales: widget.topSales);
                                        setState(() {
                                          _currentPageNamber =
                                              model.currentTotalpages;
                                        });
                                      },
                                      title: model.currentTotalpages.toString(),
                                      isSelceted: _currentPageNamber ==
                                          model.currentTotalpages,
                                    )
                                  : SizedBox.shrink(),
                              SizedBox(
                                width: 4.0,
                              ),
                              _currentPageNamber != model.currentTotalpages
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
                                            pageNumber: _currentPageNamber + 1,
                                            categoryId: widget.categoryId,
                                            withoutOffers: widget.withoutOffers,
                                            comparison: widget.comparison,
                                            choosen: widget.choosen,
                                            moda: widget.moda,
                                            search: widget.search,
                                            topSales: widget.topSales);
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
      );
    });
  }
}
