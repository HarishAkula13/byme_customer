import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../../model/signup/verify_user_response.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class LoginAPI{
  Future<RequestResponse<VerifyUserResponse>> verifyUser(Map<String,dynamic> data);
  Future<RequestResponse<VerifyUserResponse>> verifyOTP(Map<String,dynamic> data);
  Future<RequestResponse<VerifyUserResponse>> newRegister(Map<String,dynamic> data);

}
class LoginService extends BaseAPIService implements LoginAPI{
  LoginService();
  @override
  Future<RequestResponse<VerifyUserResponse>> verifyUser(Map<String,dynamic> data) {
    printLog("login",data);
    return make(RequestType.POST, EndPoints.verifyUser, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=VerifyUserResponse.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }


  @override
  Future<RequestResponse<VerifyUserResponse>> verifyOTP(Map<String,dynamic> data) {
    printLog("login",data);
    return make(RequestType.POST, EndPoints.verifyOTP, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=VerifyUserResponse.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }


  @override
  Future<RequestResponse<VerifyUserResponse>> newRegister(Map<String,dynamic> data) {
    printLog("login",data);
    return make(RequestType.POST, EndPoints.newRegister, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=VerifyUserResponse.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }

}