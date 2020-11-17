import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/landing_screen/landing_screen.dart';
import 'package:qarinli/views/splash_screen/splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  static final MainModel mainModel = MainModel();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => mainModel,
      child: MaterialApp(
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
        title: 'Qarinli ',
        theme: appTheme,
        home: SplashScreen(),
        routes: {
          '/landing': (BuildContext context) => LanddingScreen(),
        },
      ),
    );
  }
}
