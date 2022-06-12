import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';


class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  Position? position;
  LatLng? _center;
  final Set<Marker> _markers = {};

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  getUserLocation() async {
    position = await _determinePosition();
    var lat = position?.latitude;
    var lng = position?.longitude;
    if (lat != null && lng != null) {
      setState(() {
        _center = LatLng(lat, lng);
      });
    }
  }

  void setUpMarkers() {
    for (var position in [
      const LatLng(45.2396, 19.8227),
      const LatLng(45.2490, 19.8290)
    ]) {
      setState(() {
        _markers.add(
          Marker(
            markerId: MarkerId(position.toString()),
            position: position,
            infoWindow: const InfoWindow(
              title: 'Really cool place',
              snippet: '5 Star Rating',
            ),
            icon: BitmapDescriptor.defaultMarkerWithHue(
                BitmapDescriptor.hueAzure),
            onTap: () {
              print("Radi");
            },
          ),
        );
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getUserLocation();
    setUpMarkers();
  }

  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _center != null
          ? GoogleMap(
              onMapCreated: _onMapCreated,
              initialCameraPosition: CameraPosition(
                target: _center ?? const LatLng(0, 0),
                zoom: 13.0,
              ),
              markers: _markers,
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
