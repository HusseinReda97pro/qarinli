import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/moda_filter.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/models/attribute.dart';
import 'package:qarinli/models/category.dart';
import 'package:qarinli/models/tag.dart';
import 'package:qarinli/views/ProductsScreen/widgets/filter/tag_filter_card.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

import 'attribute_card.dart';
import 'category_filter_card.dart';

class FilterSheet extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _FilterSheetState();
  }
}

class _FilterSheetState extends State<FilterSheet> {
  // int _selectedAttrbute = -1;
  // Map<String, bool> _checkBoxs = {};
  List<Attribute> _attributesFilter = modaAttributesFilter;

  Widget _categoryFilter({@required MainModel model, BuildContext context}) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: RowBuilder(
              itemCount: model.filterToApply.categories != null
                  ? model.filterToApply.categories.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                return CategoryFilterCard(
                    category: model.filterToApply.categories[index]);
              },
            ),
          ),
        ),
        DropdownButton<String>(
          hint: Text('أختار التصنيف'),
          icon: Icon(
            Icons.list,
            color: AppThemeModel.isLight() ? Palette.midBlue : Palette.yellow,
          ),
          dropdownColor:
              AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
          items: model.filterCategories.map((Category category) {
            return DropdownMenuItem<String>(
              value: category.id.toString(),
              child: Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    category.name + ' (' + category.count.toString() + ')',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppThemeModel.isLight()
                          ? Colors.white
                          : Palette.midBlue,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (catId) {
            model.selectCategoryToFilter(categoryId: int.parse(catId));
          },
        )
      ],
    );
  }

  Widget _tagFilter({@required MainModel model, BuildContext context}) {
    return Column(
      children: [
        SingleChildScrollView(
          child: Directionality(
            textDirection: TextDirection.rtl,
            child: RowBuilder(
              itemCount: model.filterToApply.tags != null
                  ? model.filterToApply.tags.length
                  : 0,
              itemBuilder: (BuildContext context, int index) {
                return TagFilterCard(tag: model.filterToApply.tags[index]);
              },
            ),
          ),
        ),
        DropdownButton<String>(
          hint: Text('أختار النوع'),
          icon: Icon(
            Icons.list,
            color: AppThemeModel.isLight() ? Palette.midBlue : Palette.yellow,
          ),
          dropdownColor:
              AppThemeModel.isLight() ? Palette.midBlue : Colors.white,
          items: model.filterTags.map((Tag tag) {
            return DropdownMenuItem<String>(
              value: tag.id.toString(),
              child: Container(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: new Text(
                    tag.name + ' (' + tag.count.toString() + ')',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      color: AppThemeModel.isLight()
                          ? Colors.white
                          : Palette.midBlue,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
          onChanged: (tagId) {
            model.selectTagToFilter(tagId: int.parse(tagId));
          },
        )
      ],
    );
  }

  bool contains(List<Category> categories) {
    for (Category cat in categories) {
      if ([2163, 798, 799, 800, 1093, 1084, 801, 1066, 1065].contains(cat.id))
        return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return Scaffold(
          // backgroundColor: Colors.green,
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
              // color: Colors.red,
              height: MediaQuery.of(context).size.height * 0.49,
              child: ListView(
                padding: EdgeInsets.all(10.0),
                children: [
                  Text(
                    'تصفية بواسطة السعر',
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(
                    '${model.filterToApply.minPrice} رس - ${model.filterToApply.maxPrice} رس',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18.0),
                  ),
                  RangeSlider(
                    values: RangeValues(model.filterToApply.minPrice.toDouble(),
                        model.filterToApply.maxPrice.toDouble()),
                    min: 0.0,
                    max: model.maxPriceSliderLimt.toDouble(),
                    divisions: 100,
                    activeColor: AppThemeModel.isLight()
                        ? Palette.midBlue
                        : Palette.yellow,
                    onChanged: (RangeValues newvalues) {
                      setState(() {
                        model.filterToApply.minPrice = newvalues.start.toInt();
                        model.filterToApply.maxPrice = newvalues.end.toInt();
                      });
                    },
                    labels: RangeLabels('${model.filterToApply.minPrice} رس',
                        '${model.filterToApply.maxPrice} رس'),
                  ),
                  contains(model.filterToApply.categories != null
                          ? model.filterToApply.categories
                          : [])
                      ? SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Directionality(
                            textDirection: TextDirection.rtl,
                            child: RowBuilder(
                              itemCount: _attributesFilter.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: () {
                                    model.filterToApply.attribute =
                                        _attributesFilter[index];
                                    model.getCurrentAttributeTermas(
                                        attributeId:
                                            _attributesFilter[index].id);
                                  },
                                  child: AtributeCard(
                                    attribute: _attributesFilter[index],
                                    isSelected:
                                        model.filterToApply.attribute?.id ==
                                            _attributesFilter[index].id,
                                  ),
                                );
                              },
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                  model.currentAttributeTermasIsLoading
                      ? Center(
                          child: Container(
                              margin: EdgeInsets.all(6.0),
                              child: CircularProgressIndicator()))
                      : Directionality(
                          textDirection: TextDirection.ltr,
                          child: ColumnBuilder(
                            itemCount:
                                model.filterToApply.attributeTermas.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Container(
                                width: MediaQuery.of(context).size.width * 0.6,
                                child: CheckboxListTile(
                                    title: Text(model.filterToApply
                                            .attributeTermas[index].name +
                                        ' (' +
                                        model.filterToApply
                                            .attributeTermas[index].count
                                            .toString() +
                                        ')'),
                                    value: model.filterToApply
                                        .attributeTermas[index].isSelected,
                                    onChanged: (bool selected) {
                                      model.selectAttributeTermas(
                                          index: index, selected: selected);
                                      // setState(() {
                                      //   model
                                      //       .filterToApply
                                      //       .attributeTermas[index]
                                      //       .isSelected = selected;
                                      // });
                                    }),
                              );
                            },
                          ),
                        ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'تصنيفات المنتج',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  _categoryFilter(model: model, context: context),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 6.0),
                    child: Text(
                      'نوع المنتج',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ),
                  _tagFilter(model: model, context: context),
                  SizedBox(
                    height: 15.0,
                  ),
                  RaisedButton(
                    color: AppThemeModel.isLight()
                        ? Palette.midBlue
                        : Colors.white,
                    onPressed: () async {
                      model.currentFilter = model.filterToApply;
                      model.getCurrentProducts(
                          filter: model.currentFilter, pageNumber: 1);
                      Navigator.pop(context);
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
