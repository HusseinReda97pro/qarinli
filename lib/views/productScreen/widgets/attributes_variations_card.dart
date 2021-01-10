import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/product_attribute.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';

class AttributesVariationsCard extends StatefulWidget {
  final List<ProductAttribute> attributesVariations;
  AttributesVariationsCard({@required this.attributesVariations});

  @override
  State<StatefulWidget> createState() {
    return _AttributesVariationsCardState();
  }
}

class _AttributesVariationsCardState extends State<AttributesVariationsCard> {
  List<String> _selectedVariations = List.generate(10, (index) => '');
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ColumnBuilder(
          itemCount: widget.attributesVariations.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(4.0),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(widget.attributesVariations[index].name),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 6.0),
                    height: 30.0,
                    decoration: BoxDecoration(
                      borderRadius: new BorderRadius.only(
                        topLeft: const Radius.circular(6.0),
                        topRight: const Radius.circular(6.0),
                      ),
                      color: AppThemeModel.isLight
                          ? Palette.midBlue
                          : Colors.white,
                    ),
                    child: DropdownButton<String>(
                      value: _selectedVariations[index].isEmpty
                          ? null
                          : _selectedVariations[index],
                      dropdownColor: AppThemeModel.isLight
                          ? Palette.midBlue
                          : Colors.white,
                      iconEnabledColor: AppThemeModel.isLight
                          ? Palette.midBlue
                          : Palette.yellow,
                      hint: Text(
                        'تحديد أحد الخيارات',
                        style: TextStyle(
                          color: AppThemeModel.isLight
                              ? Colors.white
                              : Colors.black,
                        ),
                      ),
                      items: widget.attributesVariations[index].options
                          .map((String value) {
                        return new DropdownMenuItem<String>(
                          value: value,
                          child: Container(
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: new Text(
                                value,
                                style: TextStyle(
                                  color: AppThemeModel.isLight
                                      ? Colors.white
                                      : Palette.midBlue,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        //TODO selected values
                        setState(() {
                          _selectedVariations[index] = value;
                        });
                        print(widget.attributesVariations[index].name);
                        widget.attributesVariations[index].selectedValue =
                            value;
                        print(value);
                        print(widget.attributesVariations[index].id);
                      },
                    ),
                  )
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
