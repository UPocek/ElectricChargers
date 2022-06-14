import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../helper.dart';

class Car {
  final String id;
  final String model;
  final String make;

  Car(this.id, this.model, this.make);

  static Future<List<Car>> getCars() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/car'),
    );

    List<Car> cars = [];
    for (var car in jsonDecode(response.body)) {
      cars.add(Car(car['id'], car['model'], car['make']));
    }
    return cars;
  }

  static Future<bool> setUsersCar(String? carId) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(
      Uri.parse('$url/Car/setPersonsCar?userId=${user?.id}&carId=$carId'),
    );
    if (response.statusCode == 200) {
      return true;
    } else {
      return false;
    }
  }
}
