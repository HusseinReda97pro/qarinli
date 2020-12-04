import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/productScreen/widgets/best_price.dart';
import 'package:qarinli/views/productScreen/widgets/offers_prices.dart';
import 'package:qarinli/views/productScreen/widgets/products_slider_prodduct_screen.dart';
import 'package:qarinli/views/productScreen/widgets/youtube_video_player.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  ProductScreen({
    @required this.product,
  });
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CarouselController buttonCarouselControllerVideo = CarouselController();
  final CarouselController buttonCarouselControllerImage = CarouselController();
  int _currentVideo = 0;
  int _currentImage = 0;

  Widget _buildCardTitle(String title) {
    return Card(
      child: Center(
        child: Text(
          title,
          style: TextStyle(
              color: theme == AppTheme.LIGHT ? Palette.midBlue : Colors.white,
              fontSize: 24),
        ),
      ),
    );
  }

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  void initState() {
    super.initState();
    if (!widget.product.images.contains(widget.product.imageUrl)) {
      widget.product.images.insert(0, widget.product.imageUrl);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
        body: ListView(
          children: [
            Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.65,
                    height: MediaQuery.of(context).size.width * 0.6,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Palette.midBlue, width: 2.0),
                      ),
                      child: CarouselSlider(
                        items: widget.product.images.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                child: image != null
                                    ? FadeInImage(
                                        image:
                                            CachedNetworkImageProvider(image),
                                        placeholder: AssetImage(
                                            'assets/placeholder_image.png'),
                                      )
                                    : Image.asset(
                                        'assets/placeholder_image.png'),
                              );
                            },
                          );
                        }).toList(),
                        carouselController: buttonCarouselControllerImage,
                        options: CarouselOptions(
                            autoPlay: false,
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            height: 200.0,
                            onPageChanged: (index, _) {
                              setState(() {
                                _currentImage = index;
                              });
                            }),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 20,
                  top: 0,
                  child: Column(
                    children: [
                      Container(
                        width: 8.0,
                        child: IconButton(
                          color: theme == AppTheme.LIGHT
                              ? Colors.black
                              : Palette.yellow,
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.share),
                          onPressed: () {
                            //TODO shar product
                          },
                        ),
                      ),
                      Container(
                        width: 8.0,
                        child: IconButton(
                          color: theme == AppTheme.LIGHT
                              ? Colors.black
                              : Palette.yellow,
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.favorite_outline),
                          onPressed: () {
                            //TODO add to favorites
                          },
                        ),
                      ),
                      Container(
                        width: 8.0,
                        child: IconButton(
                          color: theme == AppTheme.LIGHT
                              ? Colors.black
                              : Palette.yellow,
                          padding: EdgeInsets.all(0),
                          icon: Icon(Icons.alarm_outlined),
                          onPressed: () {
                            //TODO add to wish list
                          },
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(widget.product.images, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _currentImage == index
                          ? theme == AppTheme.LIGHT
                              ? Palette.yellow
                              : Colors.black54
                          : theme == AppTheme.LIGHT
                              ? Palette.midBlue
                              : Colors.white),
                );
              }),
            ),
            Text(
              widget.product.name,
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            Text(
              widget.product.price.isNotEmpty
                  ? double.parse(widget.product.price).toStringAsFixed(2) +
                      ' ر.س'
                  : '',
              textAlign: TextAlign.center,
              textDirection: TextDirection.rtl,
              style: TextStyle(
                  fontSize: 24,
                  color:
                      theme == AppTheme.LIGHT ? Colors.black : Palette.yellow),
            ),
            widget.product.shops.length > 0
                ? GestureDetector(
                    onTap: () {
                      //TODO show all prices
                    },
                    child: Card(
                      margin: EdgeInsets.symmetric(horizontal: 10.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Palette.midBlue, width: 2.0),
                      ),
                      child: Container(
                        margin: EdgeInsets.symmetric(vertical: 2.0),
                        color: Palette.grey,
                        child: Text(
                          widget.product.shops.length.toString() + ' Prices',
                          textAlign: TextAlign.center,
                          style: TextStyle(fontSize: 24.0, color: Colors.white),
                        ),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            widget.product.shops.length > 0
                ? Container(
                    margin: EdgeInsets.all(10.0),
                    child: Text(
                      widget.product.shops.length.toString() + ' Prices',
                      style: TextStyle(fontSize: 24.0),
                    ),
                  )
                : SizedBox.shrink(),
            widget.product.shops.length > 0
                ? OffersPrices(
                    shops: widget.product.shops,
                  )
                : SizedBox.shrink(),
            SizedBox(
              height: 25.0,
            ),
            BestPrice(product: widget.product),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Product Specifications',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Directionality(
              textDirection: TextDirection.rtl,
              child: Html(data: widget.product.description),
            ),
            Container(
              margin: EdgeInsets.only(top: 15),
              padding: EdgeInsets.all(10.0),
              child: Text(
                'Product Specifications',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10.0),
              child: Card(
                color: Palette.grey,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6.0),
                  side: BorderSide(color: Palette.midBlue, width: 2.0),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        margin: EdgeInsets.all(10.0),
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: Text(
                          'compare this product with others',
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                    Center(
                      child: Container(
                        width: MediaQuery.of(context).size.width * 0.85,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                            side:
                                BorderSide(color: Palette.midBlue, width: 2.0),
                          ),
                          color: Colors.white,
                          onPressed: () {},
                          child: Text(
                            'Compare',
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 10),
              // padding: EdgeInsets.all(10.0),
              child: Text(
                'User Reviews',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 10),
              child: Text(
                'How many stars would you give this product?',
                style: TextStyle(
                  fontSize: 16.0,
                ),
              ),
            ),
            Center(
              child: RatingBarIndicator(
                rating: double.parse(widget.product.reviews.averageRating),
                direction: Axis.horizontal,
                unratedColor:
                    theme == AppTheme.LIGHT ? Colors.black : Colors.white,
                itemBuilder: (context, index) => Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                itemCount: 5,
                itemSize: 42,
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 15, left: 10),
              // padding: EdgeInsets.all(10.0),
              child: Text(
                'Videos',
                style: TextStyle(
                  fontSize: 24.0,
                ),
              ),
            ),
            widget.product.youtubeVideos.length > 0
                ? Container(
                    margin: EdgeInsets.symmetric(horizontal: 10.0),
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                        side: BorderSide(color: Palette.midBlue, width: 2.0),
                      ),
                      child: CarouselSlider(
                        items: widget.product.youtubeVideos.map((video) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                  width: MediaQuery.of(context).size.width,
                                  // margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10.0),
                                  // decoration:
                                  //     BoxDecoration(color: Colors.white),
                                  child: YoutubeVideoPlayer(
                                    youtubeVideo: video,
                                  ));
                            },
                          );
                        }).toList(),
                        carouselController: buttonCarouselControllerVideo,
                        options: CarouselOptions(
                            autoPlay: false,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            // pauseAutoPlayOnTouch: ,
                            // pauseAutoPlayOnTouch: Duration(seconds: 5),
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            height: MediaQuery.of(context).size.width > 600
                                ? 850
                                : 400.0,
                            onPageChanged: (index, _) {
                              setState(() {
                                _currentVideo = index;
                              });
                            }),
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            widget.product.youtubeVideos.length > 0
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children:
                        map<Widget>(widget.product.youtubeVideos, (index, url) {
                      return Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 2.0),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: _currentVideo == index
                              ? theme == AppTheme.LIGHT
                                  ? Palette.yellow
                                  : Colors.black54
                              : theme == AppTheme.LIGHT
                                  ? Palette.midBlue
                                  : Colors.white,
                        ),
                      );
                    }),
                  )
                : SizedBox.shrink(),
            !model.relatedProductsIsLoading && model.relatedProducts.length > 0
                ? Container(
                    margin: EdgeInsets.only(top: 15, left: 10),
                    // padding: EdgeInsets.all(10.0),
                    child: Text(
                      'Other Alternatives',
                      style: TextStyle(
                        fontSize: 24.0,
                      ),
                    ),
                  )
                : SizedBox.shrink(),
            RelatedProductsSlider(
              isLoading: model.relatedProductsIsLoading,
              products: model.relatedProducts,
              textDirection: TextDirection.ltr,
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
