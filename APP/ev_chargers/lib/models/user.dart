import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';

class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  static var url = Uri.parse('https://localhost:7222/api/login');

  static Future<bool> register(
      String firstName, String lastname, String email, String password) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.post(url,
        headers: {
          HttpHeaders.contentTypeHeader: 'application/json',
        },
        body: json.encode({
          'firstName': firstName,
          'lastName': lastname,
          'email': email,
          'password': password
        }));
    return response.statusCode == 200;
  }

  User(this.firstName, this.lastName, this.email, this.password);

