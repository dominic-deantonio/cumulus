import 'dart:convert';

import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';
import 'package:shelf/src/response.dart' as shelf;

import 'convert.dart';

class Response {
  // This class is late because need to initialize headers while keeping the ctor signature clean
  // Only constants can be used as optional parameter value, which means the headers would be immutable
  // which means we can't add headers. So an optional param is passed into the ctor instead of initializing headers
  // If you can think of a better way (while keeping consistent, clean ctor params), please do it.
  late Map<String, String> headers = {};
  late String body;
  late int statusCode;

  Response({String body= '', int statusCode= 200, Map<String, String>? headers}) {
    this.headers = headers ?? {};
    this.body = body;
    this.statusCode = statusCode;
  }

  static Response routeNotFound() {
    print('Route not found');
    return Response(body: jsonEncode({'error': 'route not found'}));
  }

  void setContentType(String s) => headers['content-type'] = s;

  void setBody(String result) => body = result;

  AwsALBResponse toAwsAlbResponse() => Convert.toAlbResponse(this);

  shelf.Response toShelfResponse() => Convert.toShelfResponse(this);
}
