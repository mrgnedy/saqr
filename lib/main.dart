import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:saqr/Mohamedshahat/test.dart';
import 'package:saqr/screens/LoginPage/View.dart';
import 'package:saqr/screens/OnBoarding/onBording.dart';
import 'package:saqr/screens/splash/View.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashPage(),
    );
  }
}
