class EndPoint {
  final String base;
  final String path;

  EndPoint({required this.base, required this.path});
}

class EndPoints {
  static String _devBase = "hm34q0wcx8.execute-api.ap-south-1.amazonaws.com";
  static String _devAfterLoginBase = "9r6k2x4sph.execute-api.ap-south-1.amazonaws.com";
  static String _devDashboard = "jfdcmi11o9.execute-api.ap-south-1.amazonaws.com";
  static String _devAdress = "99q5c2c7pj.execute-api.ap-south-1.amazonaws.com";
  static String _devCart='1qohp0sd3j.execute-api.ap-south-1.amazonaws.com';
  static String _devOrderList='1qohp0sd3j.execute-api.ap-south-1.amazonaws.com';

  static String get _base {return _devBase;}
  static String get _afterLoginBase {return _devAfterLoginBase;}

  static final  _api = '/Prod/';
  static String  env = 'dev';

  //verify user
  static EndPoint get verifyUser => _getEndPointWithPath(_api + 'otp-gen');
  static EndPoint get verifyOTP => _getEndPointWithPath(_api + 'verify-otp');
  static EndPoint get newRegister => _getEndPointWithPath(_api + 'new-registration');
  static EndPoint get userProfile => _getEndPointAfterLogin(_api + 'user-profile');
  static EndPoint get fetchServices => _getEndPointAfterDashboard(_api + 'fetch-services');
  static EndPoint get saveAddress => _getEndPointAddress(_api + 'new-add');
  static EndPoint get getAddress => _getEndPointAddress(_api + 'saved-add');
  static EndPoint get getAddressCheck => _getEndPointAddress(_api + 'add-check');
  static EndPoint get getorderList => _getEndPointOrderList(_api + 'sn-order-list');
  static EndPoint get addCart => _getEndPointCart(_api + 'sn-add-item');


  static EndPoint _getEndPointWithPath(String path) {
    return EndPoint(base: _base, path: path);
  }

  static EndPoint _getEndPointAfterLogin(String path) {
    return EndPoint(base: _afterLoginBase, path: path);
  }

  static EndPoint _getEndPointAfterDashboard(String path) {
    return EndPoint(base: _devDashboard, path: path);
  }
  static EndPoint _getEndPointAddress(String path) {
    return EndPoint(base: _devAdress, path: path);
  }
  static EndPoint _getEndPointCart(String path) {
    return EndPoint(base: _devCart, path: path);
  }
  static EndPoint _getEndPointOrderList(String path) {
    return EndPoint(base: _devOrderList, path: path);
  }
}