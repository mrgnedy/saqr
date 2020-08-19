import 'package:flutter/material.dart';

import 'OrderPage.dart';

class ChoosePage extends StatefulWidget {
  @override
  _ChoosePageState createState() => _ChoosePageState();
}

class _ChoosePageState extends State<ChoosePage> {
  double h;
  double w;
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Container(
        width: w,
        height: h,
        alignment: Alignment.center,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/mm.jpeg'), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              width: w * .7,
              height: 60,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.white54,
                  border: Border.all(width: 1, color: Colors.black45),
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "إختيار نوع الطلب",
                style: TextStyle(
                    color: Colors.blue[900], fontFamily: "black", fontSize: 20),
              ),
            ),
            _sizedBox(30),
            Container(
              width: w * .7,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  _cellDesign("سفاري"),
                  InkWell(
                    child: _cellDesign("محلي"),
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return OrderPage();
                      }));
                    },
                  )
                ],
              ),
            ),
            _sizedBox(30),
            _cellDesign("توصيل")
          ],
        ),
      ),
    );
  }

  _sizedBox(double h) {
    return SizedBox(
      height: h,
    );
  }

  _cellDesign(String name) {
    return Container(
      width: w * .3,
      height: 80,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.black45,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(width: 1, color: Colors.black),
      ),
      child: Text(
        name,
        style: TextStyle(
            fontFamily: "black", fontSize: 20, color: Colors.blue[100]),
      ),
    );
  }
}
