import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/category.dart';

class CategoryFilterCard extends StatelessWidget {
  final Category category;
  CategoryFilterCard({@required this.category});
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Card(
        margin: EdgeInsets.all(4.0),
        color: AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
        child: Container(
          margin: EdgeInsets.all(4.0),
          child: Row(
            children: [
              Text(
                category.name,
                style: TextStyle(
                  color:
                      AppThemeModel.isLight() ? Colors.white : Palette.midBlue,
                ),
              ),
              GestureDetector(
                onTap: () {
                  model.removeCategoryFromFilter(categoryId: category.id);
                },
                child: Icon(
                  Icons.close,
                  size: 16.0,
                  color:
                      AppThemeModel.isLight() ? Colors.white : Palette.midBlue,
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
