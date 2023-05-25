
import 'package:byme_app/di/i_login_page.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/arch/bloc_provider.dart';
import '../../di/app_injector.dart';
import '../../manager/user_data_store/user_data_store.dart';
import '../../repositories/login/login_api.dart';

typedef BlocProvider<LoginBloc> LoginFactory(int type);
class LoginBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  int type=0;
  BehaviorSubject<String> _email = BehaviorSubject();
  BehaviorSubject<String> _password = BehaviorSubject();
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  PublishSubject<void> _login = PublishSubject();
  PublishSubject<Map<String,dynamic>> _submitLogin=PublishSubject();
  Sink<String> get email => _email;
  Sink<String> get password => _password;
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get login => _login;

  LoginBloc(this.loginService,this.userDataStore,this.type){
    setListeners();
  }

  void setListeners() {


  }
  void navigate(){
    if(type==0)
      Get.to(AppInjector.instance.signUpPage(0));
    else if(type==1) Get.offAll(AppInjector.instance.signUpPage(type));
  }
}