import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/attribute.dart';

class AtributeCard extends StatelessWidget {
  final Attribute attribute;
  final bool isSelected;
  AtributeCard({@required this.attribute, @required this.isSelected});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(4.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: BorderSide(
            color: isSelected ? Palette.yellow : Palette.midBlue, width: 2),
      ),
      color: AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
      child: Container(
        margin: EdgeInsets.all(4.0),
        child: Text(
          attribute.nama,
          style: TextStyle(
              color: AppThemeModel.isLight() ? Colors.white : Palette.midBlue,
              fontSize: 18.0),
        ),
      ),
    );
  }
}
