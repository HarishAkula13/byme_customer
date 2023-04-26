import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import '../../di/app_injector.dart';
import 'bloc/payment_method_bloc.dart';

class PaymentmethodPage extends StatefulWidget{

  PaymentmethodPageState createState()=> PaymentmethodPageState();
}
class PaymentmethodPageState extends State<PaymentmethodPage>{
  PaymentmethodBloc? _bloc;

  bool toggle = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of(context);
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
      body: Container(
        child: Column(
          children: [
            Container(
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
                 ItemLabelText(text: 'Set Bank Account',style: TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                ],
              ),
            ),
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
            ),
            Container(
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
            ),
            Container(
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

          ],
        ),
      ),

    );
  }
  }
