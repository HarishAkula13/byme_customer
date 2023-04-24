class EndPoint {
  final String base;
  final String path;

  EndPoint({required this.base, required this.path});
}

class EndPoints {
  static String _devBase = "beta5.365hosting.in";
  static String get _base {return _devBase;}

  static final  _api = '/kalsan_dev/api/';

  //login
  static EndPoint get login => _getEndPointWithPath(_api + 'login');
  //forgot
  static EndPoint get forgot => _getEndPointWithPath(_api + 'forgot_password');

  static EndPoint _getEndPointWithPath(String path) {
    return EndPoint(base: _base, path: path);
  }
}