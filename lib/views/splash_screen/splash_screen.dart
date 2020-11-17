import 'dart:async';

import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/main.dart';
// import '../main.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () async {
      MyApp.mainModel.loadProductsLanding();
      Navigator.pushReplacementNamed(context, '/landing');
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            // color: darkPurple,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                stops: [0.2, 1.0],
                colors: [Palette.midBlue, Palette.lightBlue],
              ),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Stack(
                        children: [
                          Positioned(
                            right: 15,
                            bottom: 60,
                            top: 60,
                            left: 30,
                            child: ClipOval(
                              child: Material(
                                color: Colors.white,
                                child: SizedBox(
                                  width: 150,
                                  height: 150,
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.all(30.0),
                            child: Image.asset(
                              "assets/logo.png",
                              width: MediaQuery.of(context).size.width * 0.5,
                              height: MediaQuery.of(context).size.height * 0.3,
                              fit: BoxFit.contain,
                            ),
                          ),
                        ],
                      ),
                      Text("قارن الأسعار في أكثر من 100 متجر على الأنترنت",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                          ))
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CircularProgressIndicator(backgroundColor: Colors.white),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0),
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
