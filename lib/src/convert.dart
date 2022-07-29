import 'package:aws_lambda_dart_runtime/events/alb_event.dart';
import 'package:shelf/src/request.dart' as shelf; // TODO: Remove?
import 'package:shelf/src/response.dart' as shelf; // TODO: Remove?

import 'enums.dart';
import 'response.dart';

class Convert {
  static AwsALBResponse toAlbResponse(Response response) {
    print('Headers before converting to ALB Response ${response.headers}');
    return AwsALBResponse(
      body: response.body,
      statusCode: response.statusCode,
      isBase64Encoded: false,
      headers: response.headers,
    );
  }

  static shelf.Response toShelfResponse(Response response) {
    return shelf.Response(
      response.statusCode,
      body: response.body,
      headers: response.headers,
    );
  }

  static Future<AwsALBEvent> toAwsALBEvent(shelf.Request request) async {
    return AwsALBEvent.fromJson({
      'context': null,
      'httpMethod': request.method,
      'path': '/${request.url.path}',
      'headers': request.headers,
      'queryStringParameters': request.url.queryParameters,
      'body': await request.readAsString(),
      'isBase64Encoded': false,
    });
  }

  static String toRouteKey(HttpMethod m, String path) => '${m.toShortString()}-$path';
}
