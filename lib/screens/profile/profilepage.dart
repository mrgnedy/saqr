import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/screens/NotifcationPage/View.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:saqr/dataUser.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DataUser _dataUser = DataUser.instance;
  File _image;
  TextEditingController _namecontroller = new TextEditingController();
  TextEditingController _phonecontroller = new TextEditingController();
  bool _nameenable = false;
  bool _phoneenable = false;
  bool _loading = false;
  ApiRequests _apiRequests = new ApiRequests();
  @override
  void initState() {
    // TODO: implement initState
    _namecontroller.text = _dataUser.getKey(Name).toString();
    _phonecontroller.text = _dataUser.getKey(PhoneNumber).toString();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      drawer: drawer(context),
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
                    Icons.sort,
                    color: Colors.white,
                    size: 25,
                  ),
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ),
        )
      ],
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          color: Colors.grey[GREYDEGREE],
          child: IconButton(
            color: Colors.white,
            icon: Icon(Icons.notifications),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return NotifcationPage();
              }));
            },
          ),
        ),
      ),
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
            mainText("  الحساب الشخصي  "),
            _logo(),
            SizedBox(
              height: 40,
            ),
            _nameTextFormFaild(),
            SizedBox(
              height: 20,
            ),
            _phoneTextFormFaild(),
            SizedBox(
              height: 50,
            ),
            _loading
                ? LOADING()
                : InkWell(
                    onTap: () {
                      validate();
                    },
                    child: Center(
                        child: commnBtnDesign(
                            " تعديل  ", MediaQuery.of(context).size.width)))
          ],
        ),
      ),
    );
  }

  _phoneTextFormFaild() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              setState(() {
                _phoneenable = !_phoneenable;
              });
            },
          ),
          Expanded(
              child: TextFormField(
            enabled: _phoneenable,
            controller: _phonecontroller,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "black",
                color: Colors.grey,
                fontSize: 20,
                height: 1.5),
            decoration: InputDecoration(
                hintText: "  رقم الجوال  ",
                hintStyle: TextStyle(fontFamily: "black", color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 15)),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "  :  رقم الجوال  ",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: "black"),
            ),
          ),
        ],
      ),
    );
  }

  _nameTextFormFaild() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.edit, color: Colors.black),
            onPressed: () {
              setState(() {
                _nameenable = !_nameenable;
              });
            },
          ),
          Expanded(
              child: TextFormField(
            enabled: _nameenable,
            controller: _namecontroller,
            textAlign: TextAlign.right,
            style: TextStyle(
                fontFamily: "black",
                color: Colors.grey,
                fontSize: 20,
                height: 1.5),
            decoration: InputDecoration(
                hintText: "  الاسم  ",
                hintStyle: TextStyle(fontFamily: "black", color: Colors.grey),
                contentPadding: EdgeInsets.only(top: 15)),
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "  :  الاسم  ",
              style: TextStyle(
                  color: Colors.black, fontSize: 18, fontFamily: "black"),
            ),
          ),
        ],
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
              ? ClipRRect(
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
                      width: MediaQuery.of(context).size.width * .33,
                      height: MediaQuery.of(context).size.width * .33,
                      errorWidget: (context, url, error) =>
                          Icon(Icons.error, color: Colors.black)),
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

  void validate() {
    if (_namecontroller.text.isEmpty ||
        _namecontroller.text.toString() == "null") {
      showInSnackBar(" رجاء ادخل الاسم", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else if (_phonecontroller.text.isEmpty ||
        _phonecontroller.text.toString() == "null") {
      showInSnackBar(
          " رجاء ادخل رقم الجوال", Colors.grey[GREYDEGREE], _scaffoldKey);
      return;
    } else {
      setState(() {
        _loading = true;
      });
      _apiRequests
          .editProfile(_namecontroller.text, _phonecontroller.text, _image)
          .then((value) {
        print("----------------------valeie-------------------");
        print(value);
        setState(() {
          _loading = false;
        });
        if (value == true) {
          // Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
          //   return HomePage();
          // }), (Route<dynamic> route) => false);
          setState(() {});
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
