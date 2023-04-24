import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../../model/login/login_response.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class LoginAPI{
  Future<RequestResponse<LoginResponse>> login(Map<String,dynamic> data);
}
class LoginService extends BaseAPIService implements LoginAPI{
  LoginService();
  @override
  Future<RequestResponse<LoginResponse>> login(Map<String,dynamic> data) {
    printLog("login",data);
    return make(RequestType.POST, EndPoints.login, body: data,contentType: ContentType.json)
        .then((result) {
      if (result.data != null) {
        printLog("response", result.data);
        var data=LoginResponse.fromJson(result.data);
        return RequestResponse(data: data);
      } else {
        printLog("response error", result.error!.error);
        return RequestResponse(error: result.error);
      }
    });
  }


}