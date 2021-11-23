import 'dart:convert';

import 'package:http/http.dart';
import 'package:bytebank/http/webclient.dart';
import 'package:bytebank/models/transaction.dart';

class TransactionWebClient {
  static final Map<int, String> _statusCodeResponses = {
    400: 'There was an error submitting the transaction',
    401: 'Authentication failed',
    409: 'Transaction already exists!'
  };

  Future<List<Transaction>> findAll() async {
    final Response response = await client.get(baseUrl);
    final List<dynamic> decodedJson = jsonDecode(response.body);

    return decodedJson
        .map((dynamic json) => Transaction.fromJson(json))
        .toList();
  }

  Future<Transaction> save(Transaction transaction, String password) async {
    final String transactionJson = jsonEncode(transaction.toJson());

    await Future.delayed(Duration(seconds: 2));

    final Response response = await client.post(
      baseUrl,
      headers: {
        'Content-type': 'application/json',
        'password': password,
      },
      body: transactionJson,
    );

    if (response.statusCode == 200) {
      return Transaction.fromJson(jsonDecode(response.body));
    }

    throw HttpException(_getMessage(response.statusCode));
  }

  String _getMessage(int statusCode) {
    return _statusCodeResponses.containsKey(statusCode)
        ? _statusCodeResponses[statusCode]
        : 'Unknown error';
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}
