import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  final String title;
  final Function onTap;
  SectionHeader({@required this.title, @required this.onTap});
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Row(
        children: [
          Text(
            title,
            style: TextStyle(
              // color: Theme.of(context).primaryColor,
              fontWeight: FontWeight.w700,
              fontSize: 18.0,
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          GestureDetector(
            onTap: onTap,
            child: Text(
              'More',
              style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  fontSize: 18.0,
                  decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
