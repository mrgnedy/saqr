import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/forgetPassword/vaidateForgetPassword.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class EnterEmail extends StatefulWidget {
  @override
  _EnterEmailState createState() => _EnterEmailState();
}

class _EnterEmailState extends State<EnterEmail> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  TextEditingController _phoneController = new TextEditingController();
  bool _isLoading = false;
  ApiRequests _apiRequests = new ApiRequests();
  @override
  void dispose() {
    // TODO: implement dispose
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: _appBar(),
      body: _body(),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      alignment: Alignment.topRight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            mainText("  إدخل رقم الجوال  "),
            _logo(),
            _enterText(),
            SizedBox(height: 10),
            _phoneTextFaild(),
            SizedBox(height: 20),
            _isLoading
                ? LOADING()
                : InkWell(
                    onTap: () {
                      _vaidate();
                    },
                    child: Center(
                        child: commnBtnDesign(
                            " دخول  ", MediaQuery.of(context).size.width))),
          ],
        ),
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

  Widget _phoneTextFaild() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width > 400
            ? MediaQuery.of(context).size.width * .7
            : 400 * .7,
        child: TextFormField(
          textAlign: TextAlign.right,
          controller: _phoneController,

          // obscureText: true,
          decoration: _textFormInputDecoration("رقم الجوال"),
        ),
      ),
    );
  }

  _enterText() {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Text(
        "قم بإدخال رقم الجوال الذي استخدمته لانشاء حسابك",
        style: TextStyle(
          fontFamily: "black",
          fontSize: 18,
        ),
        textAlign: TextAlign.center,
      ),
    );
  }

  void _vaidate() {
    if (_phoneController.text.length < 9) {
      showInSnackBar("رجاء قم بادخل رقم الجوال بطريقة صحيحة",
          Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      _apiRequests.sendPhoneCode("966" + _phoneController.text).then((value) {
        setState(() {
          _isLoading = false;
        });
        if (value != null) {
          if (value) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return VerviedCodePage(
                phone: "966" + _phoneController.text,
              );
            }));

            // Navigator.pushAndRemoveUntil(context,
            //     MaterialPageRoute(builder: (context) {
            //       return NewPassword(email:widget.email);
            //     }), (Route<dynamic> route) => false);
          } else {
            showInSnackBar(" الرقم الذي ادخلته غير موجود سابقا ",
                Colors.grey[GREYDEGREE], _scaffoldKey);

            return;
          }
        } else {
          showInSnackBar("  تاكد من الاتصال بالانترنت", Colors.grey[GREYDEGREE],
              _scaffoldKey);

          return;
        }
      });
    }
  }
}
