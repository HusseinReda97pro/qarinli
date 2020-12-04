import 'package:flutter/material.dart';
import 'package:qarinli/config/theme.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final context;
  MainAppBar({@required this.context});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(
            // color: Colors.black,
            color: theme == AppTheme.LIGHT
                ? Theme.of(context).primaryColor
                : Colors.white),
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          margin: EdgeInsets.all(30),
          child: Image.asset(
            theme == AppTheme.LIGHT
                ? 'assets/light_logo.png'
                : 'assets/dark_logo.png',
            width: MediaQuery.of(context).size.width > 600 ? 240 : 160,
            height: MediaQuery.of(context).size.width > 600 ? 120 : 80,
          ),
        ));
  }

  @override
  Size get preferredSize => new Size.fromHeight(100);

  // @override
  // Size get preferredSize =>
  //     new Size.fromHeight(MediaQuery.of(context).size.height * 0.09);
}
