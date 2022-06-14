import 'dart:async';
import 'package:ev_chargers/models/station.dart';
import 'package:ev_chargers/screens/create_reservation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';

class MapWidget extends StatefulWidget {
  final LatLng? userPosition;

  const MapWidget(this.userPosition, {Key? key}) : super(key: key);

  @override
  State<MapWidget> createState() => _MapWidgetState();
}

class _MapWidgetState extends State<MapWidget> {
  final Set<Marker> _markers = {};

  final Completer<GoogleMapController> _controller = Completer();
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void setUpMarkers() async {
    List<Station> stations = await Station.getAllStations();
    for (Station station in stations) {
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
                builder: ((context) => CreateReservationScreen(
                    station.id, station.name, station.address)),
              ),
            );
          },
        ),
      );
    }
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    setUpMarkers();
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      onMapCreated: _onMapCreated,
      initialCameraPosition: CameraPosition(
        target: widget.userPosition ?? const LatLng(0, 0),
        zoom: 13.0,
      ),
      markers: _markers,
      zoomGesturesEnabled: true,
      scrollGesturesEnabled: true,
      gestureRecognizers: {}..add(
          Factory<PanGestureRecognizer>(
            () => PanGestureRecognizer(),
          ),
        ),
    );
  }
}
