import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
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
  static const url = 'https://localhost:7234/api';

  User(this.id, this.firstName, this.lastName, this.email, this.password);

  // static Future<String> register(
  //     String firstName, String lastname, String email, String password) async {
  //   bool trustSelfSigned = true;
  //   HttpClient httpClient = HttpClient()
  //     ..badCertificateCallback =
  //         ((X509Certificate cert, String host, int port) => trustSelfSigned);
  //   IOClient ioClient = IOClient(httpClient);

  //   var response = await ioClient.post(
  //     Uri.parse('$url/user'),
  //     headers: {
  //       HttpHeaders.contentTypeHeader: 'application/json',
  //     },
  //     body: json.encode(
  //       {
  //         'firstName': firstName,
  //         'lastName': lastname,
  //         'email': email,
  //         'password': password
  //       },
  //     ),
  //   );
  //   if (response.statusCode == 200) {
  //     print(jsonDecode(response.body));
  //     user = jsonDecode(response.body);
  //     return jsonDecode(response.body)["id"];
  //   } else {
  //     return "";
  //   }
  // }

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
          '$url/User/passwordChange?id=ec5a6236-302c-4017-afe4-204fc6b8aea3&newPassword=marko123'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
      body: json.encode(
        {'password': password},
      ),
    );
    return response.statusCode == 200;
  }

  static Future<String> logIn(String email, String password) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/User/login?id=' + email + "&newPassword=" + password),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );

    if (response.statusCode == 200) {
      print(jsonDecode(response.body));
      user = jsonDecode(response.body);
      return jsonDecode(response.body)["id"];
    } else {
      return "";
    }
  }

  static logOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove("loggedIn");
  }

  static Future getData(String? userId) async {
    if (userId != null) {
      var response = await http.get(Uri.parse('$url/user/getbyId/$userId'));
      user = jsonDecode(response.body);
    }
  }

  static Future<double> getBalance() async {
    var response = await http.get(Uri.parse('$url/user/accountBalance'));
    return jsonDecode(response.body);
  }
}
