import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';

class MyQarinliCard extends StatelessWidget {
  final Function onTap;
  final IconData icon;
  final String text;
  MyQarinliCard(
      {@required this.icon, @required this.text, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(6.0),
          side: BorderSide(color: Palette.midBlue, width: 2),
        ),
        child: Container(
          margin: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Icon(
                icon,
                size: 24.0,
                color: theme == AppTheme.LIGHT ? Colors.black : Palette.yellow,
              ),
              SizedBox(
                width: 8.0,
              ),
              Text(
                text,
                style: TextStyle(fontSize: 24.0),
              )
            ],
          ),
        ),
      ),
    );
  }
}
