import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/product_cart.dart';

class ProductCartCard extends StatefulWidget {
  final ProductCart productCart;
  ProductCartCard({@required this.productCart});
  @override
  _ProductCartCardState createState() => _ProductCartCardState();
}

class _ProductCartCardState extends State<ProductCartCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 15.0, vertical: 4.0),
      child: Card(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    margin: EdgeInsets.all(4.0),
                    child: GestureDetector(
                      onTap: () {
                        //TODO Delet From cart
                      },
                      child: Icon(
                        Icons.cancel,
                        color: Colors.red,
                      ),
                    ),
                  ),
                  Text(widget.productCart.productTitle),
                ],
              ),
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                    child: Text('السعر'),
                  ),
                  Text(widget.productCart.productPrice)
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                    child: Text('الكمية'),
                  ),
                  Container(
                    width: 70,
                    height: 50,
                    margin: EdgeInsets.only(top: 15),
                    child: Directionality(
                      textDirection: TextDirection.rtl,
                      child: NumberInputWithIncrementDecrement(
                        initialValue: widget.productCart.quantity,
                        scaleHeight: 1,
                        widgetContainerDecoration: BoxDecoration(
                          border: Border.all(
                            color: AppThemeModel.isLight
                                ? Colors.black
                                : Colors.white,
                            width: 0.5,
                          ),
                        ),
                        controller: TextEditingController(),
                        min: 1,
                        max: 100,
                      ),
                    ),
                  ),
                ],
              ),
              Divider(),
              Row(
                children: [
                  Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 4.0, horizontal: 24.0),
                    child: Text('المجموع'),
                  ),
                  Text(widget.productCart.total.toString()),
                ],
              ),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }
}
