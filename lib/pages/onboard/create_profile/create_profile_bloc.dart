
import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<CreateProfileBloc> CreateProfileFactory();
class CreateProfileBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _name = BehaviorSubject();
  BehaviorSubject<String> _email = BehaviorSubject();
  PublishSubject<void> _proceed = PublishSubject();
  Sink<String> get email => _email;
  Sink<String> get name => _name;
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get proceed => _proceed;
  CreateProfileBloc(this.loginService,this.userDataStore){

    setListeners();
  }

  void setListeners() {


  }

}