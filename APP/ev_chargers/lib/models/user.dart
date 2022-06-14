import 'dart:convert';
import 'dart:io';
import 'package:ev_chargers/models/Car.dart';
import 'package:ev_chargers/models/credit_card.dart';
import 'package:http/io_client.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../helper.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  double accountBalance;

  User(this.id, this.firstName, this.lastName, this.email, this.password,
      this.accountBalance);

  static Future<String> register(
      String firstName, String lastname, String email, String password) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(
      Uri.parse('$url/user'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(
        {
          'firstName': firstName,
          'lastName': lastname,
          'email': email,
          'password': password
        },
      ),
    );
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      user = User(userData['id'], userData['firstName'], userData['lastName'],
          userData['email'], userData['password'], 0.0);
      return jsonDecode(response.body)['id'];
    } else {
      return '';
    }
  }

  static Future<bool> registerCard(String? userId, CreditCard card) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.put(
      Uri.parse('$url/user/bankCard'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(
        {
          'userId': userId,
          'cardNumber': card.cardNumber,
          'expiryDate': card.expiryDate,
          'cvvCode': card.cvvCode,
          'cardHolderName': card.cardHolderName
        },
      ),
    );
    return response.statusCode == 200;
  }

  static Future<bool> updatePassword(String password) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.put(
      Uri.parse(
          '$url/user/passwordChange?id=${user?.id}&newPassword=$password'),
    );
    return response.statusCode == 200;
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("loggedIn");
  }

  static Future getPersonalInformations(String? userId) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/user/getbyId?id=$userId'),
    );
    var userData = jsonDecode(response.body);
    user = User(userData['id'], userData['firstName'], userData['lastName'],
        userData['email'], userData['password'], userData['accountBalance']);
  }

  static Future<String> logIn(String email, String password) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient
        .get(Uri.parse('$url/user/login?email=$email&password=$password'));
    if (response.statusCode == 200) {
      var userData = jsonDecode(response.body);
      user = User(userData['id'], userData['firstName'], userData['lastName'],
          userData['email'], userData['password'], userData['accountBalance']);
      return jsonDecode(response.body)['id'];
    } else {
      return '';
    }
  }

  static Future addCash(String? userId, double value) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.put(
      Uri.parse('$url/user/addCash?id=$userId&amount=$value'),
    );
    if (response.statusCode == 200) {
      user?.accountBalance += value;
    }
  }

  static Future<bool> startCharging(String rfid) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/transaction/startCharging?userId=${user?.id}&rfid=$rfid'),
    );
    return response.statusCode == 200;
  }

  static Future<double> payForCharging(double kwh, String rfid) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(
      Uri.parse(
          '$url/transaction/stopCharging?userId=${user?.id}&kwh=$kwh&rfid=$rfid'),
    );

    if (response.statusCode == 200) {
      var priceToPay = double.parse(response.body);
      user?.accountBalance -= priceToPay;
      return priceToPay;
    }
    return 0.0;
  }

  static Future<List<Car>?> getCars() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/Car'),
    );
    Future<List<Car>?> cars = jsonDecode(response.body);
    return cars;
  }

  static Future<bool> setUsersCar(String carId) async {
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
