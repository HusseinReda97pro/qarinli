import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/landing_categories.dart';
import 'package:qarinli/config/filterr_category.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';
import 'package:qarinli/views/landing_screen/widgets/products_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/section_header.dart';
import 'package:qarinli/views/moda_offers/moda_offers.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class HomeTab extends StatefulWidget {
  final ScrollController scrollController;
  HomeTab({this.scrollController});
  @override
  _HomeTabState createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  TextEditingController searchController = TextEditingController();

  Widget _search(MainModel model, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50.0,
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.1,
        left: MediaQuery.of(context).size.width * 0.1,
        bottom: 20.0,
      ),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: TextField(
          controller: searchController,
          decoration: InputDecoration(
            prefixIcon: GestureDetector(
              onTap: () {
                if (searchController.text.isNotEmpty) {
                  model.getCurrentProducts(
                      pageNumber: 1,
                      filter: Filter(
                          search: searchController.text,
                          categories: [],
                          tags: []));
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return ProductsScreen();
                      },
                    ),
                  );
                }
              },
              child: Icon(
                Icons.search,
                size: 24,
                color: AppThemeModel.isLight ? Colors.black : Palette.yellow,
              ),
            ),
            hintText: 'بحث',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppThemeModel.isLight ? Colors.black : Colors.white,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color:
                    AppThemeModel.isLight ? Palette.midBlue : Palette.lightGrey,
                width: 2.0,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(50),
              borderSide: BorderSide(
                style: BorderStyle.solid,
                color:
                    AppThemeModel.isLight ? Palette.midBlue : Palette.lightGrey,
                width: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Widget _shopsSection() {
  //   return Column(children: [
  //     SectionHeader(
  //       title: 'علامات تجارية',
  //       onTap: () {
  //         Navigator.push(
  //           context,
  //           MaterialPageRoute(builder: (BuildContext context) {
  //             return ShopsScreen();
  //           }),
  //         );
  //       },
  //     ),
  //     Directionality(
  //       textDirection: TextDirection.rtl,
  //       child: SingleChildScrollView(
  //         scrollDirection: Axis.horizontal,
  //         child: Container(
  //           margin: EdgeInsets.symmetric(horizontal: 10),
  //           child: RowBuilder(
  //             itemCount: MediaQuery.of(context).size.width > 600 ? 15 : 10,
  //             itemBuilder: (BuildContext context, int index) {
  //               return ShopCard(
  //                 imageURL: 'assets/shops/' + (index + 1).toString() + '.jpg',
  //               );
  //             },
  //           ),
  //         ),
  //       ),
  //     )
  //   ]);
  // }

  Widget _comparisonSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'مقارنة',
        onTap: () {
          model.getCurrentMaxPrice(tags: [comparisonTag], categories: []);
          model.getFilterCategories(categoriesIds: filterCategories);
          model.getFilterTags(tagIds: filterTags);
          model.getCurrentProducts(
              pageNumber: 1,
              filter: Filter(tags: [comparisonTag], categories: []));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductsScreen();
              },
            ),
          );
        },
      ),
      ProductsSlider(
        isLoading: model.comparisonProductsLanddingIsLoading,
        products: model.comparisonLanddingProducts,
      ),
      SizedBox(
        height: 25.0,
      )
    ]);
  }

  Widget _modaSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'موضة',
        onTap: () async {
          // model.getCurrentProducts(
          //     pageNumber: 1, categoryId: MODA_CAT_ID, withoutOffers: true);
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (BuildContext context) {
          //       return ProductsScreen(
          //         categoryId: MODA_CAT_ID,
          //         withoutOffers: true,
          //         moda: true,
          //       );
          //     },
          //   ),
          // );
          model.getModaBlogs();
          model.getModaSubCategories();
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
      ProductsSlider(
        isLoading: model.modaLanddingIsLoading,
        products: model.modaLanddingProducts,
      ),
      SizedBox(
        height: 25.0,
      )
    ]);
  }

  Widget _laptopsSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'كمبيوتر ولابتوب',
        onTap: () async {
          model.getCurrentMaxPrice(categories: [laptopsCat], tags: []);
          model.getFilterCategories(categoriesIds: filterCategories);
          model.getFilterTags(tagIds: filterTags);

          model.getCurrentProducts(
              pageNumber: 1,
              filter: Filter(categories: [laptopsCat], tags: []));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductsScreen();
              },
            ),
          );
        },
      ),
      ProductsSlider(
        isLoading: model.laptopsLanddingIsLoading,
        products: model.laptopsLanddingProducts,
      ),
      SizedBox(
        height: 25.0,
      )
    ]);
  }

  Widget _atorSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'عطور',
        onTap: () async {
          model.getCurrentMaxPrice(categories: [atorCat], tags: []);
          model.getFilterCategories(categoriesIds: filterCategories);
          model.getFilterTags(tagIds: filterTags);

          model.getCurrentProducts(
            pageNumber: 1,
            filter: Filter(categories: [atorCat], tags: []),
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductsScreen();
              },
            ),
          );
        },
      ),
      ProductsSlider(
        isLoading: model.atorLanddingIsLoading,
        products: model.atorLanddingProducts,
      ),
      SizedBox(
        height: 25.0,
      )
    ]);
  }

  Widget _mobsSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'موبايلات وأجهزة تابلت واكسسواراتها',
        onTap: () async {
          model.getCurrentMaxPrice(categories: [mobsCat], tags: []);
          model.getFilterCategories(categoriesIds: filterCategories);
          model.getFilterTags(tagIds: filterTags);

          model.getCurrentProducts(
              pageNumber: 1, filter: Filter(categories: [mobsCat], tags: []));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductsScreen();
              },
            ),
          );
        },
      ),
      ProductsSlider(
        isLoading: model.mobsLanddingIsLoading,
        products: model.mobsLanddingProducts,
      ),
    ]);
  }

  Widget _homeEquipmentsSection(MainModel model, BuildContext context) {
    return Column(children: [
      SectionHeader(
        title: 'الأجهزة المنزلية',
        onTap: () async {
          model.getCurrentMaxPrice(categories: [homeEquipmentsCat], tags: []);
          model.getFilterCategories(categoriesIds: filterCategories);
          model.getFilterTags(tagIds: filterTags);
          model.getCurrentProducts(
              pageNumber: 1,
              filter: Filter(categories: [homeEquipmentsCat], tags: []));
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) {
                return ProductsScreen();
              },
            ),
          );
        },
      ),
      ProductsSlider(
        isLoading: model.homeEquipmentsIsLoading,
        products: model.homeEquipmentsLanddingProducts,
      ),
    ]);
  }

  Widget _landingList(MainModel model, scrollController) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        controller: scrollController,
        children: [
          _search(model, context),
          // _shopsSection(),
          _comparisonSection(model, context),
          _modaSection(model, context),
          _laptopsSection(model, context),
          _atorSection(model, context),
          _mobsSection(model, context),
          _homeEquipmentsSection(model, context),
          SizedBox(
            height: 100.0,
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return (model.mobsLanddingIsLoading &
              model.atorLanddingIsLoading &
              model.laptopsLanddingIsLoading &
              model.modaLanddingIsLoading)
          ? Spinner()
          : _landingList(model, widget.scrollController);
    });
  }
}
