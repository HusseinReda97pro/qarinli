import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/loading.dart';

class ProductsScreen extends StatefulWidget {
  final int categoryId;
  final bool withoutOffers;
  ProductsScreen({this.categoryId, this.withoutOffers});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int pageNamber = 2;
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      // print('test');
      // print(model.currentProducts.length);
      return Scaffold(
        appBar: MainAppBar(context: context),
        body: model.currentProducts.length > 0
            ? ListView.builder(
                itemCount: model.currentProducts.length + 1,
                itemBuilder: (context, index) {
                  if (index < model.currentProducts.length) {
                    return ProductCard(product: model.currentProducts[index]);
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
                              color: Palette.midBlue,
                              child: Icon(
                                Icons.arrow_left,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                if (pageNamber > 1) {
                                  loading(context, 'looding');
                                  List<Product> products = await model
                                      .productsController
                                      .getProducts(
                                          page: pageNamber - 1,
                                          categoryId: widget.categoryId,
                                          withoutOffers: widget.withoutOffers);
                                  setState(() {
                                    model.currentProducts = products;
                                    pageNamber -= 1;
                                  });
                                  Navigator.of(context).pop();
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
                              color: Palette.midBlue,
                              child: Icon(
                                Icons.arrow_right,
                                size: 18,
                                color: Colors.white,
                              ),
                              onPressed: () async {
                                loading(context, 'looding');
                                List<Product> products =
                                    await model.productsController.getProducts(
                                        page: pageNamber + 1,
                                        categoryId: widget.categoryId,
                                        withoutOffers: widget.withoutOffers);
                                setState(() {
                                  model.currentProducts = products;
                                  pageNamber += 1;
                                });
                                Navigator.of(context).pop();
                              }),
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
