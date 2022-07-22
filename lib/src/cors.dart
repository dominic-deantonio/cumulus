import 'package:cumulus/cumulus.dart';

class Cors {
  static Route route = Route(
    path: 'any',
    handler: (Context c) {
      final headers = {
        'Content-Type': 'application/json;charset=UTF-8',
        "Access-Control-Allow-Origin": "*",
        'Access-Control-Allow-Methods': 'GET, PUT, POST, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': '*'
      };
      c.response.headers = headers;
    },
    method: HttpMethod.OPTIONS,
  );
}
