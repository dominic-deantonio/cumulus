import 'dart:async';

import 'context.dart';
import 'convert.dart';
import 'enums.dart';
import 'route_role.dart';

class Route {
  final HttpMethod method;
  final String path;
  final FutureOr<String?> Function(Context c) handler;
  final Iterable<FutureOr<String?> Function(Context c)> middleware;
  final Iterable<FutureOr<String?> Function(Context c)> before;
  final Iterable<FutureOr<String?> Function(Context c)> after;
  final Iterable<RouteRole> roles;

  Route({
    required this.path,
    required this.handler,
    required this.method,
    this.middleware = const [],
    this.before = const [],
    this.after = const [],
    this.roles = const [],
  });

  String get key => Convert.toRouteKey(method, path);

  Future<void> process(Context c) async {
    c.roles = roles;

    // Run before handlers
    String? result = await runHandlers(before, c);
    if (result != null) {
      c.response.setBody(result);
      return;
    }

    // Run middleware handlers
    result = await runHandlers(middleware, c);
    if (result != null) {
      c.response.setBody(result);
      return;
    }

    // Run main handler
    result = await handler(c);
    c.response.setBody(result ?? '');

    // Run after handlers
    await runHandlers(after, c);
  }

  Future<dynamic> runHandlers(Iterable<FutureOr<String?> Function(Context c)> handlers, Context c) async {
    for (FutureOr<String?> Function(Context c) handler in handlers) {
      var result = await handler(c);
      if (result != null) return result; // Immediately stops processing
    }
  }
}
