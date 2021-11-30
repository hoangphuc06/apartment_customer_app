import 'package:apartment_customer_app/src/pages/home/view/home_page.dart';
import 'package:apartment_customer_app/src/pages/login/view/login_page.dart';
import 'package:apartment_customer_app/src/pages/news/view/news_page.dart';
import 'package:apartment_customer_app/src/pages/reset_password/reset_password_page.dart';
import 'package:apartment_customer_app/src/pages/splash/view/splash_page.dart';
import 'package:apartment_customer_app/src/pages/tab/view/tabs_page.dart';
import 'package:apartment_customer_app/src/pages/update_password/update_password_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
  "news_page": (BuildContext context) => NewsPage(),
  "update_pass_page": (BuildContext context) => UpdatePassWordPage(),
  "reset_pass_page": (BuildContext context) => ResetPassWord(),
};
