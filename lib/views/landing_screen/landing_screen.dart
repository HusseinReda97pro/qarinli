import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/cat_ids.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/landing_screen/widgets/Product_card_landing_screen.dart';
import 'package:qarinli/views/landing_screen/widgets/images_slider.dart';
import 'package:qarinli/views/landing_screen/widgets/more.dart';
import 'package:qarinli/views/landing_screen/widgets/section_image.dart';
import 'package:qarinli/views/landing_screen/widgets/shop_card.dart';
import 'package:qarinli/views/landing_screen/widgets/progress_indicator.dart';
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
            //TODO chooen items
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/moda.jpg',
            ),
            // TODO moda items
            //Laptops and computer
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/laptops.jpg',
            ),
            model.laptopsLanddingIsLoading
                ? ProgressIndicatorV2()
                : Container(
                    margin:
                        EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: RowBuilder(
                        itemCount: model.laptopsLanddingProducts.length,
                        itemBuilder: (BuildContext context, int index) {
                          return ProductCard(
                              product: model.laptopsLanddingProducts[index]);
                        },
                      ),
                    ),
                  ),
            MoreButton(
              categoryId: LAPTOPS_CAT_ID,
            ),
            //TODDO inaia ssha5ia
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/ania_sh5sia.jpg',
            ),
            // TODO aiana sha5isa
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/ator.jpg',
            ),
            // TODO aiana ator
            SectionImage(
              onTap: () {},
              imageUrl: 'assets/main_categories/mobs.jpg',
            ),
            // TODO aiana mobs
            SizedBox(
              height: 100.0,
            )
          ],
        ),
      );
    });
  }
}
