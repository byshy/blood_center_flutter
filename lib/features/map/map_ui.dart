import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CentersMap extends StatefulWidget {
  final double lat;
  final double long;

  const CentersMap({Key key, this.lat, this.long}) : super(key: key);

  @override
  _CentersMapState createState() => _CentersMapState();
}

class _CentersMapState extends State<CentersMap> {
  Completer<GoogleMapController> _controller = Completer();

  static double lat = 0;
  static double long = 0;

  @override
  void initState() {
    super.initState();
    lat = widget.lat;
    long = widget.long;
  }

  final CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(lat, long),
    zoom: 10,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kGooglePlex,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
      ),
    );
  }
}
