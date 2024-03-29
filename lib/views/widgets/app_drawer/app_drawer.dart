import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/landing_categories.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/Favorites/favorites_scerren.dart';
import 'package:qarinli/views/auth/login_screen.dart';
import 'package:qarinli/views/blogs_screen/blogs_screen.dart';
import 'package:qarinli/views/cart/cart_screen.dart';
import 'package:qarinli/views/info/privacy.dart';
import 'package:qarinli/views/info/rules.dart';
import 'package:qarinli/views/landing_screen/landing_screen.dart';
import 'package:qarinli/views/moda_offers/moda_offers.dart';
import 'package:qarinli/views/settings/settings.dart';
import 'package:qarinli/views/top_categories/top_categories_scerren.dart';
import 'package:qarinli/views/widgets/alert_message.dart';
import 'package:qarinli/views/widgets/app_drawer/widgets/drawer_tab.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Drawer(
        child: Directionality(
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return LanddingScreen();
                      },
                    ),
                  );
                },
              ),
              DrawerTab(
                title: 'جميع الفئات',
                icon: Icons.list_alt,
                onTap: () async {
                  // loading(context, 'loading');
                  // List<Category> categories =
                  //     await CategoryController.getcategories();
                  // Navigator.pop(context);
                  // Navigator.push(context,
                  //     MaterialPageRoute(builder: (BuildContext context) {
                  //   return CategoryScreen(
                  //     categories: categories,
                  //   );
                  // }));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return TopCategoriesScreen();
                      },
                    ),
                  );
                },
              ),
              model.currentUser == null
                  ? DrawerTab(
                      title: 'الدخول',
                      icon: Icons.person,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return LoginScreen();
                          }),
                        );
                      },
                    )
                  : DrawerTab(
                      title: 'تسجيل الخروج',
                      icon: Icons.person,
                      onTap: () {
                        model.logout().then((logedout) {
                          print(logedout);
                          if (logedout) {
                            showAlertMessage(
                                context: context,
                                title: 'تم بنجاح',
                                message: Text('تم تسجيل الخروج بنجاح'));
                          } else {
                            showAlertMessage(
                                context: context,
                                title: 'فشلت العملية',
                                message: Text('حدث خطأ غير معروفس'));
                          }
                        });
                        // Navigator.pushReplacement(
                        //   context,
                        //   MaterialPageRoute(builder: (BuildContext context) {
                        //     return LanddingScreen();
                        //   }),
                        // );
                      },
                    ),
              model.currentUser == null
                  ? SizedBox.shrink()
                  : DrawerTab(
                      title: 'سلة التسوق',
                      icon: MdiIcons.cart,
                      onTap: () {
                        if (model.currentUser != null) {
                          model.getCurrentCart(
                              userToken: model.currentUser.token);
                        }
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (BuildContext context) {
                            return CartScreen();
                          }),
                        );
                      },
                    ),
              DrawerTab(
                title: 'المفضلة',
                icon: Icons.favorite,
                onTap: () {
                  if (model.currentUser != null) {
                    String favorites = model.generateFavoritesList();
                    model.getCurrentProducts(favorites: favorites);
                  }
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) {
                      return FavoritesScreen();
                    }),
                  );
                },
              ),
              // DrawerTab(
              //   title: 'الأعلى مبيعا',
              //   icon: Icons.arrow_circle_up,
              //   onTap: () {
              //     model.getCurrentProducts(topSales: true);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) {
              //           return ProductsScreen(
              //             topSales: true,
              //           );
              //         },
              //       ),
              //     );
              //   },
              // ),
              // DrawerTab(
              //   title: 'المدونة',
              //   icon: Icons.book,
              //   onTap: () {
              //     loading(context, 'loading');
              //     model.getBlogs(page: 1);
              //     Navigator.pop(context);
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (BuildContext context) {
              //           return BlogsScreen();
              //         },
              //       ),
              //     );
              //   },
              // ),
              // DrawerTab(
              //   title: 'علامات تجارية',
              //   icon: Icons.shop_two,
              //   onTap: () {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(builder: (BuildContext context) {
              //         return ShopsScreen();
              //       }),
              //     );
              //   },
              // ),
              DrawerTab(
                title: 'عروض السوبر ماركت',
                icon: Icons.local_offer_outlined,
                onTap: () {
                  model.getBlogs(page: 1, categoryId: SUPERMARKET_CAT_ID);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return BlogsScreen();
                      },
                    ),
                  );
                },
              ),
              DrawerTab(
                title: 'عروض الموضة',
                icon: Icons.local_offer,
                onTap: () {
                  model.getModaBlogs();
                  // model.getModaSubCategories(topCategories[6].subCategories);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ModaOffersScreen();
                      },
                    ),
                  );
                },
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
