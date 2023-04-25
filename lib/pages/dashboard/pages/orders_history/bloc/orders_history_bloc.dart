
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef BlocProvider<OrdersHistoryBloc> OrdersHistoryFactory(Function(int type,int pos) onCallBack);
class OrdersHistoryBloc extends BlocBase{
  UserDataStore? userDataStore;
  Function(int type,int pos) onCallBack;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<Tuple2<int,bool>> _selectPos =BehaviorSubject();
  BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  Stream<Tuple2<int,bool>> get selectPos=> _selectPos;
  Sink<Tuple2<int,bool>> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  OrdersHistoryBloc(this.userDataStore,this.onCallBack){
    setListeners();
  }

  void setListeners() {


  }
  onNavigate(int type,int pos){

    onCallBack(type,pos);

  }
}