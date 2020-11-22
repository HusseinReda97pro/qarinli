import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/productScreen/widgets/best_price.dart';
import 'package:qarinli/views/productScreen/widgets/offers_prices.dart';
import 'package:qarinli/views/productScreen/widgets/rating_card.dart';
import 'package:qarinli/views/productScreen/widgets/youtube_video_player.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';

class ProductScreen extends StatefulWidget {
  final Product product;
  final List<Product> relatedProducts;
  ProductScreen({
    @required this.product,
    @required this.relatedProducts,
  });
  @override
  _ProductScreenState createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final CarouselController buttonCarouselController = CarouselController();
  int _currentVideo = 0;

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

  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
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
                textAlign: TextAlign.center,
                textDirection: TextDirection.rtl,
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
            widget.product.images.length > 0
                ? ExpansionTile(
                    backgroundColor: Colors.white,
                    title: _buildCardTitle('صور'),
                    trailing: SizedBox(),
                    children: [
                      CarouselSlider(
                        items: widget.product.images.map((image) {
                          return Builder(
                            builder: (BuildContext context) {
                              return Container(
                                width: MediaQuery.of(context).size.width,
                                // margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10.0),
                                decoration: BoxDecoration(color: Colors.white),
                                child: Container(
                                  margin: EdgeInsets.all(5.0),
                                  height: 200,
                                  child: image != null
                                      ? FadeInImage(
                                          image:
                                              CachedNetworkImageProvider(image),
                                          placeholder: AssetImage(
                                              'assets/placeholder_image.png'),
                                        )
                                      : Image.asset(
                                          'assets/placeholder_image.png'),
                                ),
                              );
                            },
                          );
                        }).toList(),
                        carouselController: buttonCarouselController,
                        options: CarouselOptions(
                            autoPlay: false,
                            autoPlayAnimationDuration: Duration(seconds: 2),
                            // pauseAutoPlayOnTouch: ,
                            // pauseAutoPlayOnTouch: Duration(seconds: 5),
                            enlargeCenterPage: true,
                            viewportFraction: 1,
                            aspectRatio: 2.0,
                            initialPage: 0,
                            height: 400.0,
                            onPageChanged: (index, _) {
                              setState(() {
                                _currentVideo = index;
                              });
                            }),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children:
                            map<Widget>(widget.product.images, (index, url) {
                          return Container(
                            width: 10.0,
                            height: 10.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: _currentVideo == index
                                  ? Palette.yellow
                                  : Palette.midBlue,
                            ),
                          );
                        }),
                      ),
                    ],
                  )
                : SizedBox.shrink(),
            widget.product.youtubeVideos.length > 0
                ? ExpansionTile(
                    backgroundColor: Colors.white,
                    title: _buildCardTitle('فيدوهات'),
                    trailing: SizedBox(),
                    children: [
                        CarouselSlider(
                          items: widget.product.youtubeVideos.map((video) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: MediaQuery.of(context).size.width,
                                    // margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10.0),
                                    decoration:
                                        BoxDecoration(color: Colors.white),
                                    child: YoutubeVideoPlayer(
                                      youtubeVideo: video,
                                    ));
                              },
                            );
                          }).toList(),
                          carouselController: buttonCarouselController,
                          options: CarouselOptions(
                              autoPlay: false,
                              autoPlayAnimationDuration: Duration(seconds: 2),
                              // pauseAutoPlayOnTouch: ,
                              // pauseAutoPlayOnTouch: Duration(seconds: 5),
                              enlargeCenterPage: true,
                              viewportFraction: 1,
                              aspectRatio: 2.0,
                              initialPage: 0,
                              height: 400.0,
                              onPageChanged: (index, _) {
                                setState(() {
                                  _currentVideo = index;
                                });
                              }),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: map<Widget>(widget.product.youtubeVideos,
                              (index, url) {
                            return Container(
                              width: 10.0,
                              height: 10.0,
                              margin: EdgeInsets.symmetric(
                                  vertical: 10.0, horizontal: 2.0),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _currentVideo == index
                                    ? Palette.yellow
                                    : Palette.midBlue,
                              ),
                            );
                          }),
                        ),
                      ]

                    // [
                    //   Container(
                    //     margin: EdgeInsets.all(15.0),
                    //     height: 400,
                    //     // width: MediaQuery.of(context).size.width,
                    //     width: MediaQuery.of(context).size.width,
                    //     child: ListView.builder(
                    //         shrinkWrap: true,
                    //         // physics: NeverScrollableScrollPhysics(),
                    //         scrollDirection: Axis.horizontal,
                    //         itemCount: widget.product.youtubeVideos.length,
                    //         itemBuilder: (BuildContext context, int index) {
                    //           return YoutubeVideoPlayer(
                    //             youtubeVideo: widget.product.youtubeVideos[index],
                    //           );
                    //         }),
                    //   ),
                    // ],
                    )
                : SizedBox.shrink(),
            ExpansionTile(
              backgroundColor: Colors.white,
              title: _buildCardTitle('تقيمات المستخدم'),
              trailing: SizedBox(),
              children: [
                RatingCard(
                  reviews: widget.product.reviews,
                )
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
                ColumnBuilder(
                    itemCount: widget.relatedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: widget.relatedProducts[index],
                      );
                    }),
              ],
            )
          ],
        ));
  }
}
