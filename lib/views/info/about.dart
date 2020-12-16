import 'package:flutter/material.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class About extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      endDrawer: AppDrawer(),
      body: ListView(
        children: [
          Directionality(
            textDirection: TextDirection.rtl,
            child: Center(
              child: Text(
                'معلومات عن قارنلي',
                style: TextStyle(fontSize: 24.0),
              ),
            ),
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Text(
                'قارنلي هو الموقع الالكتروني الشامل لمقارنة الأسعار في السعودية، إذ يحتوي على آلاف المنتجات المعروضة من مئات المتاجر الالكترونية. يمكنكم البحث في هذا الموقع على منتجات من مختلف الفئات مثل الالكترونيات والأدوات المنزلية والملابس وغيرها من المنتجات .',
                textAlign: TextAlign.right,
                style: TextStyle(fontSize: 16.0),
              ),
            ),
          ),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
