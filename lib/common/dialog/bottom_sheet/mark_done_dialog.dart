import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../button/byme_button.dart';
import '../../button/byme_outline_button.dart';
import '../../label/item_label_text.dart';
import '../../utilities/byme_colors.dart';
import '../../utilities/fonts.dart';

void markDoneDialog(BuildContext context,Function() onClick){

  showModalBottomSheet(
    context: context,
    elevation: 0,
    barrierColor: Colors.black.withAlpha(1),
    //backgroundColor: Colors.transparent,
    isDismissible: false,// Also default
    builder: (context) => SingleChildScrollView(
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
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            SizedBox(height: 20,),
            SvgPicture.asset('assets/images/verify.svg'),
            SizedBox(height: 10,),
            ItemLabelText(text:'Congratulations! \n Money is received.',textAlignment:TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
            SizedBox(height: 15,),
            customButton(() {
                onClick();
            }, ItemLabelText(text:'Service Orders',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
            SizedBox(height: 10,),
            RichText(
              text:  TextSpan(
                text: 'Facing issue?',
                style: TextStyle(
                    color: Colors.black,
                    fontFamily: Inter.regular,
                    fontWeight: FontWeight.w400
                ),
                children: [
                  TextSpan(
                    text: ' Chat with Assistant',
                    style: TextStyle(
                        color: HexColor('#0E8E60'),
                        fontFamily: Inter.regular,
                        fontWeight: FontWeight.w600
                    ),
                  ),
                ],
              ),
            )
          ],
        ),

      ),
    ),
  );


}