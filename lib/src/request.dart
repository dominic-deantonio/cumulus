import 'package:aws_lambda_dart_runtime/aws_lambda_dart_runtime.dart';

import 'enums.dart';

class Request {
  final AwsALBEvent _event;

  HttpMethod get httpMethod => _event.httpMethod == null ? HttpMethod.INVALID : HttpMethod.fromString(_event.httpMethod!);

  String get path => _event.path ?? 'error';

  Map<String, dynamic> get headers => _event.headers ?? {};

  Map<String, dynamic> get queryStringParameters => _event.queryStringParameters ?? {};

  String? get body => _event.body;

  bool get isBase64Encoded => _event.isBase64Encoded ?? false;

  Request.fromAwsALBEvent(this._event);
}
