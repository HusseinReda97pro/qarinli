import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:qarinli/config/Palette.dart';
import 'package:qarinli/controllers/helper/internet_connection.dart';
import 'package:qarinli/controllers/state_management/main_model.dart';
import 'package:qarinli/views/auth/widgets/input_field.dart';
import 'package:qarinli/views/landing_screen/landing_screen.dart';
import 'package:qarinli/views/widgets/alert_message.dart';
import 'package:qarinli/views/widgets/app_drawer/app_drawer.dart';
import 'package:qarinli/views/widgets/appbar.dart';
import 'package:qarinli/views/widgets/loading.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  final emailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Consumer<MainModel>(builder: (context, model, child) {
      return Scaffold(
        appBar: MainAppBar(context: context),
        endDrawer: AppDrawer(),
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width * 0.12),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 16,
                      ),
                      InputField(
                        hint: 'البريد الألكتروني',
                        controller: emailController,
                        // focusNode: emailFocusNode,
                        isPassword: false,
                        validator: (value) {
                          bool emailValid = RegExp(
                                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                              .hasMatch(value);
                          return emailValid
                              ? null
                              : 'البريد الألكتروني غير صالح';
                        },
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      InputField(
                        hint: 'كلمة المرور',
                        // focusNode: passwordFocusNode,
                        controller: passwordController,
                        isPassword: true,
                        validator: (value) {
                          if (value.length < 6) {
                            return 'يجب أن تكون كلمة السر أكثر من 6 أحرف';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: 6.0,
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(
                            child: SizedBox(),
                          ),
                          GestureDetector(
                            child: Container(
                              margin: EdgeInsets.only(right: 3.0),
                              child: Text(
                                'سجل الأن',
                                style: TextStyle(
                                    color: Palette.midBlue,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600,
                                    decoration: TextDecoration.underline),
                              ),
                            ),
                            onTap: () {
                              Navigator.pushReplacementNamed(
                                  context, '/signup');
                            },
                          ),
                          SizedBox(
                            width: 6.0,
                          ),
                          Text('لا تمتلك حساب؟'),
                          Expanded(
                            child: SizedBox(),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 16.0,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        child: RaisedButton(
                          shape: RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(18.0),
                              side: BorderSide(color: Palette.black)),
                          child: Text(
                            'تسجيل الدخول',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 24,
                                fontWeight: FontWeight.w900),
                          ),
                          color: Palette.midBlue,
                          onPressed: () async {
                            if (_formKey.currentState.validate()) {
                              if (await InternetConnection.check()) {
                                loading(context, 'جاري تسجيل الدخول');
                                var message = await model.login(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                                Navigator.pop(context);
                                if (message != 'successfully') {
                                  showAlertMessage(
                                    context: context,
                                    title: 'حدث خطًأ ما',
                                    message: Html(data: message),
                                    // message: Text('حدث خطأ ما'),
                                  );
                                } else {
                                  Navigator.pushReplacement(context,
                                      MaterialPageRoute(
                                          builder: (BuildContext context) {
                                    return LanddingScreen();
                                  }));
                                }
                              } else {
                                showAlertMessage(
                                    context: context,
                                    title: 'حدث خطًأ ما',
                                    message: Text(
                                        'تحقق من اتصالك بالأنترنت وحاول مرة أخرى'));
                              }
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}
