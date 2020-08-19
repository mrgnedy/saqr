import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/notifcationModel.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/widgets/commnDesgin.dart';
import 'package:url_launcher/url_launcher.dart';

class AcceptOrder extends StatefulWidget {
  final Data data;
  AcceptOrder({this.data});

  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptOrder> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool _isLoading = false;
  ApiRequests _apiRequests = new ApiRequests();
  String price;
  TextEditingController _priceController = new TextEditingController();
  @override
  void dispose() {
    _priceController.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  void initState() {
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
            _servicProviderDetails(),
          ],
        ),
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: 20,
    );
  }

  Widget _emailTextFaild() {
    return Container(
      width: MediaQuery.of(context).size.width > 400
          ? MediaQuery.of(context).size.width * .5
          : 400 * .5,
      child: TextFormField(
        controller: _priceController,
        textAlign: TextAlign.right,
        validator: (value) {
          if (value.isEmpty) {
            return "برجاء ادخل السعر";
          }
        },
        keyboardType: TextInputType.number,
        decoration: textFormInputDecoration("السعر"),
      ),
    );
  }

  final _formKey = GlobalKey<FormState>();
  drawShowDialog3(BuildContext context) {
    return showDialog<String>(
        context: context,
        builder: (BuildContext context) => SimpleDialog(
              shape: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.grey[GREYDEGREE]),
                borderRadius: BorderRadius.circular(15),
              ),
              backgroundColor: Colors.white,
              children: <Widget>[
                Form(
                  key: _formKey,
                  child: Container(
                    // height: MediaQuery.of(context).size.height * .3,
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "من فضلك أدخل سعر الخدمة",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "black",
                              fontSize: 20),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        _emailTextFaild(),
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                          onTap: () {
                            _validate2();
                          },
                          child: Container(
                            color: Colors.grey[GREYDEGREE],
                            width: 100,
                            margin: EdgeInsets.all(8),
                            padding: EdgeInsets.only(
                                top: 4, bottom: 4, right: 15, left: 15),
                            child: Center(
                                child: Text(
                              "تم",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontFamily: "black",
                                color: Colors.white,
                                fontSize: 15,
                              ),
                            )),
                          ),
                        )
                      ],
                    ),
                  ),
                )
              ],
            ));
  }

  _servicProviderDetails() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: <Widget>[
          _providerImage(),
          _divider(),
          _lable("  :  اسم مقدم الخدمة",
              widget.data.notfication.user.name ?? "-", context),
          _lable("  : رقم الجوال", widget.data.notfication.user.phone ?? "-",
              context),
          _lable("  : الخدمات", widget.data.subCatName ?? widget.data.catName,
              context),
          widget.data.order.addressFrom == null
              ? Container()
              : _lable(
                  "  : من", widget.data.order.addressFrom.toString(), context),
          widget.data.order.addressTo == null
              ? Container()
              : _lable(
                  "  : الي", widget.data.order.addressTo.toString(), context),
          _divider(),
          _isLoading
              ? LOADING()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        if(widget.data.servce.categoryId==17||widget.data.servce.categoryId==16||widget.data.servce.categoryId==22||widget.data.servce.categoryId==21||widget.data.servce.categoryId==26){
  // _vaildate("1");
   _vaildateprice("1" ,0);
    // drawShowDialog3(context);
                        }else{
                          drawShowDialog3(context);
                        }
                      
                        // drawShowDialog3(context);
                      },
                      child: commnBtnDesignavelable("قبول",
                          MediaQuery.of(context).size.width, Colors.teal[400]),
                    ),
                    InkWell(
                      onTap: () {
                        _vaildate("0");
                      },
                      child: commnBtnDesignavelable(
                        "رفض",
                        MediaQuery.of(context).size.width,
                        Colors.grey[400],
                      ),
                    )
                  ],
                ),
          SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
 void _vaildateprice(String state,int stats) {
    setState(() {
      _isLoading = true;
    });
    _apiRequests
        .acceptorder(
      state,
      widget.data.order.id.toString(),
    )
        .then((value) {
      print("----------------------valeie-------------------");
      print(value);
      setState(() {
        _isLoading = false;
      });
      if (value == true) {
        setState(() {
          _isLoading = true;
        });
        // showInSnackBar(" تم ارسال ردك ", Colors.green, _scaffoldKey);
        _apiRequests
            .priceOrder(_priceController.text.toString(),
                widget.data.order.id.toString(),stats)
            .then((value) {
          print("----------------------valeie-------------------");
          print(value);
          setState(() {
            _isLoading = false;
          });
          if (value == true) {
             showInSnackBar(" تم ارسال ردك ", Colors.green, _scaffoldKey);
          } else if (value == false) {
            showInSnackBar("حدث خطا ما ", Colors.red, _scaffoldKey);
          } else {
            showInSnackBar(
                "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
          }
        });
      } 
    });
  }

  void _vaildate(String state) {
    setState(() {
      _isLoading = true;
    });
    _apiRequests
        .acceptorder(
      state,
      widget.data.order.id.toString(),
    )
        .then((value) {
      print("----------------------valeie-------------------");
      print(value);
      setState(() {
        _isLoading = false;
      });
      if (value == true) {
        // setState(() {
        //   _isLoading = true;
        // });
        showInSnackBar(" تم ارسال ردك ", Colors.green, _scaffoldKey);
        // _apiRequests
        //     .priceOrder(_priceController.text.toString(),
        //         widget.data.order.id.toString())
        //     .then((value) {
        //   print("----------------------valeie-------------------");
        //   print(value);
        //   setState(() {
        //     _isLoading = false;
        //   });
        //   if (value == true) {
        //      showInSnackBar(" تم ارسال ردك ", Colors.green, _scaffoldKey);
        //   } else if (value == false) {
        //     showInSnackBar("حدث خطا ما ", Colors.red, _scaffoldKey);
        //   } else {
        //     showInSnackBar(
        //         "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
        //   }
        // });
      } else if (value == false) {
        showInSnackBar("حدث خطا ما ", Colors.red, _scaffoldKey);
      } else {
        showInSnackBar(
            "تاكد من الاتصال بالانترنت ", Colors.orange, _scaffoldKey);
      }
    });
  }

  _providerImage() {
    return Center(
      child: ClipOval(
        child: CachedNetworkImage(
          fit: BoxFit.fill,
          imageUrl: ImageUserUrl + widget.data.notfication.user.imageProfile,
          placeholder: (context, url) => LOADING(),
          height: MediaQuery.of(context).size.width * .3,
          width: MediaQuery.of(context).size.width * .3,
          errorWidget: (context, url, error) => Icon(
            Icons.error,
            color: Colors.black,
          ),
        ),
      ),
    );
  }

  _location(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) {
              //   return MapScreeen(
              //     lat: widget.data.lat,
              //     long: widget.data.long,
              //     name: widget.data.userName,
              //   );
              // }));
            },
          ),
          Expanded(
            child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontFamily: "thin", fontSize: 17),
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

  _lable(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[


    lable!="  : رقم الجوال"?Container():      Row(children: <Widget>[

IconButton(icon: Icon(FontAwesomeIcons.whatsapp),onPressed: (){
_launchURL(value);
},),
IconButton(icon: Icon(Icons.call),onPressed: () async {
     var telephoneUrl = "tel://${widget.data.notfication.user.phone ?? "-"}";
                    if (await canLaunch(telephoneUrl)) {
                      launch(telephoneUrl);
                    } else {
                     
                    }
},),

          ],),




          Expanded(
                      child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontFamily: "black", fontSize: lable!="  : رقم الجوال"?18:15),
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

  _launchURL(String value) async {
    String url = 'whatsapp://send?phone=/$value';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
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

  void _validate2() {
    if (_formKey.currentState.validate()) {
      _formKey.currentState.save();
      Navigator.of(context).pop();

      _vaildateprice("1" , 1);
    }
  }
}
