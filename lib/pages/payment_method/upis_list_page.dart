import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';

import 'package:byme_app/common/fonts/fonts.dart';
import 'package:byme_app/common/label/item_label_text.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart';

import '../../common/utilities/fonts.dart';
class UPISListPage extends StatefulWidget {

  @override
  UPISListState createState() => UPISListState();
}

class UPISListState extends State<UPISListPage> {
  @override
  void initState() {
    super.initState();
  }

  PhonePePg pePg = PhonePePg(
    isUAT: true,
    saltKey: "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399",
    saltIndex: "1",
  );

  PaymentRequest _paymentRequest({String? merchantCallBackScheme}) {

    PaymentRequest paymentRequest = PaymentRequest(
      amount: 35,
      callbackUrl: "https://webhook.site/845cb8cc-5d74-4494-95ea-3003c9c518ab",
      deviceContext: DeviceContext.getDefaultDeviceContext(
          merchantCallBackScheme: merchantCallBackScheme),
      merchantId: "PGTESTPAYUAT",
      merchantTransactionId: DateTime.now().millisecondsSinceEpoch.toString(),
      merchantUserId: "1234567890",
      mobileNumber: "9440702795",
    );
    return paymentRequest;
  }

  PaymentRequest upipaymentRequest(UpiAppInfo e,
      {String? merchantCallBackScheme}) =>
      _paymentRequest(merchantCallBackScheme: merchantCallBackScheme).copyWith(
          paymentInstrument: UpiIntentPaymentInstrument(
            targetApp: Platform.isAndroid ? e.packageName! : e.iOSAppName!,
          ));

  PaymentRequest paypageRequestModel({String? merchantCallBackScheme}) =>
      _paymentRequest(merchantCallBackScheme: merchantCallBackScheme).copyWith(
          redirectUrl: "http://127.0.0.1/test/view",
          redirectMode: 'GET',
          paymentInstrument: PayPagePaymentInstrument());

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
            title:ItemLabelText(text: 'Choose a UPI method',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w700),),
            leading:InkWell(
              onTap: (){
                Navigator.pop(context);
              },
              child: Padding(
                padding: const EdgeInsets.only(left: 14.0),
                child: Row(
                  children: [
                    Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,size: 16,),
                  ],
                ),
              ),
            ),
          ),
          body: FutureBuilder<List<UpiAppInfo>?>(
            future: PhonePePg.getUpiApps(iOSUpiApps: [
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
            ]),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return ListView(children: [
                  ...snapshot.data!
                      .map(
                        (e) => GestureDetector(
                          onTap: (){
                            pePg
                                .startUpiTransaction(
                                paymentRequest: upipaymentRequest(e))
                                .then((response) {
                              if (response.status == UpiPaymentStatus.success) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content:
                                        Text("Transaction Successful")));
                              } else if (response.status ==
                                  UpiPaymentStatus.pending) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Transaction Pending")));
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("Transaction Failed")));
                              }
                            }).catchError((e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text("Transaction Failed")));
                            });
                          },
                          child: Container(
                            alignment: Alignment.centerLeft,
                            padding: EdgeInsets.all(10),
                            margin: const EdgeInsets.only(left: 20,right: 20,top: 5,bottom: 5),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.all(Radius.circular(10)),
                                boxShadow: [
                                  BoxShadow(
                                    color: HexColor('#69706D26').withOpacity(0.1),
                                    spreadRadius: 2,
                                    blurRadius: 7,
                                    offset: const Offset(0, 2),
                                  )
                                ]
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Image.memory(
                                  width: 35,
                                  height: 35,
                                  e.appIcon,
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Icon(Icons.error);
                                  },
                                ),
                                SizedBox(width: 10,),
                                ItemLabelText(text: e.appName,style: const TextStyle(color: Colors.black,fontSize: 16,fontFamily: Fonts.regular),),
                                const Spacer(),
                                const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)
                              ],
                            ),
                          ),
                        )
                  ).toList(),
                ]);
              }
              return const Center(
                child: CircularProgressIndicator(),
              );
            },
          )),
    );
  }
}
