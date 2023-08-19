import 'package:byme_app/model/user/user_profile.dart';

import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../../model/address_data/address_data.dart';
import '../../model/signup/verify_user_response.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class ProfileAPI{
  Future<RequestResponse<UserProfile>> getUserData(Map<String,dynamic> data);
  Future<RequestResponse<UserProfile>> saveAddress(Map<String,dynamic> data);
  Future<RequestResponse<UserProfile>> getAddress(Map<String,dynamic> data);
  Future<RequestResponse<AddressData>> getAddressCheck(Map<String,dynamic> data);

}
class ProfileService extends BaseAPIService implements ProfileAPI{
  ProfileService();

  @override
  Future<RequestResponse<UserProfile>> getUserData(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.userProfile, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=UserProfile.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<UserProfile>> saveAddress(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.saveAddress, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=UserProfile.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }
  @override
  Future<RequestResponse<UserProfile>> getAddress(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.getAddress, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=UserProfile.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

  @override
  Future<RequestResponse<AddressData>> getAddressCheck(Map<String, dynamic> data) {
    // TODO: implement getAddressCheck
    return make(RequestType.POST, EndPoints.getAddressCheck, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=AddressData.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });  }
}