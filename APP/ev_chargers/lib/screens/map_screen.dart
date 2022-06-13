import 'dart:async';
import 'package:ev_chargers/models/station.dart';
import 'package:ev_chargers/screens/create_reservation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

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

  void setUpMarkers() async {
    List<Station> stations = await Station.getAllStations();
    for (Station station in stations) {
      setState(
        () {
          _markers.add(
            Marker(
              markerId: MarkerId(station.id),
              position: LatLng(station.latitude, station.longitude),
              infoWindow: InfoWindow(
                title: station.name,
                snippet: station.address,
              ),
              icon: BitmapDescriptor.defaultMarker,
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: ((context) => MakeReservationScreen(
                        station.id, station.name, station.address)),
                  ),
                );
              },
            ),
          );
        },
      );
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
              zoomGesturesEnabled: true,
              scrollGesturesEnabled: true,
              mapType: MapType.normal,
              gestureRecognizers: {}..add(
                  Factory<PanGestureRecognizer>(
                    () => PanGestureRecognizer(),
                  ),
                ),
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
