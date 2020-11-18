import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/category_ids.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/landing_screen/widgets/images_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/products_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/section_image.dart';
import 'package:qarinli/views/landing_screen/widgets/shop_card.dart';
import 'package:qarinli/views/shops/shops.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

class LanddingScreen extends StatefulWidget {
  @override
  _LanddingScreenState createState() => _LanddingScreenState();
}

class _LanddingScreenState extends State<LanddingScreen> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
        appBar: MainAppBar(
          context: context,
        ),
        body: ListView(
          children: [
            ImagesSlider(),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/gloabl_markets.jpg',
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: RowBuilder(
                itemCount: 10,
                itemBuilder: (BuildContext context, int index) {
                  return ShopCard(
                    imageURL: 'assets/shops/' + (index + 1).toString() + '.jpg',
                  );
                },
              ),
            ),
            Row(
              children: [
                Expanded(child: SizedBox()),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (BuildContext context) {
                          return ShopsScreen();
                        }),
                      );
                    },
                    child: Text(
                      'المزيد',
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 18.0,
                          decoration: TextDecoration.underline),
                    ),
                  ),
                )
              ],
            ),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/choosen.jpg',
            ),
            ProductsSlider(
              isLoading: model.choosenLanddingIsLoading,
              products: model.choosenLanddingProducts,
              categoryId: CHOOSEN_CAT_ID,
              withoutOffers: true,
            ),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/moda.jpg',
            ),
            ProductsSlider(
              isLoading: model.modaLanddingIsLoading,
              products: model.modaLanddingProducts,
              categoryId: MODA_CAT_ID,
              withoutOffers: true,
            ),
            //Laptops and computer
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/laptops.jpg',
            ),
            ProductsSlider(
              isLoading: model.laptopsLanddingIsLoading,
              products: model.laptopsLanddingProducts,
              categoryId: LAPTOPS_CAT_ID,
              withoutOffers: false,
            ),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/ania_sh5sia.jpg',
            ),
            ProductsSlider(
              isLoading: model.ainiaSha5siaLanddingIsLoading,
              products: model.ainiaSha5siaLanddingProducts,
              categoryId: AINIA_SHA5SIA_CAT_ID,
              withoutOffers: true,
            ),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/ator.jpg',
            ),
            ProductsSlider(
              isLoading: model.atorLanddingIsLoading,
              products: model.atorLanddingProducts,
              categoryId: ATOR_CAT_ID,
              withoutOffers: true,
            ),
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/mobs.jpg',
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
    });
  }
}
