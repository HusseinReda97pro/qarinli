import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/widgets/app_drawer/widgets/drawer_tab.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Drawer(
        child: Directionality(
          // add this
          textDirection: TextDirection.rtl,
          child: ListView(
            children: <Widget>[
              AppBar(
                automaticallyImplyLeading: false,
                title: Text(
                  'القائمة',
                  style: TextStyle(fontSize: 18),
                ),
                elevation: Theme.of(context).platform == TargetPlatform.iOS
                    ? 0.0
                    : 4.0,
              ),
              DrawerTab(
                title: 'الصفحة الرئيسية',
                icon: Icons.home,
                onTap: () {
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return YoutubePlayerDemoApp();
                  // }));
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
