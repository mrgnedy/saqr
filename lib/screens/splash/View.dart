import 'dart:async';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/HomePage/View.dart';

import 'package:saqr/screens/OnBoarding/onBording.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../dataUser.dart';

class SplashPage extends StatefulWidget {
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  DataUser _dataUser = DataUser.instance;

  Animation<double> animation;
  AnimationController controller;
  @override
  void dispose() {
    controller.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation = Tween<double>(begin: 0, end: 250).animate(controller)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });

    controller.forward();
    goToHomePage();
    super.initState();
  }

  void goToHomePage() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        print('connected');
        Timer(Duration(seconds: 1), () async {
          SharedPreferences pref = await SharedPreferences.getInstance();
          String token = pref.getString(Token);

          if (token != null &&
              token.toString() != "null" &&
              pref.getString(Isverfied) == "1") {
            print("======================in ===================");
            print(pref.getString("country_id").toString());
            print(pref.getString("city_id").toString());
            _dataUser.setKey({'key': Id, 'value': pref.getString(Id)});
            _dataUser.setKey(
                {'key': Is_Coworker, 'value': pref.getString(Is_Coworker)});
            _dataUser.setKey({'key': Token, 'value': pref.getString(Token)});
            _dataUser
                .setKey({'key': Isverfied, 'value': pref.getString(Isverfied)});
            _dataUser.setKey(
                {'key': Profile_Image, 'value': pref.getString(Profile_Image)});
            _dataUser.setKey({'key': Name, 'value': pref.getString(Name)});
            _dataUser.setKey(
                {'key': PhoneNumber, 'value': pref.getString(PhoneNumber)});
            _dataUser.setKey({'key': ISLOGING, 'value': "true"});

            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) {
                  return HomePage();
                },
              ),
            );
          } else if (pref.getString(Installed) == "1") {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) {
                  return HomePage();
                },
              ),
            );
          } else {
            Navigator.of(context).pushReplacement(
              PageRouteBuilder(
                pageBuilder: (_, __, ___) {
                  return OnBoardingPage();
                },
              ),
            );
          }
        });
      }
    } on SocketException catch (_) {
      print('not connected');
      showNetworkErrorDialog(context);
    }
  }

  void showNetworkErrorDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            "تنبيه",
            style: TextStyle(
              fontFamily: "Neo sans",
              fontSize: 15,
            ),
          ),
          content: Text(
            "برجاء التاكد من الاتصال بالانترنت",
            style: TextStyle(
              fontFamily: "Neo sans",
              fontSize: 15,
            ),
          ),
          actions: <Widget>[
            CupertinoButton(
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  PageRouteBuilder(
                    pageBuilder: (_, __, ___) {
                      return SplashPage();
                    },
                  ),
                );
              },
              child: Text(
                "حاول مرة اخرى",
                style: TextStyle(
                  fontFamily: "Neo sans",
                  fontSize: 15,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
            height: animation.value,
            width: animation.value,
            // width: MediaQuery.of(context).size.width >= 400
            //     ? 400 * .6
            //     : MediaQuery.of(context).size.width * .6,
            // height: MediaQuery.of(context).size.height * .35,
            child: Image.asset("assets/logo.png")),
      ),
    );
  }
}
