
import 'package:rxdart/rxdart.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../app/arch/bloc_provider.dart';


typedef BlocProvider<OrderDetailsBloc> OrdersDetailsFactory(int type);
class OrderDetailsBloc extends BlocBase{
  UserDataStore? userDataStore;
  int? type;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isReadService =BehaviorSubject.seeded(true);
  BehaviorSubject<bool> _isReadPilot =BehaviorSubject.seeded(true);
  BehaviorSubject<String> _service = BehaviorSubject.seeded('Carpentry');
  BehaviorSubject<String> _pilot = BehaviorSubject.seeded('Pilot ');
  BehaviorSubject<String> _amount = BehaviorSubject();
  BehaviorSubject<int> _dialogType =BehaviorSubject.seeded(0);
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get isReadService=> _isReadService;
  Sink<bool> get addReadService=> _isReadService;
  Stream<bool> get isReadPilot => _isReadPilot;
  Sink<bool> get addReadPilot => _isReadPilot;
  Stream<int> get dialogType => _dialogType;
  Sink<int> get addDialogType => _dialogType;

  Sink<String> get service => _service;
  Sink<String> get pilot => _pilot;
  Sink<String> get amount => _amount;
  OrderDetailsBloc(this.userDataStore,this.type){
    _dialogType.add(type!);
    setListeners();
  }

  void setListeners() {


  }
}