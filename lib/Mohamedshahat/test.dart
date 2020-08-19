import 'package:flutter/material.dart';
import 'package:saqr/Mohamedshahat/choosePage.dart';

class LoginScreen2 extends StatelessWidget {
  static String id = 'loginScreen';
  double h;
  double w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(body: body(context));
  }

  body(BuildContext context) {
    return Container(
      width: w,
      height: h,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/mm.jpeg'), fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Container(
          width: w * .85,
          height: h * .45,
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: Colors.white38,
              border: Border.all(width: 1, color: Colors.black45),
              borderRadius: BorderRadius.circular(15)),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 15,
              ),
              Container(
                width: w * .7,
                height: 45,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    color: Colors.white54,
                    border: Border.all(width: 1, color: Colors.black45),
                    borderRadius: BorderRadius.circular(20)),
                child: Text(
                  "تسجيل الدخول",
                  style: TextStyle(
                      color: Colors.black, fontFamily: "black", fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              Spacer(),
              _emailTextFaild(),
              SizedBox(
                height: 15,
              ),
              _passwordTextFaild(),
              SizedBox(
                height: 15,
              ),
              InkWell(onTap: (){
                     Navigator.push(context, MaterialPageRoute(builder: (context){
          return ChoosePage();
        }));
              },child:   _loginbtn(),),
            
              SizedBox(
                height: 15,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _emailTextFaild() {
    return Container(
      width: w * .65,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white54, borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        textAlign: TextAlign.right,
        decoration: _textFormInputDecoration(":  الاسم"),
      ),
    );
  }

  Widget _passwordTextFaild() {
    return Container(
      width: w * .65,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: Colors.white70, borderRadius: BorderRadius.circular(20)),
      child: TextFormField(
        textAlign: TextAlign.right,
        decoration: _textFormInputDecoration(":  الرقم السري"),
      ),
    );
  }

  InputDecoration _textFormInputDecoration(String hinttext) {
    return InputDecoration(
      contentPadding: EdgeInsets.all(8),
      hintText: hinttext,
      prefixStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(fontFamily: "thin", color: Colors.grey[600]),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black45, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.red, width: 1),
        borderRadius: BorderRadius.circular(20),
      ),
    );
  }

  _loginbtn() {
    return Container(
        width: w * .44,
        height: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
      color: Colors.deepOrange[100],
      border: Border.all(width: 1, color: Colors.black45),
      borderRadius: BorderRadius.circular(20)),
        child: Text(
    " دخول",
    style:
        TextStyle(color: Colors.black, fontFamily: "black", fontSize: 15),
    textAlign: TextAlign.center,
        ),
      );
  }
}
