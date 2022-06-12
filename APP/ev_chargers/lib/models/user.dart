import 'dart:convert';
import 'dart:io';
import 'package:ev_chargers/models/credit_card.dart';
import 'package:http/io_client.dart';
import '../helper.dart';

class User {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final double accountBalance;
  static const url = 'https://localhost:7234/api';

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
          userData['email'], userData['password'], userData['accountBalance']);
      return jsonDecode(response.body)["id"];
    } else {
      return "";
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

  static Future getData(String? userId) async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/user/getbyId?id=$userId'),
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
      },
    );
    var userData = jsonDecode(response.body);
    print(userData);
    user = User(userData['id'], userData['firstName'], userData['lastName'],
        userData['email'], userData['password'], userData['accountBalance']);
  }
}
