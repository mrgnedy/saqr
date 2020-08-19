import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/serviceprovider.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class ProviderServiceCell extends StatelessWidget {
  final Data data;
  ProviderServiceCell({this.data});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(right: 12, left: 12, top: 12),
        decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width * .6,
              // color: Colors.blue,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _lable("  : مقدم الخدمة", this.data.userName ?? "-", context),
                  _lable("  : العنوان", this.data.address ?? "-", context),
                  _lable("  : رقم الجوال", this.data.phone ?? "-", context),
                  _lable("  : الحالة",this.data.isAvailable.toString()=="1"?"متاح":"غير متاح", context),
_ratingWedget(),
                ],
              ),
            ),
            Container(
              // color: Colors.red,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ClipOval(
                  child: CachedNetworkImage(
                    fit: BoxFit.fill,
                    imageUrl: ImageUserUrl + this.data.imageProfile,
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
          ],
        ));
  }
  _ratingWedget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
  
        SizedBox(
          width: 20,
        ),
        RatingBar(
          // initialRating: (widget.data.userAverageRatings != null)

          //     ? widget.data.userAverageRatings.toDouble()

          //     : 0.0,

          initialRating:
            this.data.totalRate == null ? 0 : this.data.totalRate*1.0,

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
        SizedBox(
          width: 20,
        ),
        Text(
          " :  التقييم",
          style:
              TextStyle(color: Colors.black, fontFamily: "black", height: 2),
        ),
        
      ],
    );
  }
  _lable(String lable, String value, BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Expanded(
            child: Text(
              value ?? "-",
              textAlign: TextAlign.right,
              overflow: TextOverflow.ellipsis,
              style:
                  TextStyle(color: Colors.grey, fontFamily: "black", height: 2),
            ),
          ),
          Text(
            lable ?? "-",
            textAlign: TextAlign.right,
            overflow: TextOverflow.ellipsis,
            style:
                TextStyle(color: Colors.black, fontFamily: "black", height: 2),
          ),
        ],
      ),
    );
  }
}
