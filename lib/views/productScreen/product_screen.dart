import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/product.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/productScreen/widgets/best_price.dart';
import 'package:qarinli/views/productScreen/widgets/offers_prices.dart';
import 'package:qarinli/views/productScreen/widgets/rating_card.dart';
import 'package:qarinli/views/productScreen/widgets/youtube_video_player.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';

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
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        endDrawer: AppDrawer(),
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
              initiallyExpanded: true,
              backgroundColor: Palette.lightGrey,
              title: _buildCardTitle('الأسعار'),
              trailing: SizedBox(),
              children: [
                OffersPrices(
                  shops: widget.product.shops,
                ),
                BestPrice(product: widget.product)
              ],
            ),
            ExpansionTile(
              initiallyExpanded: true,
              backgroundColor: Palette.lightGrey,
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
                    initiallyExpanded: true,
                    backgroundColor: Palette.lightGrey,
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
                        carouselController: buttonCarouselControllerImage,
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
                                _currentImage = index;
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
                              color: _currentImage == index
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
                    initiallyExpanded: true,
                    backgroundColor: Palette.lightGrey,
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
              initiallyExpanded: true,
              backgroundColor: Palette.lightGrey,
              title: _buildCardTitle('تقيمات المستخدم'),
              trailing: SizedBox(),
              children: [
                RatingCard(
                  reviews: widget.product.reviews,
                )
              ],
            ),
            // widget.product.historOfPricesHTML != null
            //     ? ExpansionTile(
            //         backgroundColor: Colors.white,
            //         title: _buildCardTitle('تاريخ الأسعار'),
            //         trailing: SizedBox(),
            //         children: [
            //           Directionality(
            //             // add this
            //             textDirection: TextDirection.rtl,
            //             child: Html(
            //               data: widget.product.historOfPricesHTML,
            //               style: {"b": Style(color: Colors.red)},
            //             ),
            //           )
            //         ],
            //       )
            //     : SizedBox.shrink(),
            // ExpansionTile(
            //   backgroundColor: Colors.white,
            //   title: _buildCardTitle('منتجات مقترحة'),
            //   trailing: SizedBox(),
            //   children: [
            model.relatedProductsIsLoading
                ? SizedBox.shrink()
                : Directionality(
                    // add this
                    textDirection: TextDirection.rtl,
                    child: Container(
                      margin: EdgeInsets.all(6.0),
                      child: Text(
                        'منتجات مقترحة',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 24),
                      ),
                    ),
                  ),
            model.relatedProductsIsLoading
                ? Center(
                    child: Container(
                      margin: EdgeInsets.all(10),
                      width: 30,
                      height: 30,
                      child: CircularProgressIndicator(),
                    ),
                  )
                : ColumnBuilder(
                    itemCount: model.relatedProducts.length,
                    itemBuilder: (BuildContext context, int index) {
                      return ProductCard(
                        product: model.relatedProducts[index],
                      );
                    }),
            SizedBox(
              height: 100,
            ),
            //       ],
            //     )
          ],
        ),
        // floatingActionButton: FloatingActionButton(
        //   child: Icon(Icons.print),
        //   onPressed: () {
        //     // print(widget.product.description.runtimeType);
        //     // print(widget.product.historOfPricesHTML);
        //     MyApp.mainModel.productsController
        //         .getHistorOfPricesHTML(widget.product.link);
        //     // Navigator.push(context,
        //     //     MaterialPageRoute(builder: (BuildContext context) {
        //     //   return WebScraperApp();
        //     // }));
        //   },
        // ),
      );
    });
  }
}
