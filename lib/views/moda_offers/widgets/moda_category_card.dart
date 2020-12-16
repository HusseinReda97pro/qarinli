import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/models/category.dart';

class ModaCategoryCard extends StatelessWidget {
  final Category category;
  final bool isSelected;
  const ModaCategoryCard({this.category, this.isSelected = false});

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
            category.imageUrl != null
                ? FadeInImage(
                    width: 80,
                    height: 80,
                    image: CachedNetworkImageProvider(category.imageUrl),
                    placeholder: AssetImage('assets/placeholder_image.png'),
                  )
                : Image.asset(
                    'assets/placeholder_image.png',
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
