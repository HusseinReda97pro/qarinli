import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:qarinli/views/info/data/privacy.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class Privacy extends StatelessWidget {
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
              textDirection: TextDirection.rtl, child: Html(data: privacyHTML)),
          SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
