import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/notifcationModel.dart';
import 'package:saqr/screens/HomePage/View.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class AcceptProviderPrice extends StatefulWidget {
  final Data data;
  AcceptProviderPrice({this.data});

  @override
  _AcceptOrderState createState() => _AcceptOrderState();
}

class _AcceptOrderState extends State<AcceptProviderPrice> {
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
          _divider(),
          _isLoading
              ? LOADING()
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    InkWell(
                      onTap: () {
                        // drawShowDialog3(context);
                        _vaildate("1");
                      },
                      child: commnBtnDesignavelable(
                          "قبول",
                          MediaQuery.of(context).size.width,
                          Colors.white),
                    ),
                    InkWell(
                      onTap: () {
                        _vaildate("0");
                      },
                      child: commnBtnDesignavelable(
                        "رفض",
                        MediaQuery.of(context).size.width,
                        Colors.white,
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

  void _vaildate(String state) {
    setState(() {
      _isLoading = true;
    });
    _apiRequests
        .acceptPrice(
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
        showInSnackBar("تم ارسال ردك بنجاح ", Colors.green, _scaffoldKey);
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
          Expanded(
            child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              // overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  color: Colors.grey, fontFamily: "black", fontSize: 20),
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
