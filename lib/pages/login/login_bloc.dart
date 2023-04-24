
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/arch/bloc_provider.dart';
import '../../manager/user_data_store/user_data_store.dart';
import '../../repositories/login/login_api.dart';

typedef BlocProvider<LoginBloc> LoginFactory();
class LoginBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<String> _email = BehaviorSubject();
  BehaviorSubject<String> _password = BehaviorSubject();
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  PublishSubject<void> _login = PublishSubject();
  PublishSubject<Map<String,dynamic>> _submitLogin=PublishSubject();
  Sink<String> get email => _email;
  Sink<String> get password => _password;
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get login => _login;

  LoginBloc(this.loginService,this.userDataStore){
    setListeners();
  }

  void setListeners() {


  }
  void navigate(){

  }
}