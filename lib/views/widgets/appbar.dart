import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final context;
  MainAppBar({@required this.context});
  @override
  Widget build(BuildContext context) {
    return AppBar(
        iconTheme: IconThemeData(
            // color: Colors.black,
            color: Theme.of(context).primaryColor),
        backgroundColor: Palette.lightGrey,
        elevation: 0,
        centerTitle: true,
        flexibleSpace: Container(
          margin: EdgeInsets.all(30),
          child: Image.asset(
            'assets/logo.png',
            width: MediaQuery.of(context).size.width > 600 ? 120 : 160,
            height: MediaQuery.of(context).size.width > 600 ? 60 : 80,
          ),
        ));
  }

  @override
  Size get preferredSize => new Size.fromHeight(100);

  // @override
  // Size get preferredSize =>
  //     new Size.fromHeight(MediaQuery.of(context).size.height * 0.09);
}
