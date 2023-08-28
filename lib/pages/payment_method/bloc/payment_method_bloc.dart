
import 'dart:typed_data';

import 'package:phone_pe_pg/phone_pe_pg.dart';
import 'package:rxdart/rxdart.dart';


import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';

typedef BlocProvider<PaymentmethodBloc> PaymentmethodFactory();
class PaymentmethodBloc extends BlocBase {
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  BehaviorSubject<bool> _isSelected = BehaviorSubject.seeded(false);
  BehaviorSubject<List<UpiAppInfo>> _getList=BehaviorSubject.seeded([]);
  Stream<List<UpiAppInfo>> get getList=> _getList;
  Stream<bool> get isSelected=> _isSelected;
  Sink<bool> get addIsSelected=> _isSelected;
  PaymentmethodBloc(this.userDataStore){
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

}