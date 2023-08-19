
import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/model/order_list/orders_list.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/signup/user_data.dart';
import '../../../../../repositories/end_point/end_point.dart';
import '../../../../../repositories/profile/Profile_api.dart';


typedef BlocProvider<OrdersHistoryBloc> OrdersHistoryFactory(Function(int type,int pos) onCallBack);
class OrdersHistoryBloc extends BlocBase{
  UserDataStore? userDataStore;
  Function(int type,int pos) onCallBack;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<Tuple2<int,bool>> _selectPos =BehaviorSubject();
  BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  BehaviorSubject<List<OrdersList>> _ordersList =BehaviorSubject();
  Stream<List<OrdersList>> get ordersList => _ordersList;
  Stream<bool> get isLoading=> _isLoading;
  Stream<Tuple2<int,bool>> get selectPos=> _selectPos;
  Sink<Tuple2<int,bool>> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  OrdersHistoryBloc(this.userDataStore,this.onCallBack){
    setListeners();
  }

  void setListeners() async {
    UserData? user= await userDataStore!.getUser();
    _isLoading.add(true);
    ProfileService().getOrdersList({
      "environment" : EndPoints.env,
      "user_id" : user!.userId}).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        _ordersList.add(value.data!.orderList!);
        printLog("title", value.data!.orderList!);
      }

    });

  }
  onNavigate(int type,int pos){

    onCallBack(type,pos);

  }
}