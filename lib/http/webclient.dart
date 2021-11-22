import 'package:bytebank/http/interceptors/logging_interceptors.dart';
import 'package:http/http.dart';
import 'package:http_interceptor/http_interceptor.dart';

final Client client = InterceptedClient.build(
  interceptors: [LoggingInterceptor()],
  requestTimeout: Duration(seconds: 5),
);

final Uri baseUrl = Uri.parse('http://192.168.15.248:8080/transactions');
