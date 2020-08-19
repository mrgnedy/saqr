import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/ApiRequestes.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/notifcationModel.dart';
import 'package:saqr/screens/NotifcationPage/AcceptOrder.dart';
import 'package:saqr/screens/NotifcationPage/AcceptProviderPrice.dart';
import 'package:saqr/sharedUi/notifcation_cell.dart';
import 'package:saqr/widgets/Drawer.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class NotifcationPage extends StatefulWidget {
  @override
  _NotifcationPageState createState() => _NotifcationPageState();
}

class _NotifcationPageState extends State<NotifcationPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  ApiRequests _apiRequests = new ApiRequests();
  NotifcationModel _data;
  bool _isLoading = true;
  @override
  void initState() {
    _getNotifcations();
    // TODO: implement initState
    super.initState();
  }
double w ;
double h ;
  @override
  Widget build(BuildContext context) {
    w = MediaQuery.of(context).size.width;
    h= MediaQuery.of(context).size.height;
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
          mainText("الاشعارات"),
          _isLoading
              ? LOADING()
              : _data == null
                  ? NoInterNetConnection()
                  :_data.data.length==0?NoDataFound(): Expanded(
                      child: ListView.builder(
                          itemCount: _data.data.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                                onTap: () {
                                  if (_data.data[index].notfication.type == 1) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AcceptOrder(
                                          data: _data.data[index]);
                                    }));
                                  } else if (_data
                                          .data[index].notfication.type ==
                                      3) {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: (context) {
                                      return AcceptProviderPrice(
                                          data: _data.data[index]);
                                    }));
                                  }
                                },
                                child:
                                    notifcation( _data.data[index]));
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
    _apiRequests.getNotifcation().then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
    });
  }
  notifcation(Data data){
     return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * .15,
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
            onTap: (){
              deletenotifcation(data.notfication.id.toString());
                          },
                                    child: Align(
                              alignment: Alignment.topLeft,
                              child: Padding(
                                  padding: EdgeInsets.only(top: 12, left: 12),
                                  child: Icon(Icons.close))),
                        ),
                        InkWell(
                           onTap: () {
                                                if (data.notfication.type == 1) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) {
                                                    return AcceptOrder(
                                                        data: data);
                                                  }));
                                                } else if (data.notfication.type ==
                                                    3) {
                                                  Navigator.push(context,
                                                      MaterialPageRoute(builder: (context) {
                                                    return AcceptProviderPrice(
                                                        data:data);
                                                  }));
                                                }
                                              },
                                    child: Container(
                              width: w - (w * .2) - 80,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: SingleChildScrollView(
                                    child: Text(
                                data.notfication.content.toString(),
                                  textAlign: TextAlign.right,
                                  style: TextStyle(
                                      color: Colors.black, fontFamily: "thin", height: 1.5),
                                )),
                              )),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(1000000000),
                          child: CachedNetworkImage(
                              imageUrl: ImageUserUrl+data.notfication.user.imageProfile.toString(),
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
   _isLoading=true;
});
_apiRequests.deleteNotifcaton(id).then((value){

if(value==null){
  setState(() {
   _isLoading=false;
});
showInSnackBar(" تاكد من الاتصال بالانترنت ", Colors.red, _scaffoldKey);
}else{
  if(value==true){
     showInSnackBar("تم مسح الاشعار بنجاح", Colors.green, _scaffoldKey);
         _getNotifcations();
         setState(() {
   _isLoading=false;
});
  }else if(value ==false){
    setState(() {
   _isLoading=false;
});
showInSnackBar("حدث خطأ ما ", Colors.red, _scaffoldKey);
  }
}
});








                }
 
}
