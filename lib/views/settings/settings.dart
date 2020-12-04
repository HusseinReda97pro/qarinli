import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MainAppBar(
        context: context,
      ),
      endDrawer: AppDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          children: [
            Center(
                child: Text(
              'الإعدادات',
              style: TextStyle(
                  fontSize: 26.0,
                  color:
                      theme == AppTheme.LIGHT ? Palette.black : Colors.white),
            )),
            Divider(),
            Row(
              children: [
                Switch(
                    activeColor: Colors.white,
                    value: theme == AppTheme.LIGHT ? false : true,
                    onChanged: (_) async {
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString(
                          'theme', theme == AppTheme.LIGHT ? 'dark' : 'light');
                      Phoenix.rebirth(context);
                    }),
                Container(
                  margin: EdgeInsets.all(10.0),
                  child: Text(
                    'الوضع الليلي',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
