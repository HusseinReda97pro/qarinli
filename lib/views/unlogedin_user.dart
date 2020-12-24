import 'package:flutter/material.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';

class UnLogedinUser extends StatelessWidget {
  final bool fullScreen;
  UnLogedinUser({this.fullScreen = false});
  @override
  Widget build(BuildContext context) {
    return fullScreen
        ? Scaffold(
            appBar: MainAppBar(
              context: context,
            ),
            endDrawer: AppDrawer(),
            body: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.125),
                  child: Icon(
                    Icons.report_problem,
                    size: MediaQuery.of(context).size.width * 0.7,
                    color: Color(0XFFC5C5C5),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.16),
                  width: MediaQuery.of(context).size.width * 0.75,
                  child: Text(
                    'برجاء تسجيل الدخول أولاً لكي تتمكن من إضافة منتجات مفضلة',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: AppThemeModel.isLight()
                            ? Palette.black
                            : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w700),
                  ),
                ),
                SizedBox(
                  height: 4.0,
                ),
                Container(
                  margin: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.25),
                  child: RaisedButton(
                    color: AppThemeModel.isLight()
                        ? Colors.white
                        : Palette.midBlue,
                    shape: RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(18.0),
                        side: BorderSide(color: Palette.black)),
                    child: Text(
                      'تسجيل الدخول',
                      style: TextStyle(
                          color: AppThemeModel.isLight()
                              ? Palette.midBlue
                              : Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w900),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                  ),
                ),
                Expanded(
                  child: SizedBox(),
                ),
              ],
            ),
          )
        : ListView(
            // crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.125),
                child: Icon(
                  Icons.report_problem,
                  size: MediaQuery.of(context).size.width * 0.7,
                  color: Color(0XFFC5C5C5),
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.16),
                width: MediaQuery.of(context).size.width * 0.75,
                child: Text(
                  'برجاء تسجيل الدخول أولاً لكي تتمكن من إضافة منتجات مفضلة',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: AppThemeModel.isLight()
                          ? Palette.black
                          : Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w700),
                ),
              ),
              SizedBox(
                height: 4.0,
              ),
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.25),
                child: RaisedButton(
                  color:
                      AppThemeModel.isLight() ? Colors.white : Palette.midBlue,
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Palette.black)),
                  child: Text(
                    'تسجيل الدخول',
                    style: TextStyle(
                        color: AppThemeModel.isLight()
                            ? Palette.midBlue
                            : Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w900),
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, '/login');
                  },
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
            ],
          );
  }
}
