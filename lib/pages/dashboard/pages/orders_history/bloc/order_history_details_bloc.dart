
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef BlocProvider<OrdersHistoryDetailsBloc> OrdersHistoryDetailsFactory(int pos,Function(int type) onCallBack);
class OrdersHistoryDetailsBloc extends BlocBase{
  int? pos;
  Function(int type) onCallBack;
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<int> _selectPos =BehaviorSubject.seeded(0);
  BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectPos=> _selectPos;
  Sink<int> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  OrdersHistoryDetailsBloc(this.pos,this.userDataStore,this.onCallBack){
    setListeners();
    _selectPos.add(pos!);
  }

  void setListeners() {


  }
  void onNavigate(){
    onCallBack(0);
  }
}