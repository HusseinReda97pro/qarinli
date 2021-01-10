import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/cart/widgets/product_cart_card.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(
        builder: (BuildContext context, MainModel model, Widget child) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: model.currentCartIsLoading
            ? Spinner()
            : ListView.builder(
                itemCount: model.currentCart.length,
                itemBuilder: (BuildContext context, int index) {
                  return ProductCartCard(productCart: model.currentCart[index]);
                }),
      );
    });
  }
}
