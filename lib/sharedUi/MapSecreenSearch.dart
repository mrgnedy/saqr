import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/serviceprovider.dart';

class MapScreeenSearch extends StatefulWidget {
  final String name;
  final double lat;
  final double long;
  final List<Data> data;
  MapScreeenSearch({this.name, this.lat, this.long, this.data});
  @override
  _MapScreeenSearchState createState() => _MapScreeenSearchState();
}

class _MapScreeenSearchState extends State<MapScreeenSearch> {
  double userLat = 31.205753;
  double userLng = 29.924526;

  // double currentLat;
  // double currentLng;
  // String currentAddress;
  BitmapDescriptor myIcon;

  Set<Marker> mark = Set();
  GoogleMapController myController;
  List<Marker> markers = [];

  var location = Location();
  String tpe = 'user';

  ///////////////////////////////
  ///
  ///
  ///
  ///
  ///
  /////////////////////////////

  @override
  void initState() {
    setState(() {
      markers.add(Marker(
        markerId: MarkerId(widget.name ?? "مقدم الخدمة"),
        draggable: true,
        position: LatLng(
          widget.lat ?? userLat,
          widget.long ?? userLng,
        ),
        icon: BitmapDescriptor.defaultMarker,
        onTap: () {
          _changeMapType();
        },
        infoWindow: InfoWindow(title: widget.name ?? ""),
      ));
    });

    super.initState();
  }

  MapType _defaultMapType = MapType.normal;

  _changeMapType() {
    setState(() {
      _defaultMapType = _defaultMapType == MapType.satellite
          ? MapType.terrain
          : MapType.hybrid;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    setState(() {
      myController = controller;
    });
  }

  Position updatedPosition;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: userLng == null && userLat == null
          ? Center(
              child: CupertinoActivityIndicator(
              animating: true,
              radius: 15,
            ))
          : Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height - 200,
                    width: MediaQuery.of(context).size.width,
                    child: GoogleMap(
                      mapType: _defaultMapType,
                      myLocationEnabled: true,
                      onMapCreated: _onMapCreated,
                      markers: Set.from(markers),
                      initialCameraPosition: CameraPosition(
                          target: LatLng(
                              widget.lat ?? userLat, widget.long ?? userLng),
                          zoom: 15.0),
                    ),
                  ),
                  Container(
                    height: 100,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.grey[GREYDEGREE],
                    child: Center(
                        child: Text(
                      "للتتبع اضغط علي الماركر ثم اضغط علي الاتجاهات",
                      textAlign: TextAlign.center,
                      style:
                          TextStyle(color: Colors.white, fontFamily: "black"),
                    )),
                  )
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
                  },
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Marker marker = Marker(
    markerId: MarkerId("1"),
  );
}
