import 'package:byme_app/di/i_login_page.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<OTPBloc> OTPFactory(int type);
class OTPBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  int type;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _text =BehaviorSubject<String>();
  Sink<void> get text => _text;

  PublishSubject<void> _sendOTP = PublishSubject();
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get sendOTP => _sendOTP;
  OTPBloc(this.loginService,this.userDataStore,this.type){

    setListeners();
  }

  void setListeners() {


  }
  void navigate() {
    if (type == 0)
      Get.to(AppInjector.instance.dashboardPage(0));
    else
      Get.to(AppInjector.instance.createProfilePage);

  }
  void onKeyboardTap(String value) {

  }
}