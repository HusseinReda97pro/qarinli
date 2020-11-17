import 'package:flutter/material.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/views/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Qarinli Demo',
        theme: appTheme,
        home: SplashScreen());
  }
}
