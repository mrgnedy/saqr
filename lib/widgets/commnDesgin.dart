import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/LoginPage/View.dart';

Widget mainText(String name) {
  return Text(
    "  $name  ",
    style: TextStyle(fontFamily: "black", fontSize: 30),
  );
}

Widget NoInterNetConnection() {
  return Text(
    "لا يوجد اتصال بالانترنت ",
    style: TextStyle(fontFamily: "black", fontSize: 18),
  );
}

Widget NoDataFound() {
  return Text(
    "لا يوجد  بيانات حتي الان ",
    style: TextStyle(fontFamily: "black", fontSize: 18),
  );
}

Widget LOADING() {
  return Center(
    child: Container(
      margin: EdgeInsets.only(top: 20),
      child: CupertinoActivityIndicator(
        animating: true,
        radius: 17,
      ),
    ),
  );
}

InputDecoration textFormInputDecoration(String hinttext) {
  return InputDecoration(
    contentPadding: EdgeInsets.all(8),
    hintText: hinttext,
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

Widget commnBtnDesign(String txt, double w) {
  return Container(
    width: w > 400 ? w * .7 : 400 * .7,
    padding: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: Colors.grey[GREYDEGREE],
        borderRadius: BorderRadius.circular(12)),
    child: Text(
      txt,
      textAlign: TextAlign.center,
      style: TextStyle(
          color: Colors.white, fontFamily: "thin", height: 1.5, fontSize: 20),
    ),
  );
}

Widget commnBtnDesignavelable(String txt, double w, Color coloe) {
  return Container(
    width: w > 400 ? w * .3 : 400 * .3,
    height: 40,
    padding: EdgeInsets.all(4),
    margin: EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: coloe,
        border: Border.all(width: 1, color: Colors.grey[GREYDEGREE]),
        borderRadius: BorderRadius.circular(12)),
    child: Center(
      child: Text(
        txt,
        textAlign: TextAlign.center,
        style: TextStyle(
            color: Colors.black, fontFamily: "thin", height: 1.5, fontSize: 15),
      ),
    ),
  );
}

showInSnackBar(
    String value, Color color, GlobalKey<ScaffoldState> _scaffoldKey) {
  _scaffoldKey.currentState.showSnackBar(
    new SnackBar(
      behavior: SnackBarBehavior.fixed,
      backgroundColor: color,
      content: new Text(
        value,
        textAlign: TextAlign.right,
        style: TextStyle(
          fontFamily: 'black',
          color: Colors.white,
        ),
      ),
    ),
  );
}

drawShowDialog2(BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[GREYDEGREE]),
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: Center(
                              child: Text(
                            "!",
                            style: TextStyle(fontSize: 40),
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Text(
                        "عفوا لا يمكنك إرسال طلب خدمة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "black", fontSize: 20, height: 1.5),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width > 400
                          ? MediaQuery.of(context).size.width * .4
                          : 400 * .4,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[GREYDEGREE],
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "سجل الان",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "thin",
                            height: 1.5,
                            fontSize: 20),
                      ),
                    ),
                  )
                  // _drawLocationRaisedButton(),
                ],
              ),
            ],
          ));
}

drawShowDialog(BuildContext context) {
  return showDialog<String>(
      context: context,
      builder: (BuildContext context) => SimpleDialog(
            shape: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey[GREYDEGREE]),
              borderRadius: BorderRadius.circular(15),
            ),
            backgroundColor: Colors.white,
            children: <Widget>[
              Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ClipOval(
                      child: Container(
                          width: 60,
                          height: 60,
                          color: Colors.grey,
                          child: Center(
                              child: Text(
                            "!",
                            style: TextStyle(fontSize: 40),
                          ))),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                      width: MediaQuery.of(context).size.width * .4,
                      child: Text(
                        "عفوا لا يمكنك اضافة خدمة",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: "black", fontSize: 20, height: 1.5),
                      )),
                  SizedBox(
                    height: 20,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return LoginPage();
                      }));
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width > 400
                          ? MediaQuery.of(context).size.width * .4
                          : 400 * .4,
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.grey[GREYDEGREE],
                          borderRadius: BorderRadius.circular(12)),
                      child: Text(
                        "سجل الان",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "thin",
                            height: 1.5,
                            fontSize: 20),
                      ),
                    ),
                  )
                  // _drawLocationRaisedButton(),
                ],
              ),
            ],
          ));
}
