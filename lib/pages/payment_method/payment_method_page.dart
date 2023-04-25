import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/payment_method_bloc.dart';

class PaymentmethodPage extends StatefulWidget{

  PaymentmethodPageState createState()=> PaymentmethodPageState();
}
class PaymentmethodPageState extends State<PaymentmethodPage>{
  PaymentmethodBloc? _bloc;
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
            )
          ],
        ),
      ),

    );
  }
  }
