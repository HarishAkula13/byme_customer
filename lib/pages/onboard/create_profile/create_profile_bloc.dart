
import 'dart:io';

import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../common/utilities/logger.dart';
import '../../../common/validators/validators.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../model/signup/user_data.dart';
import '../../../model/signup/verify_user_response.dart';
import '../../../repositories/end_point/end_point.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<CreateProfileBloc> CreateProfileFactory(Map<String,dynamic>? verifyData);
class CreateProfileBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  Map<String,dynamic>? verifyData;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<bool> _isShow =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _name = BehaviorSubject.seeded('');
  BehaviorSubject<String> _email = BehaviorSubject.seeded('');
  PublishSubject<void> _proceed = PublishSubject();
  BehaviorSubject<String?> emailValidationData = BehaviorSubject<String>();
  BehaviorSubject<String?> _nameValidationData = BehaviorSubject<String>();
  BehaviorSubject<bool>  _valid = BehaviorSubject.seeded(false);
  Stream<String?> get emailValidation => emailValidationData;
  Stream<String?> get nameValidationData => _nameValidationData;
  Sink<String> get email => _email;
  Sink<String> get name => _name;
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get isShow=> _isShow;
  Sink<bool> get addIsShow=> _isShow;
  Sink<void> get proceed => _proceed;

  CreateProfileBloc(this.loginService,this.userDataStore,this.verifyData){

    setListeners();
  }

  void setListeners() {
    _email
        .map((e) => e.toLowerCase())
        .map(FormValidator().validateEmail)
        .listen((event) {
      if(event!=null)
        emailValidationData.add(event);
      else emailValidationData.add("");
    },).addTo(disposeBag);

    _name
        .map((e) => e.toLowerCase())
        .map(FormValidator().validateName)
        .listen((event) {
      if(event!=null)
        _nameValidationData.add(event);
      else _nameValidationData.add("");
    },).addTo(disposeBag);


    CombineLatestStream.combine2(_nameValidationData, emailValidationData,
            (String? a, String? b) {
          return a!.isEmpty && b!.isEmpty;})
        .listen(_valid.add)
        .addTo(disposeBag);

    _proceed.withLatestFrom(_valid, (_, bool v) => v)
        .where((v) {

      return v;})
        .withLatestFrom2(_name, _email,
            (t,String a, String b)  {
          return {
            "full_name":a,
            'email_id':b,


          };
        })
        .listen(navigateData)
        .addTo(disposeBag);

  }

  void navigateData(Map<String,dynamic> data)  {
    verifyData?.addAll(data);
    printLog('data', verifyData);
    _isLoading.add(true);

   loginService!.newRegister(verifyData!).then((value) async {
     _isLoading.add(false);
     if(value.data!.key!=null){
       if(value.data!.key!="failed"){

         await userDataStore!.insert(UserData(fullName: verifyData!['full_name'],mobileNumber: verifyData!['phone'], userId: value.data!.userId,token:value.data!.token));
         Get.to(AppInjector.instance.addressList(0));
       }
     }else{
       Get.snackbar(
         'Invalid Response',
         "",
         colorText: Colors.white,
         backgroundColor: Colors.red,
         icon: const Icon(Icons.notifications_active_outlined,color: Colors.white,),
       );
     }


   });
   
   
  }

}