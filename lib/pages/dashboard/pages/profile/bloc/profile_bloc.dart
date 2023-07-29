
import 'package:byme_app/model/signup/user_data.dart';
import 'package:byme_app/model/user/user_profile.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';



typedef BlocProvider<ProfileBloc> ProfileFactory(Function() onCallBack);
class ProfileBloc extends BlocBase{
  UserDataStore? userDataStore;
  Function() onCallBack;
  ProfileAPI? ProfileService;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<UserProfile> _userProfile =BehaviorSubject();
  Stream<UserProfile> get userProfile => _userProfile;
  Stream<bool> get isLoading=> _isLoading;
  ProfileBloc(this.ProfileService,this.userDataStore,this.onCallBack){
    setListeners();

  }

  void setListeners() async{
    _isLoading.add(true);
    UserData? user= await userDataStore!.getUser();
    ProfileService!.getUserData({"environment" : EndPoints.env,
      "user_id" : user!.userId}).then((value) {
      _isLoading.add(false);
        if(value.error==null){
          _userProfile.add(value.data!);
        }

    });


  }
  onNavigate(){
    onCallBack();
  }
}