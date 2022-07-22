import 'enums.dart';
import 'request.dart';
import 'response.dart';
import 'route_role.dart';

final corsHeaders = {
  'Content-Type': 'application/json;charset=UTF-8',
  "Access-Control-Allow-Origin": "*",
  'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE, OPTIONS',
  'Access-Control-Allow-Headers': '*'
};

class Context {
  late final Request request;
  late final Response response = Response();
  late Iterable<RouteRole> roles;
  late Map<dynamic, dynamic> store = {};

  String get path => request.path;

  HttpMethod get requestMethod => request.httpMethod;

  Context({required this.request});

  void setCors() => response.headers = corsHeaders;
}
