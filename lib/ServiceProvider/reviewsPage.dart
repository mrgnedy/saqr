import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:saqr/ApiRequestes.dart';

import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/dataUser.dart';
import 'package:saqr/models/reviewModel.dart';

import 'package:saqr/screens/NotifcationPage/View.dart';

import 'package:saqr/sharedUi/providerServiceCell.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class RewiewsPage extends StatefulWidget {
  final int id;
  RewiewsPage({this.id});
  @override
  _RewiewsPageState createState() => _RewiewsPageState();
}

class _RewiewsPageState extends State<RewiewsPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  ReviewModel _data = new ReviewModel();

  ApiRequests _apiRequests = new ApiRequests();
  bool _isLoading = true;
  DataUser _dataUser = DataUser.instance;
  double lat;
  double long;

  @override
  void initState() {
    // TODO: implement initState
    _getprovidersservices();
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          mainText("التعليقات"),
          _isLoading
              ? LOADING()
              : _data == null ? NoInterNetConnection() : _servicProvidersList(),
        ],
      ),
    );
  }

  _servicProvidersList() {
    print("user id ");
    print(_dataUser.getKey(Id).toString());
    return _data.data.length == 0
        ? Center(child: NoDataFound())
        : Expanded(
            child: ListView.builder(
                itemCount: _data.data.length,
                shrinkWrap: true,
                itemBuilder: (context, idx) {
                  return _dataWiget(_data.data[idx]);
                }),
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
      leading: Padding(
        padding: const EdgeInsets.all(8.0),
        child: _dataUser.getKey(ISLOGING).toString() == "null"
            ? Container()
            : Container(
                color: Colors.grey[GREYDEGREE],
                child: IconButton(
                  color: Colors.white,
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return NotifcationPage();
                    }));
                  },
                ),
              ),
      ),
    );
  }

  _dataWiget(Data data) {
    return Container(
    
      margin: EdgeInsets.only(right: 12, left: 12, top: 12),
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.grey, width: 1),
          borderRadius: BorderRadius.circular(12)),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        
        children: <Widget>[
              Container(
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: ImageUserUrl +   data.imageProfileCustomer,
                    placeholder: (context, url) => LOADING(),
                    height: MediaQuery.of(context).size.width * .23,
                    width: MediaQuery.of(context).size.width * .23,
                    errorWidget: (context, url, error) => Icon(
                      Icons.error,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ),
             Text(
            data.nameCustomer.toString(),
            style: TextStyle(
              color: Colors.black,
              fontFamily: "black",
            ),
          ),
          RatingBar(
            // initialRating: (widget.data.userAverageRatings != null)

            //     ? widget.data.userAverageRatings.toDouble()

            //     : 0.0,

            initialRating: data.rate.rate == null ? 0.0: data.rate.rate*1.0,

            //  minRating: 1,
            itemSize: 20,
            direction: Axis.horizontal,

            allowHalfRating: true,

            itemCount: 5,

            // itemPadding: EdgeInsets.symmetric(
            //     horizontal: 4.0),

            itemBuilder: (context, _) => Icon(
              Icons.star,
              color: Colors.amber,
            ),

            ignoreGestures: true,

            unratedColor: Colors.grey,

            onRatingUpdate: (rating) {
              print("mahmoud");

              // print(widget.data.userAverageRatings);
            },
          ),
          // Text(
          //   data.nameCustomer.toString(),
          //   style: TextStyle(
          //     color: Colors.black,
          //     fontFamily: "black",
          //   ),
          // ),
          Text(
            data.rate.review,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.grey[500],
              fontFamily: "thin",
            ),
          )
        ],
      ),
    );
  }

  _getprovidersservices() {
    _apiRequests.getReviews(widget.id.toString()).then((value) {
      print(value);
      setState(() {
        _data = value;
        _isLoading = false;
      });
    });
  }
}
