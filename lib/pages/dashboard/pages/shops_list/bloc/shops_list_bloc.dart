
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/address_data/address_data.dart';
import '../../../../../model/dashboard/menu.dart';


typedef BlocProvider<ShopsListBloc> ShopsListFactory(Menu? menu, AddressData? addressData);
class ShopsListBloc extends BlocBase{
  UserDataStore? userDataStore;
  Menu? menu;
  AddressData? addressData;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<int> _selectPos =BehaviorSubject.seeded(0);
  BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectPos=> _selectPos;
  Sink<int> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  ShopsListBloc(this.userDataStore,this.menu,this.addressData){
    setListeners();
  }

  void setListeners() {


  }
}