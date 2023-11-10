import 'dart:io';

import 'package:byme_app/common/utils/pyc_colors.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:platform_device_id/platform_device_id.dart';
import 'package:rxdart/rxdart.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../common/utilities/logger.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../model/signup/user_data.dart';
import '../../../model/signup/verify_user_response.dart';
import '../../../repositories/end_point/end_point.dart';
import '../../../repositories/login/login_api.dart';


typedef BlocProvider<OTPBloc> OTPFactory(int type,VerifyUserResponse? verifyData);
class OTPBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  int type;
  VerifyUserResponse? verifyData;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<String> _text =BehaviorSubject<String>();
  Sink<void> get text => _text;

  PublishSubject<void> _sendOTP = PublishSubject();
  Stream<bool> get isLoading=> _isLoading;
  Sink<void> get sendOTP => _sendOTP;

  OTPBloc(this.loginService,this.userDataStore,this.type,this.verifyData){

    setListeners();
  }

  void setListeners() {


  }
  void onKeyboardTap(String value) {

  }

  Future<void> navigate(String? otp) async {
    FirebaseMessaging.instance.getToken().then((value) => printLog("FCM TOKEN", value));



    if(otp==verifyData!.otp.toString()){
      _isLoading.add(true);
      loginService!.verifyOTP({
        "environment": EndPoints.env,
        "phone": verifyData!.mobileNumber,
        "otp": otp,
        "device_type": Platform.isIOS?'ios':"android",
        "device_id": await FirebaseMessaging.instance.getToken()
      }).then((value) async {
        _isLoading.add(false);
        if(value.data!.key=='registered') {
          await userDataStore!.insert(UserData(fullName: value.data!.fullName,mobileNumber: value.data!.mobileNumber,userId: value.data!.userId,token: value.data!.token));
          Get.to(AppInjector.instance.addressList);
        }else {
          Get.to(AppInjector.instance.createProfilePage({
          "environment": EndPoints.env,
          "phone": verifyData!.mobileNumber,
          "otp": otp,
          "device_type": Platform.isIOS?'ios':"android",
          "device_id": await FirebaseMessaging.instance.getToken()
        }));
        }
      });
      }else{
      Get.snackbar(
        'Invalid OTP',
        "Enter valid OTP",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        icon: const Icon(Icons.notifications_active_outlined,color: Colors.white,),
      );
    }


/*    _isLoading.add(true);
    // printLog("title", '${otp} \n  ${verifyData!.otp.toString()}');
  */

  }
}