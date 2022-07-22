import 'package:cumulus/cumulus.dart';

class Cors {
  static Route route = Route(
    path: 'any',
    handler: (Context c) {
      c.response.headers["Access-Control-Allow-Methods"] = "*";
      c.response.headers['Access-Control-Allow-Origin'] = '*';
    },
    method: HttpMethod.OPTIONS,
  );
}