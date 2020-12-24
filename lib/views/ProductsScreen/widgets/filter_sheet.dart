import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';

class FilterSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterSheetState();
  }
}

class _FilterSheetState extends State<FilterSheet> {
  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
          body: Directionality(
        textDirection: TextDirection.rtl,
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              color: AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
              child: Text(
                'تصفية المنتجات',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: AppThemeModel.isLight()
                        ? Colors.white
                        : Palette.midBlue,
                    fontSize: 24.0),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.4,
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  Text(
                    'تصفية بواسطة السعر',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    '${model.currentFilter.minPrice} رس - ${model.currentFilter.maxPrice} رس',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  RangeSlider(
                    values: RangeValues(model.currentFilter.minPrice.toDouble(),
                        model.currentFilter.maxPrice.toDouble()),
                    min: 0.0,
                    max: 50000.0,
                    divisions: 100,
                    activeColor: AppThemeModel.isLight()
                        ? Palette.midBlue
                        : Palette.yellow,
                    onChanged: (RangeValues newvalues) {
                      setState(() {
                        model.currentFilter.minPrice = newvalues.start.toInt();
                        model.currentFilter.maxPrice = newvalues.end.toInt();
                      });
                    },
                    labels: RangeLabels('${model.currentFilter.minPrice} رس',
                        '${model.currentFilter.maxPrice} رس'),
                  ),
                  RaisedButton(
                    color: AppThemeModel.isLight()
                        ? Palette.midBlue
                        : Colors.white,
                    onPressed: () {
                      //TODO filter
                    },
                    child: Text(
                      'تصفية',
                      style: TextStyle(
                          color: AppThemeModel.isLight()
                              ? Colors.white
                              : Palette.midBlue,
                          fontSize: 24.0),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ));
    });
  }
}
