import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/config/theme.dart';
import 'package:qarinli/views/landing_screen/tabs/my_qarinli_widgets/my_qarinli_card.dart';
import 'package:qarinli/views/settings/settings.dart';

class MyQarinliTab extends StatefulWidget {
  // final ScrollController scrollController;
  // MyQarinliTab({this.scrollController});

  @override
  _MyQarinliTabState createState() => _MyQarinliTabState();
}

class _MyQarinliTabState extends State<MyQarinliTab> {
  final InAppReview inAppReview = InAppReview.instance;

  @override
  Widget build(BuildContext context) {
    return ListView(
      // controller: widget.scrollController,

      children: [
        Container(
          color: Color(0XFF4D4A4D),
          padding: EdgeInsets.all(10.0),
          child: Text(
            'My Qarinli',
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
              color: theme == AppTheme.LIGHT ? Color(0XFF4D4A4D) : Colors.white,
              height: 230,
              padding: EdgeInsets.all(10.0),
            ),
            Container(
              padding: EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Logged in as',
                    style: TextStyle(
                        fontSize: 24,
                        color: theme == AppTheme.LIGHT
                            ? Colors.white
                            : Colors.black),
                  ),
                  MyQarinliCard(
                    text: 'Notifications',
                    icon: Icons.alarm,
                    onTap: () {
                      //TODO Notifcations
                    },
                  ),
                  MyQarinliCard(
                    text: 'Price Alerts',
                    icon: MdiIcons.clockAlertOutline,
                    onTap: () {
                      //TODO Price Alerts
                    },
                  ),
                  MyQarinliCard(
                    text: 'Settings',
                    icon: MdiIcons.cogs,
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return Settings();
                      }));
                    },
                  ),
                  MyQarinliCard(
                    text: 'Feedback',
                    icon: MdiIcons.commentMultipleOutline,
                    onTap: () {
                      //TODO Feedback
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
              onTap: () async {
                //TODO Rate app
              },
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Text(
                  'Rate our App',
                  style: TextStyle(fontSize: 18.0),
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
        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              //TODO about
            },
            child: Text(
              'More about Qarinli',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24.0,
                  color:
                      theme == AppTheme.LIGHT ? Colors.black : Palette.yellow),
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
              //TODO open Privacy
            },
            child: Text(
              'Privacy',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  color:
                      theme == AppTheme.LIGHT ? Colors.black : Palette.midBlue),
            ),
          ),
        ),
        Container(
          margin: EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              //TODO open Terms & conditions
            },
            child: Text(
              'Terms & conditions',
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 16.0,
                  color:
                      theme == AppTheme.LIGHT ? Colors.black : Palette.midBlue),
            ),
          ),
        ),
      ],
    );
  }
}
