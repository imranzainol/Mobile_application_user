import 'package:flutter/material.dart';
import 'LogInUser.dart';
import 'HomePage.dart';
import 'SignInUser.dart';

class AppRoutes {
  AppRoutes._();

  static const String authLogin = '/auth-login';
  static const String authRegister = '/auth-register';
  static const String menu = '/menu';

  static Map<String, WidgetBuilder> define() {
    return {
      authLogin: (context) => LogInUser(),
      authRegister: (context) => SignInUser(),
      menu: (context) => HomePage(),
    };
  }
}