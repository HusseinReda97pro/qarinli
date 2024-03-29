import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';

class DrawerTab extends StatelessWidget {
  final IconData icon;
  final String title;
  final Function onTap;
  DrawerTab({this.icon, this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        margin: EdgeInsets.all(15.0),
        child: Row(
          children: <Widget>[
            Icon(
              icon,
              color: theme == AppTheme.LIGHT ? Palette.midBlue : Colors.white,
              size: 24,
            ),
            Container(
              margin: EdgeInsets.only(right: 5.0),
              child: Text(
                title,
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: theme == AppTheme.LIGHT
                        ? Palette.midBlue
                        : Colors.white),
              ),
            )
          ],
        ),
      ),
      onTap: onTap,
    );
  }
}
