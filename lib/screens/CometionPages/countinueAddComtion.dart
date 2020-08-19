import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/BankAcountsModel.dart';
import 'package:saqr/models/comtionAmountModel.dart' as comtion;
import 'package:saqr/screens/CometionPages/addAmount.dart';
import 'package:saqr/screens/HomePage/View.dart';

import 'package:saqr/widgets/commnDesgin.dart';

class ContanueAddComtion extends StatefulWidget {
  final comtion.CommtionAmountModel data;
  ContanueAddComtion({this.data});

  @override
  _ContanueAddComtionState createState() => _ContanueAddComtionState();
}

class _ContanueAddComtionState extends State<ContanueAddComtion> {
  bool _isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  BankAcountsModel _data;
  bool _isLoading2 = false;
  File _image;
  @override
  void initState() {
    _getAcounts();
    // TODO: implement initState
    super.initState();
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
            mainText("تفاصيل مقدم الخدمة"),
            _comtionAmount(),
            _isLoading
                ? LOADING()
                : _data == null
                    ? NoInterNetConnection()
                    : ListView.builder(
                        itemCount: _data.data.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return _comtionDetails(_data.data[index]);
                        }),
            _data == null
                ? Container()
                : Center(
                    child: Text(
                      "إرفاق صورة الوصل",
                      textAlign: TextAlign.right,
                      // overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "black",
                          fontSize: 18),
                    ),
                  ),
            _data == null ? Container() : _logo(),
            SizedBox(
              height: 15,
            ),
            _data == null
                ? Container()
                : _isLoading2
                    ? LOADING()
                    : InkWell(
                        onTap: () {
                          _vaildate();
                        },
                        child: Center(
                          child: commnBtnDesign(
                              "سداد المبلغ", MediaQuery.of(context).size.width),
                        )),

            // _isLoading
            //     ? LOADING()
            //     : InkWell(
            //         onTap: () {
            //           // _vaildate();
            //         },
            //         child: Center(
            //             child: commnBtnDesign(
            //                 "إرسال طلب", MediaQuery.of(context).size.width))),
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

  Widget _comtionDetails(Data data) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: 400,

      child: Padding(
        padding: const EdgeInsets.only(top: 12, bottom: 12, right: 20),
        child: Column(
          children: <Widget>[
            _lable("  :  البنك", data.nameAccount ?? "-", context),
            _lable("  : رقم الحساب", data.nameAccount ?? "-", context),
            _lable("  : رقم الايبان", data.appearance ?? "-", context),
            SizedBox(
              height: 15,
            ),
          ],
        ),
      ),
    );
  }

  _lable(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontFamily: "black", fontSize: 18),
            ),
          ),
          Text(
            lable ?? "-",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
                color: Colors.black, fontFamily: "black", fontSize: 18),
          ),
        ],
      ),
    );
  }

  _getAcounts() {
    _apiRequests.getAcounts().then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
    });
  }

  _comtionAmount() {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * .9,
        // height:MediaQuery.of(context).size.height*.1,
        padding: EdgeInsets.only(top: 15, bottom: 8),

        decoration: BoxDecoration(
            border: Border.all(width: 1, color: Colors.grey),
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              "العمولة",
              style: TextStyle(
                  fontFamily: "thin",
                  color: Colors.grey[GREYDEGREE],
                  fontSize: 18,
                  height: 1.5),
            ),
            Text(
              " ريال" + widget.data.data.com.toString(),
              style: TextStyle(
                fontFamily: "black",
                color: Colors.black,
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
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
                    "صورة الوصل",
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

  void _vaildate() {
    if (_image == null) {
      showInSnackBar(
          "رجاء قم بادخل صورة الوصل", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _isLoading2 = true;
      });
      _apiRequests.countinueAddAmount(_image, "_data.").then((value) {
        print("----------------------valeie-------------------");
        print(value);
        setState(() {
          _isLoading2 = false;
        });
        if (value == true) {
              showInSnackBar("تم ارسال العمولة بنجاح", Colors.green, _scaffoldKey);
          // Navigator.pushAndRemoveUntil(context,
          //     MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // }), (Route<dynamic> route) => false);
        } else if (value == false) {
          showInSnackBar("حدث خطا ما حاول مره اخري ", Colors.red, _scaffoldKey);
        } else {
          showInSnackBar(
              "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        }
      });
    }
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
}
