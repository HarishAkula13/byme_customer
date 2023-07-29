class EndPoint {
  final String base;
  final String path;

  EndPoint({required this.base, required this.path});
}

class EndPoints {
  static String _devBase = "hm34q0wcx8.execute-api.ap-south-1.amazonaws.com";
  static String _devAfterLoginBase = "9r6k2x4sph.execute-api.ap-south-1.amazonaws.com";
  static String get _base {return _devBase;}
  static String get _afterLoginBase {return _devAfterLoginBase;}

  static final  _api = '/Prod/';
  static String  env = 'dev';

  //verify user
  static EndPoint get verifyUser => _getEndPointWithPath(_api + 'otp-gen');
  static EndPoint get verifyOTP => _getEndPointWithPath(_api + 'verify-otp');
  static EndPoint get newRegister => _getEndPointWithPath(_api + 'new-registration');
  static EndPoint get userProfile => _getEndPointAfterLogin(_api + 'user-profile');



  static EndPoint _getEndPointWithPath(String path) {
    return EndPoint(base: _base, path: path);
  }

  static EndPoint _getEndPointAfterLogin(String path) {
    return EndPoint(base: _afterLoginBase, path: path);
  }

}