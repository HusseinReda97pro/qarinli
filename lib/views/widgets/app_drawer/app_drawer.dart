import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/category_controller.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/views/categories/category_screen.dart';
import 'package:qarinli/views/widgets/app_drawer/widgets/drawer_tab.dart';

import '../loading.dart';

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
                title: 'جميع الفئات',
                icon: Icons.home,
                onTap: () async {
                  loading(context, 'loading');
                  List<Category> categories =
                      await CategoryController.getcategories();
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return CategoryScreen(
                      categories: categories,
                    );
                  }));
                },
              )
            ],
          ),
        ),
      );
    });
  }
}
