import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_map_tracking/constants.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class OrderTrackingPage extends StatefulWidget {
  const OrderTrackingPage({Key? key}) : super(key: key);

  @override
  State<OrderTrackingPage> createState() => OrderTrackingPageState();
}

class OrderTrackingPageState extends State<OrderTrackingPage> {
  final Completer<GoogleMapController> _controller = Completer();

  static const LatLng sourceLocation = LatLng(37.33500926, -122.03272188);
  static const LatLng destination = LatLng(37.33429383, -122.06600055);

  List<LatLng> polylineCoordinates = [];
  LocationData? currentLocation;

  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor currentLocationIcon = BitmapDescriptor.defaultMarker;

  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        google_api_key,
        PointLatLng(sourceLocation.latitude, sourceLocation.longitude),
        PointLatLng(destination.latitude, destination.longitude));

    if (result.points.isNotEmpty) {
      setState(() {
        for (var point in result.points) {
          polylineCoordinates.add(LatLng(point.latitude, point.longitude));
        }
      });
    }
  }

  void getCurrentLocation() async {
    Location location = Location();

    location.getLocation().then((value) => currentLocation = value);

    GoogleMapController googleMapController = await _controller.future;

    location.onLocationChanged.listen((newLocation) {
      setState(() {
        currentLocation = newLocation;

        googleMapController.animateCamera(CameraUpdate.newCameraPosition(
            CameraPosition(zoom: 13.5, target: LatLng(newLocation.latitude!, newLocation.longitude!))));
      });
    });
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/Pin_source.png').then((value) => sourceIcon = value);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/Pin_destination.png')
        .then((value) => destinationIcon = value);
    BitmapDescriptor.fromAssetImage(ImageConfiguration.empty, 'assets/Badge.png')
        .then((value) => currentLocationIcon = value);
  }

  @override
  void initState() {
    getCurrentLocation();
    getPolyPoints();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Track order",
          style: TextStyle(color: Colors.black, fontSize: 16),
        ),
      ),
      body: SafeArea(
        child: currentLocation == null
            ? const Center(
                child: CupertinoActivityIndicator(),
              )
            : GoogleMap(
                // vị trị hiện thỉ camera
                // initialCameraPosition: const CameraPosition(target: OrderTrackingPageState.sourceLocation, zoom: 14.5),
                initialCameraPosition:
                    CameraPosition(target: LatLng(currentLocation!.latitude!, currentLocation!.longitude!), zoom: 14.5),
                // vẽ điểm chỉ vị trí theo locatin
                markers: {
                  Marker(
                      markerId: const MarkerId("currentLocation"),
                      position: LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
                      icon: currentLocationIcon),
                  Marker(
                      markerId: const MarkerId("source"), position: OrderTrackingPageState.sourceLocation, icon: sourceIcon),
                  Marker(
                      markerId: const MarkerId("destination"),
                      position: OrderTrackingPageState.destination,
                      icon: destinationIcon)
                },
                // vẽ đường đi
                polylines: {
                  Polyline(polylineId: const PolylineId("route"), points: polylineCoordinates, color: primaryColor, width: 6)
                },
                onMapCreated: (mapController) {
                  _controller.complete(mapController);
                },
              ),
      ),
    );
  }
}
