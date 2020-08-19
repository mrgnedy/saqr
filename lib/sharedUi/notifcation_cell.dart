import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/notifcationModel.dart';

class NotifcationCell extends StatelessWidget {
  final Data data;
  NotifcationCell({this.data});

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;

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
          Align(
              alignment: Alignment.topLeft,
              child: Padding(
                  padding: EdgeInsets.only(top: 12, left: 12),
                  child: Icon(Icons.close))),
          Container(
              width: w - (w * .2) - 80,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Text(
                  this.data.notfication.content.toString(),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                      color: Colors.black, fontFamily: "thin", height: 1.5),
                )),
              )),
          ClipRRect(
            borderRadius: BorderRadius.circular(1000000000),
            child: CachedNetworkImage(
                imageUrl: ImageUserUrl+this.data.notfication.user.imageProfile.toString(),
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
}
