import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';

void loading(context, message) {
  showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          titlePadding: EdgeInsets.all(0.0),
          content: Container(
            width: 150,
            height: 100,
            child: Column(
              children: <Widget>[
                SpinKitChasingDots(
                  color:
                      theme == AppTheme.LIGHT ? Palette.midBlue : Colors.white,
                  size: 50.0,
                ),
                SizedBox(
                  height: 5.0,
                ),
                Text(
                  message,
                  style: TextStyle(
                      color: theme == AppTheme.LIGHT
                          ? Palette.midBlue
                          : Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        );
      });
}
