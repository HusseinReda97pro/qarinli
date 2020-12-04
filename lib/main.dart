// import 'package:device_preview/device_preview.dart';
import 'package:dynamic_theme/dynamic_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/dark_theme.dart';
import 'package:qarinli/config/light_theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/landing_screen/landing_screen.dart';
import 'package:qarinli/views/splash_screen/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'config/theme.dart';

void main() {
  runApp(
      // DevicePreview(
      // enabled: !kReleaseMode,
      // builder: (context) => MyApp(), // Wrap your app
      // ),
      Phoenix(child: MyApp()));
}

class MyApp extends StatelessWidget {
  static MainModel mainModel;

  @override
  Widget build(BuildContext context) {
    mainModel = MainModel();
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences.getInstance().then((prefs) {
      String appTheme = prefs.getString('theme');
      if (appTheme == null) {
        theme = AppTheme.DARK;
      } else {
        if (appTheme == 'light') {
          theme = AppTheme.LIGHT;
        } else {
          if (appTheme == 'dark') {
            theme = AppTheme.DARK;
          }
        }
      }
    });
    return ChangeNotifierProvider(
      create: (context) => mainModel,
      child: DynamicTheme(
        defaultBrightness:
            theme == AppTheme.LIGHT ? Brightness.light : Brightness.dark,
        data: (brightness) => theme == AppTheme.LIGHT ? lighTheme : darkTheme,
        themedWidgetBuilder: (context, _theme) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            // // for RTL dirctions
            // localizationsDelegates: [
            //   GlobalMaterialLocalizations.delegate,
            //   GlobalWidgetsLocalizations.delegate,
            // ],
            // supportedLocales: [
            //   Locale("ar"),
            // ],
            // locale: Locale("ar"),
            // //
            title: 'Qarinli',
            theme: _theme,
            home: SplashScreen(),
            routes: {
              '/landing': (BuildContext context) => LanddingScreen(),
            },
          );
        },
      ),
    );
  }
}
