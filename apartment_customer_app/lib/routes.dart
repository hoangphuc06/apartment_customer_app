import 'package:apartment_customer_app/src/pages/login/view/login_page.dart';
import 'package:apartment_customer_app/src/pages/splash/view/splash_page.dart';
import 'package:flutter/material.dart';

final routes = <String, WidgetBuilder>{
  "splash_page": (BuildContext context) => SplashPage(),
  "login_page": (BuildContext context) => LoginPage(),
};