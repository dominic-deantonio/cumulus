enum HttpMethod {
  get,
  post,
  put,
  patch,
  delete,
  head,
  trace,
  connect,
  options,
  before,
  after,
  invalid;

  static HttpMethod fromString(String s) => HttpMethod.values.firstWhere((e) => e.toShortString() == s);

  String toShortString() => toString().split('.').last;
}
