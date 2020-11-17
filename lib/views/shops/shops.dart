import 'package:flutter/material.dart';
import 'package:qarinli/views/landing_screen/widgets/shop_card.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class ShopsScreen extends StatelessWidget {
  // final List<Widget> shops=  List.generate(
  //           44,
  //           (index) => (context, index) {
  //                 return Text(index);
  //               }).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 3,
        children: List<Widget>.generate(43, (index) {
          return ShopCard(
              imageURL: 'assets/shops/' + (index + 1).toString() + '.jpg');
        }),
      ),
    );
  }
}
