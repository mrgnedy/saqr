import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';

import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/screens/LoginPage/View.dart';
import 'package:saqr/widgets/commnDesgin.dart';

import 'VerficationPage.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  double w;
  double h;
  bool _isLoading = false;

  File _image;
  ApiRequests _apiRequests = new ApiRequests();
  String _goodleToken;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  TextEditingController _nameController;
  TextEditingController _passwordController;
  TextEditingController _phoneController;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    _nameController = new TextEditingController();
    _phoneController = new TextEditingController();
    _passwordController = new TextEditingController();
    firebaseCloudMessagingListeners();

    super.initState();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();

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
                // _divider(),
                Align(
                    alignment: Alignment.centerRight,
                    child: mainText("تسجيل جديد")),
                _logo(),
                _divider(),
                _nameTextFaild(),
                _divider(),
                _phoneTextFaild(),
                _divider(),
                _passWordTextFaild(),
                _divider(),
                _isLoading
                    ? LOADING()
                    : InkWell(
                        onTap: () {
                          _vaildate();
                        },
                        child: commnBtnDesign(" تسجيل  ", w)),

                _divider(),
                _isLoading ? Container() : _newAccountText()
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _phoneTextFaild() {
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

  Widget _nameTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        controller: _nameController,
        textAlign: TextAlign.right,
        decoration: textFormInputDecoration("اسم المستخدم "),
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
      child: InkWell(
        onTap: () {
          showDialog(
            context: context,
            child: new SimpleDialog(
              backgroundColor: Colors.grey[800],
              title: Align(
                  alignment: Alignment.center,
                  child: new Text(
                    "تغيير الصوره الشخصية",
                    style: TextStyle(color: Colors.white, fontFamily: "thin"),
                  )),
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 45,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: new SimpleDialogOption(
                        child: new Text("كاميرا",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: "thin",
                                height: 2)),
                        onPressed: () {
                          Navigator.of(context).pop();

                          getImage(ImageSource.camera);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Container(
                      height: 45,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[200]),
                      child: new SimpleDialogOption(
                        child: new Text("ستوديو",
                            style: TextStyle(
                                color: Colors.grey[800],
                                fontFamily: "thin",
                                height: 2)),
                        onPressed: () {
                          Navigator.of(context).pop();

                          getImage(ImageSource.gallery);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
        child: Container(
          width: MediaQuery.of(context).size.width * .33,
          height: MediaQuery.of(context).size.width * .33,
          decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.grey),
              borderRadius: BorderRadius.circular(1000000)),
          child: _image == null
              ? Icon(
                  FontAwesomeIcons.image,
                  size: 50,
                  color: Colors.grey[GREYDEGREE],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(1000000),
                  child: Image.file(
                    _image,
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width * .3,
                    height: MediaQuery.of(context).size.width * .3,
                  ),
                ),
        ),
      ),
    );
  }

  Future getImage(ImageSource imageSource) async {
    //      var image = await ImagePicker.pickVideo(source: ImageSource.camera);
    var image = await ImagePicker.pickImage(
        source: imageSource, maxWidth: 1024, maxHeight: 683, imageQuality: 100);
    if (image != null) {
      setState(() {
        _image = image;
      });
    }
  }

  Widget _passWordTextFaild() {
    return Container(
      width: w > 400 ? w * .7 : 400 * .7,
      child: TextFormField(
        controller: _passwordController,
        textAlign: TextAlign.right,
        obscureText: true,
        decoration: textFormInputDecoration("كلمة المرور"),
      ),
    );
  }

  _newAccountText() {
    return InkWell(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return LoginPage();
        }));
      },
      child: Text(
        "لديك حساب ؟  تسجيل الدخول",
        style: TextStyle(color: Colors.black, fontFamily: "black"),
      ),
    );
  }

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

  void _vaildate() {
    if (_image == null) {
      showInSnackBar("رجاء قم بادخل الصورة الشخصية", Colors.grey[GREYDEGREE],
          _scaffoldKey);
      return;
    } else if (_nameController.text.length < 6) {
      showInSnackBar("رجاء قم بادخل اسم المستخدم بطريقة صحيحة",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_phoneController.text.length < 6) {
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
          .regester(_nameController.text, "966" + _phoneController.text,
              _passwordController.text, _goodleToken, _image)
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
            return VerviedCodePage3();
          }), (Route<dynamic> route) => false);
        } else if (value == false) {
          showInSnackBar("رقم الجوال مستخدم من قبل ", Colors.red, _scaffoldKey);
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
  }
}
