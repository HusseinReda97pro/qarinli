import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/filter.dart';
import 'package:qarinli/views/sub_category_screen/sub_category_screen.dart';

class SubCategoryCard extends StatelessWidget {
  final Category category;
  final bool isSubcategoryScreen;
  SubCategoryCard({this.category, this.isSubcategoryScreen = false});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return GestureDetector(
        onTap: () {
          model.currentCategory = category;
          model.getCurrentProducts(
              pageNumber: 1, filter: Filter(tags: [], categories: [category]));
          model.getSubCategories();
          if (isSubcategoryScreen) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubCategoryScreen();
                },
              ),
            );
          } else {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (BuildContext context) {
                  return SubCategoryScreen();
                },
              ),
            );
          }
        },
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            width: MediaQuery.of(context).size.width * 0.95,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0),
                side: BorderSide(color: Palette.midBlue, width: 2),
              ),
              child: Container(
                padding: EdgeInsets.all(10.0),
                child: Text(
                  category.name,
                  style: TextStyle(
                    color:
                        AppThemeModel.isLight() ? Colors.black : Palette.yellow,
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
