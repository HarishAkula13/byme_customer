
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../label/item_label_text.dart';
import '../utilities/byme_colors.dart';
import '../utilities/fonts.dart';

Widget customOutlineButton(Function() onClick,
    Widget title,
final String?  colors,
final  String? textColors,
    BuildContext context){
  return GestureDetector(
    onTap: (){
      onClick();
    },
    child: Container(
      height: MediaQuery.of(context).size.height*0.055,
      alignment: Alignment.center,
      decoration:  BoxDecoration(
         border: Border.all(color:HexColor(colors!),width: 1 ),
          borderRadius: BorderRadius.all(Radius.circular(30)),
         /* gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [HexColor('#ffffff'),HexColor('#ccF6F6F6') ],
          )*/

      ),
      child:title
    ),
  );
}