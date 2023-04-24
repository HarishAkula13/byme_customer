import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../button/byme_button.dart';
import '../../button/byme_outline_button.dart';
import '../../label/item_label_text.dart';
import '../../utilities/byme_colors.dart';
import '../../utilities/fonts.dart';
import 'mark_done_dialog.dart';

void orderInfoDialog(BuildContext context,Function() onClick){

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
            customButton(() {
              Navigator.pop(context);
              onClick();
              markDoneDialog(context,(){
                Navigator.pop(context);
              });
            }, ItemLabelText(text:'Mark as Done',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
            SizedBox(height: 15,),
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: customOutlineButton(() {


                  },  ItemLabelText(text:'Request Money',style: TextStyle(fontSize: 16,color: ByMeColors.app_color,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                ),
                Spacer(),
                Expanded(
                  flex: 5,
                  child: customOutlineButton(() {

                  }, ItemLabelText(text:'Track User',style: TextStyle(fontSize: 16,color:  ByMeColors.app_color,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                )


              ],
            )
          ],
        ),

      ),
    ),
  );


}