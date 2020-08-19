import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/screens/RegesterPage/VerficationPage.dart';
import 'package:saqr/screens/RegesterPage/View.dart';
import 'package:saqr/screens/forgetPassword/enterEmail.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  double w;
  double h;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  DataUser _dataUser = DataUser.instance;

  ApiRequests _apiRequests = new ApiRequests();
  String _goodleToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController _phoneController;
  TextEditingController _passwordController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  void iosPermission() {
    _firebaseMessaging.requestNotificationPermissions(
        IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
  }

  void firebaseCloudMessagingListeners() {
    if (Platform.isIOS) iosPermission();

    _firebaseMessaging.getToken().then((token) {
      print("--------------gooogle token ------------------");
      print(token);
      if (this.mounted) {
        setState(() {
          _goodleToken = token;
        });
      }
    });
  }

  @override
  void initState() {
    firebaseCloudMessagingListeners();
    _phoneController = new TextEditingController();
    _passwordController = new TextEditingController();
    // TODO: implement initState
    super.initState();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _passwordController.dispose();

    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      body: Container(
        height: h,
        width: w,
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                _logo(),
                _divider(),
                mainText("تسجيل الدخول"),
                _divider(),
                _emailTextFaild(),
                _divider(),
                _passWordTextFaild(),
                _divider(),
                _isLoading
                    ? LOADING()
                    : InkWell(
                        onTap: () {
                          _vaildate();
                        },
                        child: commnBtnDesign(" دخول  ", w)),
                _divider(),
                _isLoading ? Container() : _forgetPasswordText(),
                _divider(),
                _isLoading ? Container() : _newAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _emailTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        controller: _phoneController,
        textAlign: TextAlign.right,
        keyboardType: TextInputType.number,
        decoration: _textFormInputDecoration("رقم الجوال "),
      ),
    );
  }

  InputDecoration _textFormInputDecoration(String hinttext) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      hintText: hinttext,
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          "+966",
          style:
              TextStyle(fontFamily: "black", color: Colors.grey, fontSize: 18),
        ),
      ),
      //  prefixStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.grey, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1.5),
        borderRadius: BorderRadius.circular(12),
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _logo() {
    return Center(
      child: Image.asset(
        'assets/logo.png',
        width: w * .4,
        // height: h * .3,
        fit: BoxFit.cover,
        //  color: Colors.red,
        // color: Color(getColorHexFromStr('#E02721')),
      ),
    );
  }

  Widget _passWordTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        textAlign: TextAlign.right,
        controller: _passwordController,
        obscureText: true,
        decoration: textFormInputDecoration("كلمة المرور"),
      ),
    );
  }

  _forgetPasswordText() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return EnterEmail();
        }));
      },
      child: Text(
        "هل نسيت كلمة المرور ؟",
        style: TextStyle(color: Colors.black, fontFamily: "black"),
      ),
    );
  }

  _newAccountText() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return SignUpPage();
        }));
      },
      child: Text(
        " ليس لديك حساب ؟ سجل الان",
        style: TextStyle(color: Colors.black, fontFamily: "black"),
      ),
    );
  }

  void _vaildate() {
    if (_phoneController.text.length < 6) {
      showInSnackBar("رجاء قم بادخل رقم الجوال بطريقة صحيحة",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_passwordController.text.length < 6) {
      showInSnackBar("كلمة المرور يجب ان لا تقل عن 6 احروف",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _isLoading = true;
      });
      _apiRequests
          .login("966" + _phoneController.text, _passwordController.text,
              _goodleToken)
          .then((value) {
        print("----------------------valeie-------------------");
        print(value);
        setState(() {
          _isLoading = false;
        });
        if (value == true) {
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return HomePage();
          }), (Route<dynamic> route) => false);
        } else if (value == "needActive") {
          print("need vefied");
          Navigator.pushAndRemoveUntil(context,
              MaterialPageRoute(builder: (context) {
            return VerviedCodePage3(check: 1);
          }), (Route<dynamic> route) => false);
        } else if (value == false) {
          showInSnackBar(
              "تاكد من رقم الجوال و كلمة المرور", Colors.red, _scaffoldKey);
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
  }
}
