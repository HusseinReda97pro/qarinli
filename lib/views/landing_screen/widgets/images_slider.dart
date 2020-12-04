import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';

class ImagesSlider extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ImagesSliderState();
  }
}

class _ImagesSliderState extends State<ImagesSlider> {
  final CarouselController buttonCarouselController = CarouselController();
  final List<String> images = [
    'assets/images_slider/1.jpg',
    'assets/images_slider/2.jpg',
    'assets/images_slider/3.jpg',
    'assets/images_slider/4.jpg',
  ];
  int _current = 0;
  List<T> map<T>(List list, Function handler) {
    List<T> result = [];
    for (var i = 0; i < list.length; i++) {
      result.add(handler(i, list[i]));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) => Column(children: <Widget>[
        CarouselSlider(
          items: images.map((imgUrl) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  // margin: EdgeInsets.symmetric(horizontal: 2, vertical: 10.0),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                  ),
                  child: Image.asset(
                    imgUrl,
                    fit: BoxFit.fill,
                  ),
                );
              },
            );
          }).toList(),
          carouselController: buttonCarouselController,
          options: CarouselOptions(
              autoPlay: true,
              autoPlayAnimationDuration: Duration(seconds: 2),
              // pauseAutoPlayOnTouch: ,
              // pauseAutoPlayOnTouch: Duration(seconds: 5),
              enlargeCenterPage: true,
              viewportFraction: 1,
              aspectRatio: 2.0,
              initialPage: 0,
              height: MediaQuery.of(context).size.width > 600 ? 240 : 120.0,
              onPageChanged: (index, _) {
                setState(() {
                  _current = index;
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: map<Widget>(images, (index, url) {
            return Container(
              width: 10.0,
              height: 10.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: _current == index
                    ? theme == AppTheme.LIGHT
                        ? Palette.yellow
                        : Colors.black54
                    : theme == AppTheme.LIGHT
                        ? Palette.midBlue
                        : Colors.white,
              ),
            );
          }),
        ),
      ]);
}
