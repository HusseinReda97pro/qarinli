import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';

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
      return model.favoritesProducts.length > 0
          ? ListView(
              children: [],
            )
          : Center(
              child: Text('there is no favorites yet.'),
            );
    });
  }
}
