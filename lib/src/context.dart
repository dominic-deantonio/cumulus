import 'enums.dart';
import 'request.dart';
import 'response.dart';
import 'route_role.dart';

class Context {
  late final Request request;
  late final Response response = Response();
  late Iterable<RouteRole> roles;
  late Map<dynamic, dynamic> store = {};

  String get path => request.path;

  HttpMethod get requestMethod => request.httpMethod;

  Context({required this.request});
}
