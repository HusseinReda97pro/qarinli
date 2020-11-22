import 'package:flutter/material.dart';

class MainAppBar extends StatelessWidget implements PreferredSizeWidget {
  final context;
  MainAppBar({@required this.context});
  @override
  Widget build(BuildContext context) {
    return AppBar(
      iconTheme: IconThemeData(
          // color: Colors.black,
          color: Theme.of(context).primaryColor),
      backgroundColor: Colors.white,
      title: Center(
        child: Image.asset(
          'assets/logo.png',
          width: 80,
          height: 40,
        ),
      ),
    );
  }

  @override
  Size get preferredSize =>
      new Size.fromHeight(MediaQuery.of(context).size.height * 0.09);
}
