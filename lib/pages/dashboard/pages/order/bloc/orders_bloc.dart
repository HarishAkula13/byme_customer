
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef BlocProvider<OrdersBloc> OrdersFactory();
class OrdersBloc extends BlocBase{
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<int> _selectPos =BehaviorSubject.seeded(0);
  BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectPos=> _selectPos;
  Sink<int> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  OrdersBloc(this.userDataStore){
    setListeners();
  }

  void setListeners() {


  }
}