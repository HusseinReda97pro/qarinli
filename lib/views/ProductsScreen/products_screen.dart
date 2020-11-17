import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/widgets/loading.dart';
import 'package:qarinli/controllers/products.dart';

class ProductsScreen extends StatefulWidget {
  List<Product> products;
  final int categoryId;
  ProductsScreen({this.products, this.categoryId});
  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  int pageNamber = 1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(children: [
          Image.asset(
            'assets/logo.png',
            width: 65,
            height: 40,
          ),
          Container(
            margin: EdgeInsets.symmetric(horizontal: 25),
            child: Text('Qarinli Demo'),
          ),
        ]),
      ),
      body: widget.products.length > 0
          ? ListView.builder(
              itemCount: widget.products.length + 1,
              itemBuilder: (context, index) {
                if (index < widget.products.length) {
                  return ProductCard(product: widget.products[index]);
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
                            color: midBlue,
                            child: Icon(
                              Icons.arrow_left,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              if (pageNamber > 1) {
                                loading(context, 'looding');
                                List<Product> products =
                                    await ProductsController.getProducts(
                                        pageNamber - 1, widget.categoryId);
                                setState(() {
                                  widget.products = products;
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
                            color: midBlue,
                            child: Icon(
                              Icons.arrow_right,
                              size: 18,
                              color: Colors.white,
                            ),
                            onPressed: () async {
                              loading(context, 'looding');
                              List<Product> products =
                                  await ProductsController.getProducts(
                                      pageNamber + 1, widget.categoryId);
                              setState(() {
                                widget.products = products;
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
  }
}
