import 'package:flutter/material.dart';

class SectionImage extends StatelessWidget {
  final Function onTap;
  final String imageUrl;
  SectionImage({this.imageUrl, this.onTap});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 100,
        child: Image.asset(imageUrl),
      ),
    );
  }
}
