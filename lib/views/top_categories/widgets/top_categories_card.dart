import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/category.dart';

class TopCategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  const TopCategoryCard({this.category, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Palette.lightGrey,
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6.0),
        side: BorderSide(
            color: isSelected ? Palette.yellow : Palette.midBlue, width: 2),
      ),
      child: Container(
        height: 140,
        margin: EdgeInsets.all(10.0),
        child: Column(
          children: [
            Image.asset(
              category.imageUrl,
              width: 80,
              height: 80,
            ),
            Expanded(child: SizedBox.shrink()),
            Container(
              width: 80,
              child: Text(
                category.name,
                style: TextStyle(
                    color: Theme.of(context).primaryColor, fontSize: 16.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}
