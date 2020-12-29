import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

class FullScreenImage extends StatelessWidget {
  final String imageUrl;
  final String tag;

  const FullScreenImage({this.imageUrl, this.tag});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: GestureDetector(
        child: Center(
          child: Hero(
              tag: tag,
              child: PhotoView(
                imageProvider: CachedNetworkImageProvider(
                  imageUrl,
                ),
              )

              // CachedNetworkImage(
              //   width: MediaQuery.of(context).size.width,
              //   fit: BoxFit.contain,
              //   imageUrl: imageUrl,
              // ),
              ),
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}
