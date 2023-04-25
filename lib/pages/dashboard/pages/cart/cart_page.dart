

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/button/byme_button.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/cart_bloc.dart';

class CartPage extends StatefulWidget{

  CartPageState createState()=> CartPageState();
}
class CartPageState extends State<CartPage>{
  CartBloc? _bloc;
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
        leadingWidth: 205,
        leading:InkWell(
          onTap: (){
        Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Row(
              children: [
                Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,size: 16,),
                SizedBox(width: 10,),
                ItemLabelText(text: 'Cart',style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w700),)
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: 2,
          shrinkWrap: true,
          physics: ScrollPhysics(),
          itemBuilder: (b,i){
            return Container(
                height: 90,
                margin: EdgeInsets.only(left: 20,right: 20,top: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: HexColor("#F5F5F5"),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                ),
                child: Row(
                  children: [
                    SvgPicture.asset('assets/images/Construction.svg',height: 50,width: 50,),
                    SizedBox(width: 5,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: 'Construction Works',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w500),),
                        SizedBox(height: 5,),
                        Container(
                            height: 20,
                            alignment: Alignment.center,
                            width: 100,
                            decoration: BoxDecoration(
                                color: HexColor("#E9E9E9"),
                                borderRadius: BorderRadius.all(Radius.circular(10))
                            ),
                            child: ItemLabelText(text: 'Plumber - 1 No',style: TextStyle(fontSize: 11,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w400),)),


                      ],
                    ),
                    SizedBox(width: 30,),
                    RichText(
                        text: const TextSpan( children: [
                          TextSpan(
                              text: "₹",
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                          TextSpan(
                              text: '35',
                              style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                        ])),
                    SizedBox(width: 40,),
                    IconButton(onPressed: (){}, icon: Icon(Icons.close,color: HexColor("#858E8B"),))
                  ],
                )
            );
          }),

      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: Offset(0, -6),
                )
              ]
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemLabelText(text: 'Total Amount: ',style: TextStyle(fontSize: 18,color: HexColor('#858E8B'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                    RichText(
                        text: const TextSpan( children: [
                          TextSpan(
                              text: "₹",
                              style: TextStyle(
                                  color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                          TextSpan(
                              text: '70',
                              style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                        ])),
                  ],
                ),
              ),
              SizedBox(height: 20,),
              customButton(() {
                Get.to(AppInjector.instance.paymentMethodPage);
              }, ItemLabelText(text:'Pay',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),

            ],
          ),
        ),
      ),

    );
  }


}