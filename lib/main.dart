import 'package:flutter/material.dart';
import 'package:fuelapp/pages/generate.dart';
import 'package:fuelapp/pages/display.dart';
import 'package:fuelapp/pages/login.dart';
// import 'package:fuel/pages/landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
    _MyAppState createState() => _MyAppState();
  }


class _MyAppState extends State<MyApp>{
  @override
  Widget build(BuildContext context){
   return MaterialApp(
     debugShowCheckedModeBanner: false,
     title: 'Buy Fuel',
     theme: ThemeData(
       brightness: Brightness.light,
       primarySwatch: Colors.green,
       accentColor: Colors.white,
       buttonColor: Colors.white,
     ),
     routes: <String, WidgetBuilder>{
       '/': (BuildContext contextt) => LoginPage(),
       '/Otp': (BuildContext context) => OtpGeneratePage(),
       '/gened':(BuildContext context) => GeneratedPage(),
        // '/generate': (BuildContext context) => OtpGeneratePage(),
     },
    );
  }
}