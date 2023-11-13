
import 'package:byme_app/di/i_login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../repositories/end_point/end_point.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<SignUpBloc> SignUpFactory(int type);
class SignUpBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  int type;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _text =BehaviorSubject<String>();
  BehaviorSubject<String> _validationMsg =BehaviorSubject<String>();
  Sink<String> get addValidationMsg => _validationMsg;
  Stream<String> get validationMsg => _validationMsg;
  Sink<void> get text => _text;

  PublishSubject<void> _sendOTP = PublishSubject();
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get sendOTP => _sendOTP;
  SignUpBloc(this.loginService,this.userDataStore,this.type){

    setListeners();
  }

  void setListeners() {


  }
  void onKeyboardTap(String value) {

  }

  Future<void> navigate(String? number) async {
    _isLoading.add(true);
    loginService!.verifyUser({
      "environment": EndPoints.env,
      "phone": number,
      "device_id":await FirebaseMessaging.instance.getToken()
    }).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        value.data!.mobileNumber=number;
        Get.to(AppInjector.instance.otpPage(type,value.data!));
      }


    });


  }
}