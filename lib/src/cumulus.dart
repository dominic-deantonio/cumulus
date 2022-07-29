import 'package:aws_lambda_dart_runtime/events/alb_event.dart';
import 'package:cumulus/cumulus.dart';
import 'package:shelf/src/request.dart' as Shelf;
import 'package:shelf/src/response.dart' as Shelf;

import 'context.dart';
import 'convert.dart';
import 'cors.dart';
import 'request.dart';
import 'response.dart';
import 'route.dart';

class Cumulus {
  final AwsALBEvent _event;
  late final Context _context;
  late final Map<String, Route> routes = {};
  bool allowCors = true;

  Cumulus(this._event, [Iterable<Route> routes = const []]) {
    _context = Context(request: Request.fromAwsALBEvent(_event));
    addRoutes(routes);
  }

  static Future<Cumulus> fromShelf(Shelf.Request request, Iterable<Route>? routes) async => Cumulus(
        await Convert.toAwsALBEvent(request),
        routes ?? [],
      );

  Future<Response> _respond() async {
    print('Is cors allowed: $allowCors');
    if (allowCors) _context.setCors();
    Route? route = _getRoute();
    if (route == null) return Response.routeNotFound();
    await route.process(_context);
    return _context.response;
  }

  void addRoutes(Iterable<Route> routes) => routes.forEach((route) => this.routes[route.key] = route);

  void addRoute(Route route) => addRoutes([route]);

  Future<AwsALBResponse> getAwsAlbResponse() async {
    try {
      return (await _respond()).toAwsAlbResponse();
    } catch (e) {
      print(e);
      return AwsALBResponse(body: "Internal error");
    }
  }

  Future<Shelf.Response> getShelfResponse() async => (await _respond()).toShelfResponse();

  Route? _getRoute() {
    if (_context.requestMethod == HttpMethod.OPTIONS) return Cors.route;
    // Should improve this in the future to support real URI schemes
    String key = Convert.toRouteKey(_context.requestMethod, _context.path);
    return routes[key];
  }
}
