class EndPoint {
  final String base;
  final String path;

  EndPoint({required this.base, required this.path});
}

class EndPoints {
  static const String _devBase = "hm34q0wcx8.execute-api.ap-south-1.amazonaws.com";
  static const String _devAfterLoginBase = "9r6k2x4sph.execute-api.ap-south-1.amazonaws.com";
  static const String _devDashboard = "jfdcmi11o9.execute-api.ap-south-1.amazonaws.com";
  static const String _devAdress = "99q5c2c7pj.execute-api.ap-south-1.amazonaws.com";
  static const String _devCart='1qohp0sd3j.execute-api.ap-south-1.amazonaws.com';
  static const String _devOrderList='hjnqjilzbl.execute-api.ap-south-1.amazonaws.com';
  static const String _devPriceSchedule="vcm4lx6avh.execute-api.ap-south-1.amazonaws.com";
  static const String _devShop='qb3kkl0w03.execute-api.ap-south-1.amazonaws.com';
  static String terms="https://eutnc.by-me.in/terms-and-conditions";
  static String privacy="https://eutnc.by-me.in/privacy-policy";
  static String refund="https://eutnc.by-me.in/refund-policy";

  static String get _base {return _devBase;}
  static String get _afterLoginBase {return _devAfterLoginBase;}

  static const  _api = '/Prod/';
  static String  env = 'dev';

  //verify user
  static EndPoint get verifyUser => _getEndPointWithPath(_api + 'otp-gen');
  static EndPoint get verifyOTP => _getEndPointWithPath(_api + 'verify-otp');
  static EndPoint get newRegister => _getEndPointWithPath(_api + 'new-registration');
  static EndPoint get userProfile => _getEndPointAfterLogin(_api + 'user-profile');
  static EndPoint get fetchServices => _getEndPointAfterDashboard(_api + 'fetch-services');
  static EndPoint get saveAddress => _getEndPointAddress(_api + 'new-add');
  static EndPoint get updateAddress => _getEndPointAddress(_api + 'update-add');
  static EndPoint get getAddress => _getEndPointAddress(_api + 'saved-add');
  static EndPoint get getAddressCheck => _getEndPointAddress(_api + 'add-check');
  static EndPoint get getOrderList => _getEndPointOrderList(_api + 'order-list');
  static EndPoint get addCart => _getEndPointCart(_api + 'sn-add-item');
  static EndPoint get cartList => _getEndPointCart(_api + 'fetch-cart');
  static EndPoint get removeCartItem => _getEndPointCart(_api + 'sn-remove-item');
  static EndPoint get priceSchedule => _getEndPriceSchedule(_api + 'sn-price-schedule');
  static EndPoint get paymentStatusUpdate => _getEndPriceSchedule(_api + 'sn-payment-status-update');
  static EndPoint get serviceOrderPlace => _getEndPriceSchedule(_api + 'sn-order-place');
  static EndPoint get shopRemoveCartItem => _getEndPointCart(_api + 'remove-item');
  static EndPoint get shopPriceSchedule => _getEndPriceSchedule(_api + 'price-schedule');
  static EndPoint get shopPaymentStatusUpdate => _getEndPriceSchedule(_api + 'payment-status-update');
  static EndPoint get shopOrderPlace => _getEndPriceSchedule(_api + 'shop-order-place');



  static EndPoint get getNearShops => _getEndShop(_api + 'shops-list-distance');
  static EndPoint get getShopMenu => _getEndShop(_api + 'shop-menu');
  static EndPoint get addShopItem => _getEndPointCart(_api + 'add-item');


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
  static EndPoint _getEndPriceSchedule(String path) {
    return EndPoint(base: _devPriceSchedule, path: path);
  }
  static EndPoint _getEndShop(String path) {
    return EndPoint(base: _devShop, path: path);
  }
}