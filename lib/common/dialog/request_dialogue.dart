


import 'package:byme_app/common/button/byme_button.dart';
import 'package:byme_app/common/button/byme_outline_button.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../di/app_injector.dart';
import '../label/item_label_text.dart';
import '../utilities/byme_colors.dart';
import '../utilities/fonts.dart';

void requestDialogue ({String? title,String? des,String? amount,String? subTitle,dynamic bloc}){
  showDialog(
      barrierColor: Color(0x99070707),
      barrierDismissible: false,
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          titlePadding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25)),
          ),

          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ItemLabelText(text:title,style: TextStyle(
                  color: Colors.black,fontFamily: Inter.bold,fontSize: 20,fontWeight: FontWeight.w600
              ),),
              SizedBox(height: 10,),
              (subTitle!=null)?RichText(
                  text: TextSpan(style: TextStyle(fontSize: 13), children: [
                    TextSpan(
                        text: "ID: ",
                        style: TextStyle(
                            color: Colors.grey, fontFamily: Inter.regular)),
                    TextSpan(text: subTitle,style: TextStyle(
                        color: ByMeColors.text_black_color, fontFamily: Inter.regular)),

                  ])):SizedBox(),
              SizedBox(height: 15,),
              Container(color: Colors.grey,height: 1,),
              Container(
                padding: EdgeInsets.all(10),
                child:Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      child: ItemLabelText(text:des,style: TextStyle(color: Colors.black,fontFamily: Inter.regular,fontSize: 14,fontWeight: FontWeight.w400
                      ),),
                    ),
                    Container(
                      height: 85,
                      width: 75,
                      margin: EdgeInsets.only(left: 20),
                      decoration: BoxDecoration(
                          color: HexColor("#F5F5F5"),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: Column(
                        children: [
                          Container(
                            height:20,
                            width: 85,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: HexColor("#E6E6E6"),
                                borderRadius: BorderRadius.only(topLeft: Radius.circular(10),topRight: Radius.circular(10))
                            ),
                            child:  ItemLabelText(text:'Total',style: TextStyle(
                                color: HexColor("#828785"),fontFamily: Inter.medium,fontSize: 11,fontWeight: FontWeight.w500
                            ),),
                          ),
                          SizedBox(height: 20,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ItemLabelText(text: '₹ ',style: TextStyle(fontSize: 11,color: HexColor('#151716'),fontFamily: Inter.bold,fontWeight: FontWeight.w400),),
                              ItemLabelText(text: amount,style: TextStyle(fontSize: 22,color: HexColor('#151716'),fontFamily: Inter.bold,fontWeight: FontWeight.w500),),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(height: 10,),
              SizedBox(
                height: 2,
                width: MediaQuery.of(context).size.width,
                child: DottedLine(
                  dashColor: Colors.grey,
                  direction: Axis.horizontal,
                ),
              ),
              SizedBox(height: 10,),


              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 96,
                    child: customOutlineButton(() {
                      Navigator.pop(context);
                    }, ItemLabelText(text:'Back',style: TextStyle(fontSize: 16,color: ByMeColors.app_color,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
                  ),
                  SizedBox(width: 20,),

                  SizedBox(
                    width: 96,
                    child: customButton(() {
                      Navigator.pop(context);
                      if(subTitle!=null)
                        Get.to(AppInjector.instance.orderDetails(1));
                      else {

                        bloc.submit.add(null);
                      }

                    }, ItemLabelText(text:'pay',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
                  ),
                ],
              ),
              SizedBox(height: 10,),


            ],
          ),
        );});
}