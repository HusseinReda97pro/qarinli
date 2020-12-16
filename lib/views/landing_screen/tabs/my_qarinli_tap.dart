import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
// import 'package:in_app_review/in_app_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/info/about.dart';
import 'package:qarinli/views/info/privacy.dart';
import 'package:qarinli/views/info/rules.dart';
import 'package:qarinli/views/landing_screen/tabs/my_qarinli_widgets/my_qarinli_card.dart';
import 'package:qarinli/views/settings/settings.dart';

class MyQarinliTab extends StatefulWidget {
  // final ScrollController scrollController;
  // MyQarinliTab({this.scrollController});

  @override
  _MyQarinliTabState createState() => _MyQarinliTabState();
}

class _MyQarinliTabState extends State<MyQarinliTab> {
  // final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, chlild) {
      return ListView(
        // controller: widget.scrollController,

        children: [
          Container(
            color: Color(0XFF4D4A4D),
            padding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
            child: Text(
              // 'My Qarinli',
              'قارنلي',
              textDirection: TextDirection.rtl,
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.grey,
          ),
          Stack(
            children: [
              Container(
                color:
                    theme == AppTheme.LIGHT ? Color(0XFF4D4A4D) : Colors.white,
                height: 230,
                padding: EdgeInsets.all(10.0),
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      model.currentUser != null
                          ? Text(
                              // 'Logged in as',
                              ' مسجل الدخول كـ ' + model.currentUser.username,
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  fontSize: 24,
                                  color: theme == AppTheme.LIGHT
                                      ? Colors.white
                                      : Colors.black),
                            )
                          : Row(
                              children: <Widget>[
                                Text(
                                  'لم تقم بتسجيل الدخول بعد.',
                                  style: TextStyle(
                                      color: AppThemeModel.isLight()
                                          ? Colors.white
                                          : Colors.black),
                                ),
                                SizedBox(
                                  width: 2.0,
                                ),
                                GestureDetector(
                                  child: Container(
                                    margin: EdgeInsets.only(right: 3.0),
                                    child: Text(
                                      'سجل الدخول الأن',
                                      style: TextStyle(
                                          color: Palette.midBlue,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w600,
                                          decoration: TextDecoration.underline),
                                    ),
                                  ),
                                  onTap: () {
                                    Navigator.pushNamed(context, '/login');
                                  },
                                ),
                              ],
                            ),
                      MyQarinliCard(
                        // text: 'Notifications',
                        text: 'الإشعارات',
                        icon: Icons.alarm,
                        onTap: () {
                          //TODO Notifcations
                        },
                      ),
                      MyQarinliCard(
                        // text: 'Price Alerts'
                        text: 'تنبيهات الأسعار',
                        icon: MdiIcons.clockAlertOutline,
                        onTap: () {
                          //TODO Price Alerts
                        },
                      ),
                      MyQarinliCard(
                        // text: 'Settings',
                        text: 'الإعدادات',
                        icon: MdiIcons.cogs,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return Settings();
                          }));
                        },
                      ),
                      MyQarinliCard(
                        // text: 'Feedback',
                        text: 'أخبرنا رأيك',
                        icon: MdiIcons.commentMultipleOutline,
                        onTap: () {
                          //TODO Feedback
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Container(
              margin: EdgeInsets.all(10.0),
              child: GestureDetector(
                  onTap: () async {
                    //TODO Rate app
                  },
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          // 'Rate our App',
                          'قيم التطبيق',
                          style: TextStyle(fontSize: 18.0),
                        ),
                        SizedBox(
                          width: 4.0,
                        ),
                        RatingBarIndicator(
                          rating: 5,
                          direction: Axis.horizontal,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: Palette.yellow,
                          ),
                          itemCount: 5,
                          itemSize: 16,
                        ),
                      ])),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return About();
                    },
                  ),
                );
              },
              child: Text(
                // 'More about Qarinli',
                'معلومات عن التطبيق',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.0,
                    color: theme == AppTheme.LIGHT
                        ? Colors.black
                        : Palette.yellow),
              ),
            ),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Privacy();
                    },
                  ),
                );
              },
              child: Text(
                // 'Privacy',
                'الخصوصية',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    color: theme == AppTheme.LIGHT
                        ? Colors.black
                        : Palette.midBlue),
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Rules();
                    },
                  ),
                );
              },
              child: Text(
                // 'Terms & conditions',
                'الشروط والأحكام',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 16.0,
                    color: theme == AppTheme.LIGHT
                        ? Colors.black
                        : Palette.midBlue),
              ),
            ),
          ),
        ],
      );
    });
  }
}
