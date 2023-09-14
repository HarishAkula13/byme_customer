import 'dart:convert';
import 'dart:io';
import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:phone_pe_pg/phone_pe_pg.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import '../../common/fonts/fonts.dart';
import '../../common/utils/pyc_colors.dart';
import '../../di/app_injector.dart';
import 'bloc/payment_method_bloc.dart';

class PaymentmethodPage extends StatefulWidget{

  PaymentmethodPageState createState()=> PaymentmethodPageState();
}
class PaymentmethodPageState extends State<PaymentmethodPage>{
  PaymentmethodBloc? _bloc;
  PhonePePg pePg = PhonePePg(
    isUAT: true,
    saltKey: "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399",
    saltIndex: "1",
  );
  PaymentRequest _paymentRequest({String? merchantCallBackScheme}) {
    PaymentRequest paymentRequest = PaymentRequest(
      amount: _bloc!.mapData['final_amount']*100,
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

  bool toggle = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of(context);
    PhonePePg pePg = PhonePePg(
      isUAT: true,
      saltKey: "099eb0cd-02cf-4e2a-8aca-3e6c6aff0399",
      saltIndex: "1",
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title:ItemLabelText(text: 'Choose a payment method',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w700),),
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
      body: LoaderContainer(
        stream: _bloc!.isLoading,
        child: Container(
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                /*GestureDetector(
                  onTap: (){

                    //Get.to(AppInjector.instance.upisList);
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor('#69706D26').withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 2),
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset('assets/images/upi.png'),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)
                      ],
                    ),
                  ),
                ),*/
            StreamBuilder<List<UpiAppInfo>>(
              initialData: [],
              stream: _bloc!.getList,
              builder: (b,sp){
                return ListView.builder(
                  shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: sp.data!.length,
                    itemBuilder: (b,i){
                     return GestureDetector(
                       onTap: (){
                         pePg.startUpiTransaction(
                             paymentRequest: upipaymentRequest(sp.data![i]))
                             .then((response) {

                           if (response.status == UpiPaymentStatus.success) {
                                  _bloc!.payment(response.txnRef ?? "00");

                           } else if (response.status == UpiPaymentStatus.pending) {
                             GetBar(
                               messageText:  const Text('Transaction Pending',style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600),),
                               duration: const Duration(seconds: 3),
                               backgroundColor:Colors.amberAccent,
                               borderRadius: 10,
                               snackPosition: SnackPosition.TOP,
                               margin: const EdgeInsets.all(10),
                               padding: const EdgeInsets.all(20),
                               animationDuration: const Duration(milliseconds: 500),
                               icon:  Icon(
                                 Icons.pending_outlined,
                                 color: Colors.black,
                               ),
                             ).show();


                           } else {
                             GetBar(
                               messageText:  const Text('Transaction Failed',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                               duration: const Duration(seconds: 3),
                               backgroundColor: Colors.red,
                               borderRadius: 10,
                               snackPosition: SnackPosition.TOP,
                               margin: const EdgeInsets.all(10),
                               padding: const EdgeInsets.all(20),
                               animationDuration: const Duration(milliseconds: 500),
                               icon:  Icon(
                                 Icons.error_outline,
                                 color: Colors.white,
                               ),
                             ).show();

                           }
                         }).catchError((e) {
                           printLog("Exception", e);

                           GetBar(
                             messageText:  const Text('Transaction Failed',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                             duration: const Duration(seconds: 3),
                             backgroundColor: Colors.red,
                             borderRadius: 10,
                             snackPosition: SnackPosition.TOP,
                             margin: const EdgeInsets.all(10),
                             padding: const EdgeInsets.all(20),
                             animationDuration: const Duration(milliseconds: 500),
                             icon:  Icon(
                               Icons.error_outline,
                               color: Colors.white,
                             ),
                           ).show();

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
                               sp.data![i].appIcon,
                               errorBuilder: (context, error, stackTrace) {
                                 return const Icon(Icons.error);
                               },
                             ),
                             SizedBox(width: 10,),
                             ItemLabelText(text: sp.data![i].appName,style: const TextStyle(color: Colors.black,fontSize: 16,fontFamily: Fonts.regular),),
                             const Spacer(),
                             const Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)
                           ],
                         ),
                       ),
                     );
                    });
              },
            ),
                /*Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#69706D26').withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemLabelText(text: 'Saved Debit Cards',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                          ItemLabelText(text: 'New Card',style: TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),


                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/visa.png',height: 23,width: 36,),
                          SizedBox(width: 15,),
                          ItemLabelText(text: '4925 **** **** 4890',style: TextStyle(letterSpacing: 2,fontSize: 14,color: HexColor('#444444'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                        Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)
                        ],
                      ),
                      SizedBox(height: 10,),
                      Divider(color: HexColor('#E9E9E9'),thickness: 1,),
                      SizedBox(height: 10,),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/mastercard.png'),
                          SizedBox(width: 15,),
                          ItemLabelText(text: '5346 **** **** 9658',style: TextStyle(letterSpacing: 2,fontSize: 14,color: HexColor('#444444'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 20,)

                        ],
                      ),
                    ],
                  ),
                ),*/
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => pePg.startPayPageTransaction(
                              onPaymentComplete:
                                  (paymentResponse, paymentError) {
                                Navigator.pop(context);

                                if (paymentResponse != null &&
                                    paymentResponse.code ==
                                        PaymentStatus.success) {
                                  _bloc!.payment(paymentResponse.data!.merchantTransactionId!);


                                } else {
                                  GetBar(
                                    messageText:  const Text('Transaction Failed',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w600),),
                                    duration: const Duration(seconds: 3),
                                    backgroundColor: Colors.red,
                                    borderRadius: 10,
                                    snackPosition: SnackPosition.TOP,
                                    margin: const EdgeInsets.all(10),
                                    padding: const EdgeInsets.all(20),
                                    animationDuration: const Duration(milliseconds: 500),
                                    icon:  Icon(
                                      Icons.error_outline,
                                      color: Colors.white,
                                    ),
                                  ).show();

                                }
                              },
                              paymentRequest: paypageRequestModel(),
                            )));
                  },
                  child: Container(
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: HexColor('#69706D26').withOpacity(0.1),
                            spreadRadius: 2,
                            blurRadius: 7,
                            offset: Offset(0, 2),
                          )
                        ]
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/netbanking.svg',height: 24,width: 24,),
                        SizedBox(width: 20,),
                        ItemLabelText(text: 'Net Banking',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                        Spacer(),
                        Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)

                      ],
                    ),
                  ),
                ),
                /*Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#69706D26').withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ]
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemLabelText(text: 'Saved Credit Cards',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                          ItemLabelText(text: 'New Card',style: TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                        ],
                      ),
                      SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Image.asset('assets/images/visa.png',height: 23,width: 36,),
                          SizedBox(width: 15,),
                          ItemLabelText(text: '4925 **** **** 4890',style: TextStyle(letterSpacing: 2,fontSize: 14,color: HexColor('#444444'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)
                        ],
                      ),
                    ],
                  ),
                ),*/
                Container(
                  margin: EdgeInsets.only(left: 20,right: 20),
                  padding: EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(
                          color: HexColor('#69706D26').withOpacity(0.1),
                          spreadRadius: 2,
                          blurRadius: 7,
                          offset: Offset(0, 2),
                        )
                      ]
                  ),
                  child:  InkWell(
                    onTap: (){
                      _bloc!.addIsSelected.add(true);
                      Future.delayed(Duration(seconds: 1)).then((value) {
                        Get.to(AppInjector.instance.trackOrder)!.then((value){
                          Navigator.pop(context);
                        });
                      });

                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        StreamBuilder<bool>(
                          initialData: false,
                          stream: _bloc!.isSelected,
                          builder: (context, s) {
                            return SvgPicture.asset(s.data==true?'assets/images/radio.svg':'assets/images/radio_outline.svg');
                          }
                        ),
                        SizedBox(width: 15,),
                        SvgPicture.asset('assets/images/cash.svg'),
                        SizedBox(width: 15,),
                        ItemLabelText(text: 'Cash On Delivery',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                      ],
                    ),
                  )
                ),
               /* GestureDetector(
                  onTap:(){
                                },
                  child: Container(
                      margin: EdgeInsets.only(left: 20,right: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          boxShadow: [
                            BoxShadow(
                              color: HexColor('#69706D26').withOpacity(0.1),
                              spreadRadius: 2,
                              blurRadius: 7,
                              offset: Offset(0, 2),
                            )
                          ]
                      ),
                      child:  Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ItemLabelText(text: 'Others',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios,color: Colors.grey,size: 18,)

                        ],
                      )
                  ),
                ),*/

              ],
            ),
          ),
        ),
      ),

    );
  }
  }
