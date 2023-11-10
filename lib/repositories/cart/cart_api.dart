import 'package:byme_app/model/order_list/cart_list.dart';
import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class CartAPI{

  Future<RequestResponse<CartList>> getCartList(Map<String,dynamic> data);
  Future<RequestResponse<Map<String,dynamic>>> removeCart(Map<String,dynamic> data);
  Future<RequestResponse<CartList>> getPriceSchedule(Map<String,dynamic> data);
  Future<RequestResponse<CartList>> getShopPriceSchedule(Map<String,dynamic> data);

}
class CartService extends BaseAPIService implements CartAPI{
  CartService();





  @override
  Future<RequestResponse<CartList>> getCartList(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.cartList, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=CartList.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<CartList>> getPriceSchedule(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.priceSchedule, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=CartList.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<CartList>> getShopPriceSchedule(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.shopPriceSchedule, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=CartList.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }


  @override
  Future<RequestResponse<CartList>> getPaymentStatus(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.paymentStatusUpdate, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=CartList.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<Map<String,dynamic>>> removeCart(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.removeCartItem, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        // printLog("response", result.data);

        return RequestResponse(data: result.data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }
}