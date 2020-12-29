import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/landing_screen/tabs/favorites_tab.dart';
import 'package:qarinli/views/landing_screen/tabs/home_tab.dart';
import 'package:qarinli/views/landing_screen/tabs/my_qarinli_tap.dart';
import 'package:qarinli/views/landing_screen/tabs/products_tap.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

import 'package:qarinli/config/theme.dart';

class LanddingScreen extends StatefulWidget {
  @override
  _LanddingScreenState createState() => _LanddingScreenState();
}

class _LanddingScreenState extends State<LanddingScreen> {
  int _selectedTabIndex = 0;
  List<Widget> tabs;

  void initState() {
    super.initState();
    tabs = [
      HomeTab(),
      FavoritesTab(),
      ProductsTab(),
      MyQarinliTab(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        endDrawer: AppDrawer(),
        appBar: MainAppBar(
          context: context,
        ),
        body: tabs[_selectedTabIndex],
        bottomNavigationBar: Container(
          height: (model.mobsLanddingIsLoading &
                  model.atorLanddingIsLoading &
                  model.laptopsLanddingIsLoading &
                  model.modaLanddingIsLoading)
              ? 0
              : MediaQuery.of(context).size.height * 0.1 > 60
                  ? MediaQuery.of(context).size.height * 0.1 > 100
                      ? 85
                      : MediaQuery.of(context).size.height * 0.1
                  : 60,
          child: BottomNavigationBar(
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home_outlined),
                // label: 'Home',
                label: 'الرئيسية',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite_outline),
                // label: 'Favorites',
                label: 'المفضلة',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                // label: 'Products',
                label: 'المنتجات',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outline,
                ),
                // label: 'My Qarinli',
                label: 'قارنلي',
              ),
            ],
            currentIndex: _selectedTabIndex,
            selectedItemColor: Palette.midBlue,
            showUnselectedLabels: true,
            unselectedItemColor:
                theme == AppTheme.LIGHT ? Palette.black : Colors.white,
            onTap: (int index) {
              if (index != _selectedTabIndex) {
                setState(
                  () {
                    _selectedTabIndex = index;
                    if (index == 1 && model.currentUser != null) {
                      String favorites = model.generateFavoritesList();
                      model.getCurrentProducts(favorites: favorites);
                    }
                  },
                );
              }
            },
          ),
        ),
      );
    });
  }
}
