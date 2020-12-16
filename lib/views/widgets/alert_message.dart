import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';

void showAlertMessage({context, title, message}) {
  showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            titlePadding: EdgeInsets.all(0.0),
            title: Container(
              padding: EdgeInsets.all(5.0),
              child: Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              color: Palette.midBlue,
            ),
            content: message,
            actions: <Widget>[
              RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                color: Palette.midBlue,
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  'حسنا',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        );
      });
}
