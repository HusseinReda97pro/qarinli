import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/productScreen/widgets/best_price.dart';
import 'package:qarinli/views/productScreen/widgets/offers_prices.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen({@required this.product});
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Widget _buildCardTitle(String title) {
    return Card(
      child: Center(
        child: Text(
          title,
          style: TextStyle(color: Theme.of(context).primaryColor, fontSize: 24),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        body: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(5.0),
              height: 200,
              child: widget.product.imageUrl != null
                  ? FadeInImage(
                      image:
                          CachedNetworkImageProvider(widget.product.imageUrl),
                      placeholder: AssetImage('assets/placeholder_image.png'),
                    )
                  : Image.asset('assets/placeholder_image.png'),
            ),
            Center(
              child: Text(
                widget.product.name,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('الأسعار'),
              trailing: SizedBox(),
              children: [
                OffersPrices(
                  shops: widget.product.shops,
                ),
                BestPrice(price: widget.product.price)
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('الوصف'),
              trailing: SizedBox(),
              children: [
                Directionality(
                  // add this
                  textDirection: TextDirection.rtl,
                  child: Html(data: widget.product.description),
                )
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('صور'),
              trailing: SizedBox(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Test"),
                      Spacer(),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('فيدوهات'),
              trailing: SizedBox(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Test"),
                      Spacer(),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('تقيمات المستخدم'),
              trailing: SizedBox(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Test"),
                      Spacer(),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('تاريخ الأسعار'),
              trailing: SizedBox(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Test"),
                      Spacer(),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            ),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('منتجات مقترحة'),
              trailing: SizedBox(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text("Test"),
                      Spacer(),
                      Icon(Icons.check),
                    ],
                  ),
                ),
              ],
            )
          ],
        ));
  }
}
