import 'package:byme_app/model/user/user_profile.dart';

import '../../../model/base_response/request_response.dart';
import '../../common/utilities/logger.dart';
import '../../model/signup/verify_user_response.dart';
import '../base/base_api_service.dart';
import '../end_point/end_point.dart';

abstract class DashboardAPI{
  Future<RequestResponse<Map<String,dynamic>>> getService(Map<String,dynamic> data);
  Future<RequestResponse<Map<String,dynamic>>> addCart(Map<String,dynamic> data);
}
class DashboardService extends BaseAPIService implements DashboardAPI{
  DashboardService();

  @override
  Future<RequestResponse<Map<String,dynamic>>> getService(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.fetchServices, body: data,contentType: ContentType.json)
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


  @override
  Future<RequestResponse<Map<String,dynamic>>> addCart(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.addCart, body: data,contentType: ContentType.json)
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

  @override
  Future<RequestResponse<Map<String,dynamic>>> addOtherCart(Map<String,dynamic> data) {
    return make(RequestType.POST, EndPoints.addOtherCart, body: data,contentType: ContentType.json)
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