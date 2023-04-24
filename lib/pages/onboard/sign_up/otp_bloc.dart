import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<OTPBloc> OTPFactory();
class OTPBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _text =BehaviorSubject<String>();
  Sink<void> get text => _text;

  PublishSubject<void> _sendOTP = PublishSubject();
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get sendOTP => _sendOTP;
  OTPBloc(this.loginService,this.userDataStore){

    setListeners();
  }

  void setListeners() {


  }
  void onKeyboardTap(String value) {

  }
}