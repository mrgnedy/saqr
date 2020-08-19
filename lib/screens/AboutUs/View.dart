import 'package:flutter/material.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/sharedUi/notifcation_cell.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class AboutUsPage extends StatefulWidget {
  final String data;
  final String tittel;
  AboutUsPage({this.tittel, this.data});
  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  DataUser _dataUser = DataUser.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
      // alignment: Alignment.centerRight,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(
                alignment: Alignment.topRight, child: mainText(widget.tittel)),
            Text(
              widget.tittel == "من نحن"
                  ? _dataUser.getKey(WhoWe).toString()
                  : _dataUser.getKey(TERMS).toString(),
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Colors.grey[800], fontFamily: "thin", fontSize: 15),
            )
          ],
        ),
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
}
