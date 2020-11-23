import 'package:flutter/material.dart';
import 'package:contact_tracing/SplashScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'SplashScreenNew.dart';
import 'routes.dart';
import 'LogInUser.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences preferences = await SharedPreferences.getInstance();
  var email = preferences.getString('email');
  await Firebase.initializeApp();
  runApp(MaterialApp(home: email==null ? SplashScreen():SplashScreenNew(),
    debugShowCheckedModeBanner: false,routes: AppRoutes.define(),));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Contact Tracing',
      debugShowCheckedModeBanner: false,
      routes: AppRoutes.define(),
    );
  }
}



