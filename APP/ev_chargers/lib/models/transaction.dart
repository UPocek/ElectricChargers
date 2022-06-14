import 'dart:convert';
import 'dart:io';
import 'package:http/io_client.dart';
import '../helper.dart';

class Transaction {
  final String transactionDate;
  final String station;
  final double price;
  final double kwh;
  Transaction(this.transactionDate, this.station, this.price, this.kwh);

  static Future<List<Transaction>> getLastFive() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/transaction/getForUser?userId=${user?.id}'),
    );
    List<Transaction> transactions = [];
    for (var transaction in jsonDecode(response.body)) {
      transactions.add(Transaction(
          '${transaction['transactionDate'].toString().split('T')[0]} ${transaction['transactionDate'].toString().split('T')[1].substring(0, 5)}',
          transaction['fullStation']['name'],
          transaction['price'],
          transaction['kwh']));
    }
    return transactions;
  }

  static Future<double> getStats() async {
    bool trustSelfSigned = true;
    HttpClient httpClient = HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    IOClient ioClient = IOClient(httpClient);

    var response = await ioClient.get(
      Uri.parse('$url/transaction/stats?userId=${user?.id}'),
    );

    return (jsonDecode(response.body)['kwh']) + 0.0;
  }
}
