import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/category_controller.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/views/blogs_screen/blogs_screen.dart';
import 'package:qarinli/views/categories/category_screen.dart';
import 'package:qarinli/views/info/privacy.dart';
import 'package:qarinli/views/info/rules.dart';
import 'package:qarinli/views/settings/settings.dart';
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
                title: 'الصفحة الرئيسية',
                icon: Icons.home,
                onTap: () {},
              ),
              DrawerTab(
                title: 'جميع الفئات',
                icon: Icons.list_alt,
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
              ),
              DrawerTab(
                title: 'الدخول',
                icon: Icons.person,
                onTap: () {},
              ),
              DrawerTab(
                title: 'المفضلة',
                icon: Icons.favorite,
                onTap: () {},
              ),
              DrawerTab(
                title: 'الأعلى مبيعا',
                icon: Icons.arrow_circle_up,
                onTap: () {},
              ),
              DrawerTab(
                title: 'المدونة',
                icon: Icons.book,
                onTap: () {
                  loading(context, 'loading');
                  model.getBlogs(page: 1);
                  Navigator.pop(context);
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return BlogsScreen();
                  }));
                },
              ),
              DrawerTab(
                title: 'المتاجر',
                icon: Icons.shop_two,
                onTap: () {},
              ),
              DrawerTab(
                title: 'عروض السوبر ماركت',
                icon: Icons.local_offer_outlined,
                onTap: () {},
              ),
              DrawerTab(
                title: 'عروض الموضة',
                icon: Icons.local_offer,
                onTap: () {},
              ),
              // DrawerTab(
              //   title: 'انشاءمتجر',
              //   icon: Icons.add_shopping_cart,
              //   onTap: () {},
              // ),
              DrawerTab(
                title: 'سياسة الخصوصية',
                icon: Icons.policy,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Privacy();
                      },
                    ),
                  );
                },
              ),
              DrawerTab(
                title: 'الشروط والأحكام',
                icon: Icons.report,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return Rules();
                      },
                    ),
                  );
                },
              ),
              DrawerTab(
                title: 'الإعدادات',
                icon: Icons.settings,
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return Settings();
                  }));
                },
              ),
            ],
          ),
        ),
      );
    });
  }
}
