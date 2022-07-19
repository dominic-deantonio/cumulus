enum HttpMethod {
  GET,
  POST,
  PUT,
  PATCH,
  DELETE,
  HEAD,
  TRACE,
  CONNECT,
  OPTIONS,
  BEFORE,
  AFTER,
  INVALID;

  static HttpMethod fromString(String s) => HttpMethod.values.firstWhere((e) => e.toShortString() == s);

  String toShortString() => toString().split('.').last;
}
