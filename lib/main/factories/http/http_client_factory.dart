import 'package:http/http.dart';
import 'package:shoppinglist/data/http/http_client.dart';
import 'package:shoppinglist/infra/http/http.dart';

HttpClient makeHttpAdapter() => HttpAdapter(Client());
