import 'package:flutter/material.dart';

class ProgressIndicatorV2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(child: SizedBox()),
          CircularProgressIndicator(),
          Expanded(child: SizedBox()),
        ],
      ),
    );
  }
}
