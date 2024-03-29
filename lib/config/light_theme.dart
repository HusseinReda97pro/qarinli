import 'package:flutter/material.dart';

import 'Palette.dart';

ThemeData lighTheme = ThemeData(
    // Define the default brightness and colors.
    primaryColor: Palette.midBlue,
    // scaffoldBackgroundColor: Color(0XFFCCCCCC),
    appBarTheme: AppBarTheme(color: Palette.lightGrey),
    accentColor: Palette.lightBlue,
    // Define the default font family.
    fontFamily: 'SegoeUI',
    // Define the default TextTheme. Use this to specify the default
    // text styling for headlines, titles, bodies of text, and more.
    textTheme: TextTheme(
      headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
      headline6: TextStyle(fontSize: 36.0, fontStyle: FontStyle.italic),
      bodyText2: TextStyle(fontSize: 14.0),
    ).apply(fontFamily: 'Hacen'),
    scaffoldBackgroundColor: Palette.lightGrey,
    // backgroundColor: Palette.lightGrey,
    brightness: Brightness.light);
