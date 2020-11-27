import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreenFirstTimeOnly extends StatefulWidget {
  @override
  _SplashScreenFirstTimeOnlyState createState() =>
      _SplashScreenFirstTimeOnlyState();
}

class _SplashScreenFirstTimeOnlyState extends State<SplashScreenFirstTimeOnly> {
  final CarouselController buttonCarouselController = CarouselController();
  int _currentImage = 0;
  List<String> splashScreens = [
    'assets/splash_screens/1.png',
    'assets/splash_screens/2.png',
    'assets/splash_screens/3.png',
  ];

  @override
  void initState() {
    super.initState();
    // Timer(Duration(seconds: 2), () async {
    //   MyApp.mainModel.loadProductsLanding();
    //   Navigator.pushReplacementNamed(context, '/landing');
    // });
    // getP();
  }

  // void getP() async {
  //   List<Category> categories = await CategoryController.getcategories();
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (BuildContext context) {
  //       return CategoryScreen(
  //         categories: categories,
  //       );
  //     }),
  //   );
  // }
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
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          CarouselSlider(
            items: splashScreens.map((image) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    child: Image.asset(
                      image,
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height,
                      fit: MediaQuery.of(context).size.width > 600
                          ? BoxFit.fill
                          : BoxFit.cover,
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
                height: MediaQuery.of(context).size.height,
                onPageChanged: (index, _) {
                  setState(() {
                    _currentImage = index;
                    print('test' + index.toString());
                  });
                }),
          ),
          Positioned(
            bottom: 40,
            right: MediaQuery.of(context).size.width * 0.48,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: map<Widget>(splashScreens, (index, url) {
                return Container(
                  width: 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        _currentImage == index ? Palette.yellow : Colors.grey,
                  ),
                );
              }),
            ),
          )
        ],
      ),
      floatingActionButton: FlatButton(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18.0),
        ),
        color: Palette.yellow,
        child: Text(
          'Skip',
          style: TextStyle(fontSize: 16.0),
        ),
        onPressed: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setBool('firstTime', false);
          Navigator.pushReplacementNamed(context, '/landing');
        },
      ),
    );
  }
}
