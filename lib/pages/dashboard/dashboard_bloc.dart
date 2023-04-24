
import 'package:rxdart/rxdart.dart';

import '../../app/arch/bloc_provider.dart';
import '../../manager/user_data_store/user_data_store.dart';
import '../../repositories/login/login_api.dart';

typedef BlocProvider<DashboardBloc> DashboardFactory();
class DashboardBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<int> _selectedPos= BehaviorSubject.seeded(0);

  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectedPos => _selectedPos;
  Sink<int> get addSelectedPos => _selectedPos;
  DashboardBloc(this.loginService,this.userDataStore){
    setListeners();
  }

  void setListeners() {


  }
}