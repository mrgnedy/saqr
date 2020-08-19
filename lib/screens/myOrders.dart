import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/myordersModel.dart';

import 'package:saqr/screens/NotifcationPage/AcceptOrder.dart';
import 'package:saqr/screens/NotifcationPage/AcceptProviderPrice.dart';

import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  _MyOrdersPageState createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  MyOrdersModel _data;
  bool _isLoading = true;
  @override
  void initState() {
    _getNotifcations();
    // TODO: implement initState
    super.initState();
  }

  double w;
  double h;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      key: _scaffoldKey,
      appBar: _appBar(),
      body: _body(),
      drawer: drawer(context),
    );
  }

  Widget _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      padding: EdgeInsets.all(8.0),
      // alignment: Alignment.centerRight,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          mainText("طلباتي"),
          _isLoading
              ? LOADING()
              : _data == null
                  ? NoInterNetConnection()
                  : _data.data.myOrder.length == 0 &&
                          _data.data.ordersForProvider.length == 0
                      ? NoDataFound()
                      : Expanded(
                          child: ListView.builder(
                              itemCount: _data.data.myOrder.length,
                              itemBuilder: (context, index) {
                                return notifcation(_data.data.myOrder[index]);
                              }),
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
    );
  }

  _getNotifcations() {
    _apiRequests.getMyOrders().then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
    });
  }

  notifcation(MyOrder myOrder) {
    return Container(
      width: MediaQuery.of(context).size.width,
      // height: MediaQuery.of(context).size.height * .15,
      margin: EdgeInsets.only(top: 8, left: 8, right: 8),
      padding: EdgeInsets.only(right: 8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey[500]),
          borderRadius: BorderRadius.circular(12)),
      // color: Colors.red,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          InkWell(
            onTap: () {
              deletenotifcation(myOrder.order.id.toString());
            },
            child: Align(
                alignment: Alignment.topLeft,
                child: Padding(
                    padding: EdgeInsets.only(top: 12, left: 12),
                    child: Icon(Icons.close))),
          ),
          Container(
              width: w - (w * .2) - 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      myOrder.userName.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "black",
                          height: 1.5),
                    ),
                    Text(
                      myOrder.subCategoyName == " لا يوجد اقسام فرعية"
                          ? myOrder.categoyName.toString()
                          : myOrder.subCategoyName,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "thin", height: 1.5),
                    ),
                    Text(
                      myOrder.order.createdAt.toString(),
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "thin", height: 1.5),
                    ),
                    Text(
                      myOrder.providerPhone,
                      textAlign: TextAlign.right,
                      style: TextStyle(
                          color: Colors.black, fontFamily: "thin", height: 1.5),
                    )
                  ],
                ),
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(1000000000),
            child: CachedNetworkImage(
                imageUrl: (myOrder.subCategoyImage == " لا يوجد اقسام فرعية"
                    ? ImageCategoryBaseUrl + myOrder.categoyImage.toString()
                    : ImageSubCategoryBaseUrl + myOrder.subCategoyImage),
                placeholder: (context, url) => Center(
                      child: CupertinoActivityIndicator(
                        radius: 17,
                        animating: true,
                      ),
                    ),
                fit: BoxFit.fill,
                width: w * .2,
                height: w * .2,
                errorWidget: (context, url, error) =>
                    Icon(Icons.error, color: Colors.black)),
          ),
        ],
      ),
    );
  }

  void deletenotifcation(String id) {
    setState(() {
      _isLoading = true;
    });
    _apiRequests.deleteorder(id).then((value) {
      if (value == null) {
        setState(() {
          _isLoading = false;
        });
        showInSnackBar(" تاكد من الاتصال بالانترنت ", Colors.red, _scaffoldKey);
      } else {
        if (value == true) {
          showInSnackBar("تم مسح الطلب بنجاح", Colors.green, _scaffoldKey);
          _getNotifcations();
          setState(() {
            _isLoading = false;
          });
        } else if (value == false) {
          setState(() {
            _isLoading = false;
          });
          showInSnackBar("حدث خطأ ما ", Colors.red, _scaffoldKey);
        }
      }
    });
  }
}
