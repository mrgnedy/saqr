import 'package:awesome_dialog/awesome_dialog.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/screens/LoginPage/View.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class ChangePasswordPage extends StatefulWidget {
  final String phone;
  ChangePasswordPage({this.phone});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  // String password1;
  String password2;
  String password3;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: _appBar(),
      body: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                mainText("تغيير كلمة المرور"),
                SizedBox(
                  height: 25,
                ),
                _logo(),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width > 400
                        ? 400 * .8
                        : MediaQuery.of(context).size.width * .85,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                        obscureText: true,
                        style: TextStyle(
                            fontFamily: "thin",
                            color: Colors.grey[GREYDEGREE],
                            fontSize: 14),
                        onSaved: (value) {
                          password2 = value;
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return " رجاء ادخل كلمة المرور الجديدة";
                          }
                          if (value.length < 6) {
                            return "كلمة المرور قصيره جدا";
                          }
                        },
                        textAlign: TextAlign.right,
                        // obscureText: hide,
                        decoration:
                            textFormInputDecoration("  كلمة المرور الجديدة ")),
                  ),
                ),
                Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width > 400
                        ? 400 * .8
                        : MediaQuery.of(context).size.width * .85,
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.only(top: 20),
                    child: TextFormField(
                        obscureText: true,
                        style: TextStyle(
                            fontFamily: "thin",
                            color: Colors.grey[GREYDEGREE],
                            fontSize: 14),
                        onSaved: (value) {
                          password3 = value;
                        },
                        textAlign: TextAlign.right,
                        validator: (value) {
                          if (value.isEmpty) {
                            return "رجاء اعاده كلمة المرور";
                          }
                          if (value.length < 6) {
                            return "كلمة المرور قصيره جدا";
                          }
                        },
                        // obscureText: hide,
                        decoration:
                            textFormInputDecoration(" اعاده كلمة المرور ")),
                  ),
                ),
                SizedBox(
                  height: 80,
                ),
                _isLoading
                    ? Center(
                        child: Container(
                          margin: EdgeInsets.only(top: 20),
                          child: CupertinoActivityIndicator(
                            animating: true,
                            radius: 17,
                          ),
                        ),
                      )
                    : InkWell(
                        onTap: () {
                          valedate();
                        },
                        child: Center(
                            child: commnBtnDesign("حفظ التغيير",
                                MediaQuery.of(context).size.width))),
              ],
            ),
          ),
        ),
      ),
    );
  }

  _logo() {
    return Center(
      child: Image.asset(
        "assets/logo.png",
        width: MediaQuery.of(context).size.width >= 400
            ? 400 * .4
            : MediaQuery.of(context).size.width * .4,
      ),
    );
  }

  void valedate() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      if (password2 != password3) {
        showInSnackBar(" كلمة المرور غير متاطبقة ", Colors.red, _scaffoldKey);
        return;
      }

      setState(() {
        _isLoading = true;
      });
      // firebaseCloudMessagingListeners();
      // print(_goodleToken);
      //_goodleToken

      _apiRequests
          .changepassword(
              password2,
              widget.phone.toString() == "null"
                  ? null
                  : widget.phone.toString())
          .then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          if (value) {
            // Navigator.push(context,
            //                         MaterialPageRoute(builder: (context) {
            //                       return اخ();
            //                     }));
            if (widget.phone.toString() == "null") {
              Navigator.pushAndRemoveUntil(context,
                  MaterialPageRoute(builder: (context) {
                return LoginPage();
              }), (Route<dynamic> route) => false);
            } else {
              showInSnackBar(
                  " تم تغيير كلمة المرور بنجاح ", Colors.green, _scaffoldKey);
            }
          } else {
            showInSnackBar(" حدث خطأ ما ", Colors.red, _scaffoldKey);
          }
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      automaticallyImplyLeading: false,
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            width: 40,
            color: Colors.grey[GREYDEGREE],
            child: Center(
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: IconButton(
                  icon: Icon(
                    Icons.arrow_back_ios,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
