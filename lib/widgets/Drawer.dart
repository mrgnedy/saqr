import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/screens/AboutUs/View.dart';
import 'package:saqr/screens/CometionPages/addAmount.dart';
import 'package:saqr/screens/ContactUs/View.dart';
import 'package:saqr/screens/HomePage/View.dart';

import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/LoginPage/View.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/screens/changPassword.dart';
import 'package:saqr/screens/myOrders.dart';
import 'package:saqr/screens/profile/profilepage.dart';
import 'package:shared_preferences/shared_preferences.dart';

Widget drawer(BuildContext context) {
  double w = MediaQuery.of(context).size.width;
  double h = MediaQuery.of(context).size.height;
  DataUser _dataUser = DataUser.instance;

  print("----------image------------");
  print(ProfileImageUrl + _dataUser.getKey(Profile_Image).toString());
  return Align(
    alignment: Alignment.bottomRight,
    child: Container(
        width: w * .7,
        height: h,
        // alignment: Alignment.center,
        padding: EdgeInsets.only(right: 20),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(30))),
        child: SingleChildScrollView(
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                height: h * .1,
              ),
              InkWell(
                onTap: () {
                  if (_dataUser.getKey(ISLOGING).toString() == "null") {
                  } else {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return ProfilePage();
                    }));
                  }
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(1000000000),
                  child: CachedNetworkImage(
                      imageUrl: _dataUser.getKey(ISLOGING).toString() == "null"
                          ? personimage
                          : ImageUserUrl +
                              _dataUser.getKey(Profile_Image).toString(),
                      placeholder: (context, url) => Center(
                            child: CupertinoActivityIndicator(
                              radius: 17,
                              animating: true,
                            ),
                          ),
                      fit: BoxFit.fill,
                      width: w * .35,
                      height: w * .35,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: Colors.black)),
                ),
              ),
              SizedBox(
                height: 12,
              ),
              _dataUser.getKey(ISLOGING).toString() == "null"
                  ? Container()
                  : name(_dataUser.getKey(Name).toString()),
              SizedBox(
                height: 12,
              ),
              divide(w, h),
              cell("الخدمات", HomePage(), context),
              _dataUser.getKey(ISLOGING).toString() == "null"
                  ? Container()
                  : cell("الاشعارات", NotifcationPage(), context),
              _dataUser.getKey(ISLOGING).toString() == "null" ||
                      _dataUser.getKey(Is_Coworker).toString() != "1"
                  ? Container()
                  : cell("عمولة التطبيق", AddCopmmtionAmount(), context),
              _dataUser.getKey(ISLOGING).toString() == "null"
                  ? Container()
                  : cell("طلباتي", MyOrdersPage(), context),
              divide(w, h),
              cell(
                  "الشروط و الاحكام",
                  AboutUsPage(
                    tittel: "الشروط و الاحكام",
                    data: "الشروط و الاحكام",
                  ),
                  context),
              cell(
                  "من نحن",
                  AboutUsPage(
                    tittel: "من نحن",
                    data: "من نحن",
                  ),
                  context),
              cell("اتصل بنا", ContactUs(), context),
              divide(w, h),
              _dataUser.getKey(ISLOGING).toString() == "null"
                  ? cell("تسجيل الدخول", LoginPage(), context)
                  : Container(),
              _dataUser.getKey(ISLOGING).toString() == "null"
                  ? Container()
                  : cell("تغيير كلمة المرور", ChangePasswordPage(), context),
              _dataUser.getKey(ISLOGING).toString() == "true"
                  ? InkWell(
                      onTap: () {
                        _onBackPressed(context);
                      },
                      child: Container(
                        margin: EdgeInsets.only(bottom: 12, top: 10),
                        child: Text(
                          "تسجيل الخروج",
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: "black",
                              fontSize: 18),
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        )),
  );
}

Future<bool> _onBackPressed(context) {
  ApiRequests _apiRequests = new ApiRequests();
  bool loading = false;
  return showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return loading
            ? Center(
                child: CupertinoActivityIndicator(
                  animating: true,
                  radius: 17,
                ),
              )
            : CupertinoAlertDialog(
                content: new Text("هل متاكد من الخروج ؟",
                    style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'thins',
                        color: Colors.black)),
                actions: <Widget>[
                  new FlatButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: new Text(
                      "لا",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  new FlatButton(
                    onPressed: () async {
                      // SystemChannels.platform.invokeMethod('SystemNavigator.pop');

                      _apiRequests.logout().then((value) async {
                        DataUser _dataUser = DataUser.instance;
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();
                        _dataUser.setKey({'key': ISLOGING, 'value': null});
                        pref.clear();
                        Navigator.pushAndRemoveUntil(context,
                            MaterialPageRoute(builder: (context) {
                          return LoginPage();
                        }), (Route<dynamic> route) => false);
                      });
                    },
                    //  SystemChannels.platform.invokeMethod('SystemNavigator.pop'),
                    child: new Text(
                      "نعم",
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                ],
              );
      });
}

Widget cell(String txt, Widget nav, BuildContext context) {
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (contxt) {
        return nav;
      }));
    },
    child: Text(
      txt,
      textAlign: TextAlign.right,
      style: TextStyle(
          color: txt == "اتصل بنا" ? Colors.green : Colors.black,
          fontFamily: "thin",
          fontSize: 20),
    ),
  );
}

Widget name(String name) {
  return Text(
    name,
    style: TextStyle(color: Colors.black, fontFamily: "black", fontSize: 18),
  );
}

Widget divide(double w, double h) {
  return Padding(
    padding: const EdgeInsets.only(right: 24, left: 24),
    child: Container(
      width: w,
      height: 2,
      color: Colors.grey[700],
    ),
  );
}
