
import 'dart:typed_data';

import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart';
import 'package:rxdart/rxdart.dart';


import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../common/utils/pyc_colors.dart';
import '../../../di/app_injector.dart';
import '../../../repositories/cart/cart_api.dart';

typedef BlocProvider<PaymentmethodBloc> PaymentmethodFactory(Map<String,dynamic> mapData);
class PaymentmethodBloc extends BlocBase {
  UserDataStore? userDataStore;
  Map<String,dynamic> mapData;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  BehaviorSubject<bool> _isSelected = BehaviorSubject.seeded(false);
  BehaviorSubject<List<UpiAppInfo>> _getList=BehaviorSubject.seeded([]);
  Stream<List<UpiAppInfo>> get getList=> _getList;
  Stream<bool> get isSelected=> _isSelected;
  Sink<bool> get addIsSelected=> _isSelected;
  PaymentmethodBloc(this.userDataStore,this.mapData){
    printLog("mapData", mapData);
    setListeners();
    getPaymentMethods();
  }

  void setListeners() {


  }

  void getPaymentMethods() async{
     var list= await PhonePePg.getUpiApps(iOSUpiApps: [
      UpiAppInfo(
        appName: "PhonePe",
        appIcon: Uint8List(0),
        iOSAppName: "PHONEPE",
        iOSAppScheme: 'ppe',
      ),
      UpiAppInfo(
        appName: "Google Pay",
        packageName: "gpay",
        appIcon: Uint8List(0),
        iOSAppName: "GPAY",
        iOSAppScheme: 'gpay',
      ),
      UpiAppInfo(
        appName: "Paytm",
        packageName: "paytmmp",
        appIcon: Uint8List(0),
        iOSAppName: "PAYTM",
        iOSAppScheme: 'paytmmp',
      ),
      UpiAppInfo(
          appName: "PhonePe Simulator",
          packageName: "ppemerchantsdkv1",
          appIcon: Uint8List(0),
          iOSAppScheme: 'ppemerchantsdkv1',
          iOSAppName: "PHONEPE"),
      UpiAppInfo(
        appName: "PhonePe Simulator",
        packageName: "ppemerchantsdkv2",
        appIcon: Uint8List(0),
        iOSAppScheme: 'ppemerchantsdkv2',
        iOSAppName: "PHONEPE",
      ),
      UpiAppInfo(
        appName: "PhonePe Simulator",
        packageName: "ppemerchantsdkv3",
        iOSAppScheme: 'ppemerchantsdkv3',
        appIcon: Uint8List(0),
        iOSAppName: "PHONEPE",
      ),
    ]);
    _getList.add(list!);

  }

  void payment(String txnId,){

    mapData.addAll({"payment_method": "UPI",
      "transaction_id": txnId,
      "payment_status": "PRC",});
    _isLoading.add(true);
    CartService().getPaymentStatus(mapData).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        GetBar(
          messageText:  const Text('Transaction Successful',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
          duration: const Duration(seconds: 3),
          backgroundColor: PYCColors.app_color,
          borderRadius: 10,
          snackPosition: SnackPosition.TOP,
          margin: const EdgeInsets.all(10),
          padding: const EdgeInsets.all(20),
          animationDuration: const Duration(milliseconds: 500),
          icon:  Icon(
            Icons.verified_outlined,
            color: Colors.white,
          ),
        ).show();
        //Get.to(AppInjector.instance.dashboardPage(0));

      }
    });
  }

}