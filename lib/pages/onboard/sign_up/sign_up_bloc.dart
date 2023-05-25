import 'package:byme_app/di/i_login_page.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<SignUpBloc> SignUpFactory(int type);
class SignUpBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  int type;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _text =BehaviorSubject<String>();
  Sink<void> get text => _text;

  PublishSubject<void> _sendOTP = PublishSubject();
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get sendOTP => _sendOTP;
  SignUpBloc(this.loginService,this.userDataStore,this.type){

    setListeners();
  }
  void navigate() {
    Get.to(AppInjector.instance.otpPage(type));
  }
  void setListeners() {


  }
  void onKeyboardTap(String value) {

  }
}