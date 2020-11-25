import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/category_ids.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/ProductsScreen/products_screen.dart';
import 'package:qarinli/views/landing_screen/widgets/images_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/products_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/section_header.dart';
import 'package:qarinli/views/landing_screen/widgets/section_image.dart';
import 'package:qarinli/views/landing_screen/widgets/shop_card.dart';
import 'package:qarinli/views/shops/shops.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/loading.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

import 'package:flutter_skeleton/flutter_skeleton.dart';

class LanddingScreen extends StatefulWidget {
  @override
  _LanddingScreenState createState() => _LanddingScreenState();
}

class _LanddingScreenState extends State<LanddingScreen> {
  TextEditingController searchController = TextEditingController();

  Widget _search(context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.7,
      height: 50.0,
      // decoration: BoxDecoration(
      //   borderRadius: BorderRadius.circular(
      //     50,
      //   ),
      //   border: Border.all(
      //     style: BorderStyle.solid,
      //     color: Palette.midBlue,
      //     width: 2.0,
      //   ),
      // ),
      margin: EdgeInsets.only(
        right: MediaQuery.of(context).size.width * 0.1,
        left: MediaQuery.of(context).size.width * 0.1,
        bottom: 20.0,
      ),
      child: TextField(
        controller: searchController,
        decoration: InputDecoration(
          prefixIcon: GestureDetector(
            onTap: () {
              //TODO serach
            },
            child: Icon(
              Icons.search,
              size: 24,
              color: Colors.grey[600],
            ),
          ),
          hintText: 'Search',
          hintStyle:
              TextStyle(fontWeight: FontWeight.w600, color: Palette.lightBlue),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Palette.midBlue,
              width: 2.0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Palette.midBlue,
              width: 2.0,
            ),
          ),
        ),
      ),
    );
  }

  Widget _landingList(model) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: ListView(
        children: [
          _search(context),
          ImagesSlider(),
          // SectionImage(
          //   onTap: () {},
          //   imageUrl: 'assets/main_categories/gloabl_markets.jpg',
          // ),
          SectionHeader(
            title: 'متاجر عالمية',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (BuildContext context) {
                  return ShopsScreen();
                }),
              );
            },
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: RowBuilder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ShopCard(
                    imageURL: 'assets/shops/' + (index + 1).toString() + '.jpg',
                  );
                },
              ),
            ),
          ),
          // Row(
          //   children: [
          Container(
            margin: EdgeInsets.all(10),
            child: Text(
              'أختارنا لك',
              style: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.0,
              ),
            ),
          ),
          Expanded(
            child: SizedBox(),
          ),
          ProductsSlider(
            isLoading: model.choosenLanddingIsLoading,
            products: model.choosenLanddingProducts,
          ),

          SizedBox(
            height: 25,
          ),
          SectionHeader(
            title: 'موضه',
            onTap: () async {
              loading(context, 'looding');
              model.currentProducts.clear();
              model.currentProducts = await model.productsController
                  .getProducts(
                      page: 2, categoryId: MODA_CAT_ID, withoutOffers: true);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductsScreen(
                      categoryId: MODA_CAT_ID,
                      withoutOffers: true,
                    );
                  },
                ),
              );
            },
          ),
          ProductsSlider(
            isLoading: model.modaLanddingIsLoading,
            products: model.modaLanddingProducts,
            categoryId: MODA_CAT_ID,
            withoutOffers: true,
          ),
          //Laptops and computer

          SizedBox(
            height: 25,
          ),
          SectionHeader(
            title: 'كمبيوتر ولابتوب',
            onTap: () async {
              loading(context, 'looding');
              model.currentProducts.clear();
              model.currentProducts = await model.productsController
                  .getProducts(
                      page: 2,
                      categoryId: LAPTOPS_CAT_ID,
                      withoutOffers: false);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductsScreen(
                      categoryId: LAPTOPS_CAT_ID,
                      withoutOffers: false,
                    );
                  },
                ),
              );
            },
          ),
          ProductsSlider(
            isLoading: model.laptopsLanddingIsLoading,
            products: model.laptopsLanddingProducts,
            categoryId: LAPTOPS_CAT_ID,
            withoutOffers: false,
          ),
          SizedBox(
            height: 25,
          ),
          SectionHeader(
            title: 'العناية الشخصية',
            onTap: () async {
              loading(context, 'looding');
              model.currentProducts.clear();
              model.currentProducts =
                  await model.productsController.getProducts(
                page: 2,
                categoryId: AINIA_SHA5SIA_CAT_ID,
                withoutOffers: true,
              );
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductsScreen(
                      categoryId: AINIA_SHA5SIA_CAT_ID,
                      withoutOffers: true,
                    );
                  },
                ),
              );
            },
          ),
          ProductsSlider(
            isLoading: model.ainiaSha5siaLanddingIsLoading,
            products: model.ainiaSha5siaLanddingProducts,
            categoryId: AINIA_SHA5SIA_CAT_ID,
            withoutOffers: true,
          ),

          SizedBox(
            height: 25,
          ),
          SectionHeader(
            title: 'عطور',
            onTap: () async {
              loading(context, 'looding');
              model.currentProducts.clear();
              model.currentProducts =
                  await model.productsController.getProducts(
                page: 2,
                categoryId: ATOR_CAT_ID,
                withoutOffers: true,
              );
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductsScreen(
                      categoryId: ATOR_CAT_ID,
                      withoutOffers: true,
                    );
                  },
                ),
              );
            },
          ),
          ProductsSlider(
            isLoading: model.atorLanddingIsLoading,
            products: model.atorLanddingProducts,
            categoryId: ATOR_CAT_ID,
            withoutOffers: true,
          ),
          SizedBox(
            height: 25,
          ),
          SectionHeader(
            title: 'كمبيوتر ولابتوب',
            onTap: () async {
              loading(context, 'looding');
              model.currentProducts.clear();
              model.currentProducts = await model.productsController
                  .getProducts(
                      page: 2, categoryId: MOBS_CAT_ID, withoutOffers: false);
              Navigator.of(context).pop();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (BuildContext context) {
                    return ProductsScreen(
                      categoryId: MOBS_CAT_ID,
                      withoutOffers: false,
                    );
                  },
                ),
              );
            },
          ),
          ProductsSlider(
            isLoading: model.mobsLanddingIsLoading,
            products: model.mobsLanddingProducts,
            categoryId: MOBS_CAT_ID,
            withoutOffers: true,
          ),
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
      return Scaffold(
          endDrawer: AppDrawer(),
          appBar: MainAppBar(
            context: context,
          ),
          body: (model.choosenLanddingIsLoading &
                  model.mobsLanddingIsLoading &
                  model.ainiaSha5siaLanddingIsLoading &
                  model.atorLanddingIsLoading &
                  model.laptopsLanddingIsLoading &
                  model.modaLanddingIsLoading)
              ? ListSkeleton(
                  style: SkeletonStyle(
                    theme: SkeletonTheme.Light,
                    isShowAvatar: false,
                    barCount: 3,
                    colors: [
                      Color(0xffcccccc),
                      Palette.midBlue,
                      Color(0xff333333)
                    ],
                    isAnimation: true,
                  ),
                )
              :
              // : MediaQuery.of(context).size.width > 600
              //     ? Row(
              //         children: [
              //           Expanded(child: SizedBox()),
              //           Expanded(child: _landingList(model)),
              //           Expanded(child: SizedBox()),
              //         ],
              //       )
              //     :
              _landingList(model));
    });
  }
}
