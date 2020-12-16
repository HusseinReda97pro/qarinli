import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/ProductsScreen/widgets/product_card.dart';
import 'package:qarinli/views/unlogedin_user.dart';
import 'package:qarinli/views/widgets/spinner.dart';

class FavoritesTab extends StatefulWidget {
  // final ScrollController scrollController;

  // FavoritesTab({@required this.scrollController});
  @override
  _FavoritesTabState createState() => _FavoritesTabState();
}

class _FavoritesTabState extends State<FavoritesTab> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return model.currentUser == null
          ? UnLogedinUser()
          : model.currentUser.favoritesProducts.length > 0
              ? model.currentProductsIsLoading
                  ? Spinner()
                  : model.currentProducts.length > 0
                      ? ListView.builder(
                          itemCount: model.currentProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCard(
                                product: model.currentProducts[index]);
                          })
                      : Center(
                          child: Text(
                            // 'there is no favorites yet.'
                            'لا يوجد منتجات مفضلة بعد.',
                            textDirection: TextDirection.rtl,
                          ),
                        )
              : Center(
                  child: Text(
                    // 'there is no favorites yet.'
                    'لا يوجد منتجات مفضلة بعد.',
                    textDirection: TextDirection.rtl,
                  ),
                );
    });
  }
}
