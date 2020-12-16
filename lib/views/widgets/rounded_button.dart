import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';

class RoundedButton extends StatelessWidget {
  final Function onPressed;
  final String title;
  final bool isSelceted;
  RoundedButton(
      {@required this.onPressed,
      @required this.title,
      @required this.isSelceted});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 30.0,
      height: 30.0,
      child: RaisedButton(
        padding: EdgeInsets.all(0),
        child: Text(
          title,
          style: TextStyle(
              color: AppThemeModel.isLight() ? Colors.white : Palette.midBlue,
              fontSize: 10.0),
        ),
        onPressed: onPressed,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4.0),
          side: BorderSide(
              color: isSelceted ? Palette.yellow : Colors.transparent),
        ),
        color: AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
        elevation: 0.0,
      ),
    );
  }
}
