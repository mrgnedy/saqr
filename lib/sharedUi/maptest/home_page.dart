import 'dart:async';

import 'package:fluster/fluster.dart';
import 'package:flutter/material.dart';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:saqr/ServiceProvider/serviceProviderDetails.dart';
import 'package:saqr/Utillity/ApiUtillity.dart';
import 'package:saqr/models/serviceprovider.dart';
import 'package:saqr/sharedUi/maptest/map_helper.dart';
import 'package:saqr/sharedUi/maptest/map_marker.dart';

class Home__Page extends StatefulWidget {
  final List<Data> data;

  Home__Page({this.data});

  @override
  _Home__PageState createState() => _Home__PageState();
}

class _Home__PageState extends State<Home__Page> {
  final Completer<GoogleMapController> _mapController = Completer();

  /// Set of displayed markers and cluster markers on the map
  final Set<Marker> _markers = Set();

  /// Minimum zoom at which the markers will cluster
  final int _minClusterZoom = 0;

  /// Maximum zoom at which the markers will cluster
  final int _maxClusterZoom = 19;

  /// [Fluster] instance used to manage the clusters
  Fluster<MapMarker> _clusterManager;

  /// Current map zoom. Initial zoom will be 15, street level
  double _currentZoom = 15;

  /// Map loading flag
  bool _isMapLoading = true;

  /// Markers loading flag
  bool _areMarkersLoading = true;

  /// Url image used on normal markers
  // final String _markerImageUrl =
  //     'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&w=1000&q=80';

  /// Color of the cluster circle
  final Color _clusterColor = Colors.blue;

  /// Color of the cluster text
  final Color _clusterTextColor = Colors.white;

  /// Example marker coordinates
  // final List<LatLng> _markerLocations = [
  //   LatLng(41.147125, -8.611249),
  //   LatLng(41.145599, -8.610691),
  //   LatLng(41.145645, -8.614761),
  //   LatLng(41.146775, -8.614913),
  //   LatLng(41.146982, -8.615682),
  //   LatLng(41.140558, -8.611530),
  //   LatLng(41.138393, -8.608642),
  //   LatLng(41.137860, -8.609211),
  //   LatLng(41.138344, -8.611236),
  //   LatLng(41.139813, -8.609381),
  // ];

  /// Called when the Google Map widget is created. Updates the map loading state
  /// and inits the markers.
  void _onMapCreated(GoogleMapController controller) {
    _mapController.complete(controller);

    setState(() {
      _isMapLoading = false;
    });

    _initMarkers();
  }

  /// Inits [Fluster] and all the markers with network images and updates the loading state.
  void _initMarkers() async {
    final List<MapMarker> markers = [];

    for (int i = 0; i < widget.data.length; i++) {
      try {
        final BitmapDescriptor markerImage =
            await MapHelper.getMarkerImageFromUrl(
                ImageUserUrl + widget.data[i].imageProfile,
                targetWidth: 120);
        markers.add(
          MapMarker(
              id: widget.data[i].userName.toString(),
              position:
                  LatLng(widget.data[i].lat ?? 0, widget.data[i].long ?? 0),
              icon: markerImage,
              navfaie: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return ServiceProviderDetails(
                    data: widget.data[i],
                  );
                }));
              }),
        );
      } catch (e) {
        print("-----------------------404--------------");
        print(e);
      }
    }

    _clusterManager = await MapHelper.initClusterManager(
      markers,
      _minClusterZoom,
      _maxClusterZoom,
    );

    await _updateMarkers();
  }

  /// Gets the markers and clusters to be displayed on the map for the current zoom level and
  /// updates state.
  Future<void> _updateMarkers([double updatedZoom]) async {
    if (_clusterManager == null || updatedZoom == _currentZoom) return;

    if (updatedZoom != null) {
      _currentZoom = updatedZoom;
    }

    setState(() {
      _areMarkersLoading = true;
    });

    final updatedMarkers = await MapHelper.getClusterMarkers(
      _clusterManager,
      _currentZoom,
      _clusterColor,
      _clusterTextColor,
      80,
    );

    _markers
      ..clear()
      ..addAll(updatedMarkers);

    setState(() {
      _areMarkersLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(),
      body: Stack(
        children: <Widget>[
          // Google Map widget
          Opacity(
            opacity: _isMapLoading ? 0 : 1,
            child: GoogleMap(
              mapToolbarEnabled: false,
              initialCameraPosition: CameraPosition(
                target:
                    LatLng(widget.data[0].lat ?? 0, widget.data[0].long ?? 0),
                zoom: _currentZoom,
              ),
              markers: _markers,
              onMapCreated: (controller) => _onMapCreated(controller),
              onCameraMove: (position) => _updateMarkers(position.zoom),
            ),
          ),

          // Map loading indicator
          Opacity(
            opacity: _isMapLoading ? 1 : 0,
            child: Center(child: CircularProgressIndicator()),
          ),

          // Map markers loading indicator
          if (_areMarkersLoading)
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Align(
                alignment: Alignment.topCenter,
                child: Card(
                  elevation: 2,
                  color: Colors.grey.withOpacity(0.9),
                  child: Padding(
                    padding: const EdgeInsets.all(4),
                    child: Text(
                      'Loading',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0, automaticallyImplyLeading: false,
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
      // leading: Padding(
      //   padding: const EdgeInsets.all(8.0),
      //   child: Container(
      //     color: Colors.grey[GREYDEGREE],
      //     child: IconButton(
      //       color: Colors.white,
      //       icon: Icon(Icons.notifications),
      //       onPressed: () {
      //         Navigator.push(context, MaterialPageRoute(builder: (context) {
      //           return NotifcationPage();
      //         }));
      //       },
      //     ),
      //   ),
      // ),
    );
  }
}
