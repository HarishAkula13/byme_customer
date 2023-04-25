
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef BlocProvider<ProfileBloc> ProfileFactory(Function() onCallBack);
class ProfileBloc extends BlocBase{
  UserDataStore? userDataStore;
  Function() onCallBack;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  ProfileBloc(this.userDataStore,this.onCallBack){
    setListeners();
  }

  void setListeners() {


  }
  onNavigate(){
    onCallBack();
  }
}