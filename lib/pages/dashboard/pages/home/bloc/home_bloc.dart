
import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef BlocProvider<HomeBloc> HomeFactory();
class HomeBloc extends BlocBase{
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isOnline =BehaviorSubject.seeded(true);
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get isOnline=> _isOnline;
  Sink<bool> get addIsOnline=> _isOnline;
  HomeBloc(this.userDataStore){
    setListeners();
  }

  void setListeners() {


  }
}