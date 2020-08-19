import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/widgets/commnDesgin.dart';

class HomeCell extends StatelessWidget {
  final String name;
  final String image;

  HomeCell({this.name, this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2.6,
      height: MediaQuery.of(context).size.height / 4.5,
      margin: EdgeInsets.only(right: 8, left: 8, bottom: 8),
      child: Neumorphic(
        boxShape: NeumorphicBoxShape.roundRect(
          BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: GridTile(
              child: CachedNetworkImage(
                fit: BoxFit.fill,
                imageUrl: this.image.toString(),
                placeholder: (context, url) => LOADING(),
                errorWidget: (context, url, error) => Icon(
                  Icons.error,
                  color: Colors.black,
                ),
              ),
              footer: Container(
                color: Colors.grey[200],
                // padding: EdgeInsets.all(8),

                child: Text(this.name.toString(),
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontFamily: "thin",
                    )),
              )),
        ),
      ),
    );
  }
}
