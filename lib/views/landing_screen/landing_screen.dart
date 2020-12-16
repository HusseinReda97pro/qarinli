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
  // final _pageController = PageController();
  // This group keeps track of the synchronized scroll offset.
  // final _scrollControllerGroup = LinkedScrollControllerGroup();

  // ScrollController _scrollControllerHomeTab;
  // ScrollController _scrollControllerFavouritesTab;
  // ScrollController _scrollControllerProductsTab;
  // ScrollController _scrollControllerMyQarinliTab;
  int _selectedTabIndex = 0;
  // ScrollController _scrollController;
  // List<ScrollController> _controllers;
  List<Widget> tabs;

  void initState() {
    super.initState();
    // print('************* initState ***********');
    // _scrollControllerHomeTab = ScrollController();
    // _scrollControllerFavouritesTab = ScrollController();
    // _scrollControllerProductsTab = ScrollController();
    // _scrollControllerMyQarinliTab = ScrollController();
    // _scrollControllerGroup.addAndGet()
    tabs = [
      HomeTab(
          // scrollController: _scrollControllerHomeTab,
          ),
      FavoritesTab(
          // scrollController: _scrollControllerFavouritesTab,
          ),
      ProductsTab(
          // scrollController: _scrollControllerProductsTab,
          ),
      MyQarinliTab(
          // scrollController: _scrollControllerMyQarinliTab,
          ),
    ];
    // _controllers = [
    //   _scrollControllerHomeTab,
    //   _scrollControllerFavouritesTab,
    //   _scrollControllerProductsTab,
    //   _scrollControllerMyQarinliTab
    // ];
  }

  void dispose() {
    // _pageController.dispose();
    // _scrollControllerHomeTab.dispose();
    // _scrollControllerFavouritesTab.dispose();
    // _scrollControllerProductsTab.dispose();
    // _scrollControllerMyQarinliTab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      // _scrollController = _scrollControllerHomeTab;
      return Scaffold(
        endDrawer: AppDrawer(),
        appBar: MainAppBar(
          context: context,
        ),
        // body: tabs[_selectedTabIndex],
        body: tabs[_selectedTabIndex],
        // PageView(
        //   controller: _pageController,
        //   children:

        //   onPageChanged: (_pageIndex) {},
        // ),
        bottomNavigationBar:
            // !_controllers[_selectedTabIndex].hasClients
            //     ? SizedBox.shrink()
            //     : AnimatedBuilder(
            //         animation: _controllers[_selectedTabIndex],
            //         builder: (context, child) {
            //           return
            Container(
          // height: _controllers[_selectedTabIndex]
          //             .position
          //             .userScrollDirection ==
          //         ScrollDirection.reverse
          //     ? 0
          //     : 60,
          height: (model.choosenLanddingIsLoading &
                  model.mobsLanddingIsLoading &
                  model.ainiaSha5siaLanddingIsLoading &
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
                setState(() {
                  _selectedTabIndex = index;
                  // _pageController.jumpToPage(_selectedTabIndex);
                  //   if (index == 0) {
                  //     _scrollController = _scrollControllerHomeTab;
                  //   }

                  if (index == 1 && model.currentUser != null) {
                    // _scrollController = _scrollControllerFavouritesTab;
                    String favorites = model.generateFavoritesList();
                    model.getCurrentProducts(favorites: favorites);
                  }

                  //   if (index == 2) {
                  //     _scrollController = _scrollControllerProductsTab;
                  //   }

                  //   if (index == 3) {
                  //     _scrollController = _scrollControllerMyQarinliTab;
                  //   }
                });
                // get sub categories for top categories
                // if (index == 2) {
                //   model.getStartPageSubCategories();
                // }
              }
            },
          ),
          // );
          // },
        ),
      );
    });
  }
}
