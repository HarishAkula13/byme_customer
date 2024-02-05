

import 'package:byme_app/model/shop/shop_list.dart';
import 'package:byme_app/model/shop/shop_menu.dart';

import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../../model/shop/shop_list_deatils.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class ShopAPI{

  Future<RequestResponse<ShopList>> getShopList(Map<String,dynamic> data);
  Future<RequestResponse<ShopListDetails>> getNearShopList(Map<String,dynamic> data);
  Future<RequestResponse<ShopMenu>> getShopMenu(Map<String,dynamic> data);
  Future<RequestResponse<ShopMenu>> addShopItem(Map<String,dynamic> data);

}
class ShopService extends BaseAPIService implements ShopAPI{
  ShopService();

  @override
  Future<RequestResponse<ShopList>> getShopList(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.getShopList, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=ShopList.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }
  @override
  Future<RequestResponse<ShopListDetails>> getNearShopList(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.getNearShops, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=ShopListDetails.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<ShopMenu>> getShopMenu(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.getShopMenu, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=ShopMenu.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }



  @override
  Future<RequestResponse<ShopMenu>> addShopItem(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.addShopItem, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=ShopMenu.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<ShopMenu>> addOtherShopItem(Map<String, dynamic> data) {
    return make(RequestType.POST, EndPoints.addOtherShopItem, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=ShopMenu.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }
}