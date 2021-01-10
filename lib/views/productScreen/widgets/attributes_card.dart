import 'package:flutter/material.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/models/product_attribute.dart';
import 'package:qarinli/views/widgets/columnbuilder/columnbuilder.dart';
import 'package:qarinli/views/widgets/rowbuilder/rowbuilder.dart';

class AttributesCard extends StatelessWidget {
  final List<ProductAttribute> attributes;
  AttributesCard({@required this.attributes});
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15.0),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: ColumnBuilder(
          itemCount: attributes.length,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                shape: BoxShape.rectangle,
                border: Border.all(
                    width: 0.5,
                    color: AppThemeModel.isLight ? Colors.black : Colors.white),
              ),
              child: Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.2,
                    child: Text(attributes[index].name),
                  ),
                  SizedBox(
                    width: 6.0,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: RowBuilder(
                          itemCount: attributes[index].options.length,
                          itemBuilder: (BuildContext _context, int _index) {
                            String option = attributes[index].options[_index];
                            if (_index !=
                                attributes[index].options.length - 1) {
                              option += ', ';
                            }
                            return Text(option);
                          }),
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
