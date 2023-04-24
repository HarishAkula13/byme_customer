import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../button/byme_button.dart';
import '../fonts/fonts.dart';
import '../label/item_label_text.dart';
import '../utilities/fonts.dart';

mixin CustomDialogMixin{
  void dialogButton(String title,Widget childWidget,String? buttonTitle,Function()? callback,String? buttonSubTitle,Function()? subCallback){
    showDialog(
      context: Get.context!,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding: EdgeInsets.zero,
          actionsPadding: EdgeInsets.zero,
          backgroundColor:Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(16)),
          ),
          title: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(16),
                      topLeft: Radius.circular(16))),
              padding: EdgeInsets.all(10),
              child: Container(
                  padding: EdgeInsets.all(10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: ItemLabelText(
                          text:title,
                          style: TextStyle(
                              fontSize: 20,
                              fontFamily: Fonts.bold,
                              color: Colors.black),),
                      ),
                    ],
                  ))),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              childWidget,
              Container(
                margin: EdgeInsets.only(top: 30),
                width: MediaQuery.of(context).size.width,
                child: DottedLine(
                  direction: Axis.horizontal,
                  dashColor: HexColor('#CDD0CF'),
                ),
              )

            ],
          ),
          actions: [
            Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(16),
                      bottomLeft: Radius.circular(16))),
              padding: EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 46,
                    width: 90,
                    child: customButton(() {
                      Navigator.pop(context);
                    }, ItemLabelText(text:'Cancel',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: Inter.regular)),'#C4C4C4','#ffffff',context,),
                  ),
                 SizedBox(width: 20,),
                  SizedBox(
                    height: 46,
                    width: 90,
                    child: customButton(() {
                      Navigator.pop(context);
                    }, ItemLabelText(text:'Close',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
                  ),
                ],
              ),
            )
          ],
        );
      },
    );
  }

}