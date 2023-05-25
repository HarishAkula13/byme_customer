import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

import '../../di/app_injector.dart';
import '../../manager/user_data_store/user_data_store.dart';
import '../../model/login/login_response.dart';
import '../arch/bloc_provider.dart';

class AppBloc extends BlocBase{

  String? title;
  UserDataStore userDataStore;
  BehaviorSubject<void> _onRouteGenrate = BehaviorSubject();
  BehaviorSubject<Widget> _startPage = BehaviorSubject();

  Sink<void> get onRouteGenrate=> _onRouteGenrate;

  Stream<Widget> get startPage => _startPage;


  AppBloc(this.title,this.userDataStore){
    setUpPlatform();
    init();
  }

  void setUpPlatform() {

  }

  void init() {


  }

  void onClick() async{
       _startPage.add(AppInjector.instance.loginPage(0));

       UserInformation? user=await  userDataStore.getUser();
     if(user == null){
       _startPage.add(AppInjector.instance.loginPage(0));
     }else{
       if(user.userId == null) {
         _startPage.add(AppInjector.instance.loginPage(0));
       } else {
        // _startPage.add(AppInjector.instance.homePage());
      }
     }

  }

}
