import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../helper.dart';

class Station {
  final String id;
  final String name;
  final String address;
  final double latitude;
  final double longitude;

  Station(this.id, this.name, this.address, this.latitude, this.longitude);

  static Future<List<Station>> getAllStations() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/station'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    List<Station> stations = [];
    for (var station in jsonDecode(response.body)) {
      stations.add(Station(station['id'], station['name'], station['address'],
          station['latitude'], station['longitude']));
    }
    return stations;
  }

  static Future<bool> createReservation(
      String? userId, String stationId, String reservationDateTime) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(
      Uri.parse('$url/reservation'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(
        {
          'userId': userId,
          'stationId': stationId,
          'reservationDateTime': reservationDateTime
        },
      ),
    );
    return response.statusCode == 200;
  }
}
