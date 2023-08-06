import 'package:byme_app/common/dialog/bottom_sheet/service_details_dialog.dart';
import 'package:byme_app/common/dropdown/custom_dropdown.dart';
import 'package:byme_app/common/textfield/byme_custom_text_filed.dart';
import 'package:byme_app/common/textfield/byme_text_field.dart';
import 'package:byme_app/pages/dashboard/pages/home/bloc/home_bloc.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:intl/intl.dart';
import '../../button/byme_button.dart';
import '../../button/byme_outline_button.dart';
import '../../label/item_label_text.dart';
import '../../utilities/byme_colors.dart';
import '../../utilities/fonts.dart';
import '../../utilities/logger.dart';
import '../request_dialogue.dart';
import 'mark_done_dialog.dart';

void TaxiServiceDetailsDialog(BuildContext context,Function() onClick,HomeBloc bloc){

  showModalBottomSheet(
    context: context,
    elevation: 0,
    isScrollControlled: true,
    barrierColor: Colors.black.withAlpha(1),
    //backgroundColor: Colors.transparent,
    isDismissible: false,// Also default
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 10,right: 10,left: 10),

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 20,),
              ItemLabelText(text:'Service Details',style: TextStyle(fontSize: 24,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w700)),
              ItemLabelText(text:'Please enter the service details',style: TextStyle(fontSize: 14,color: ByMeColors.un_select,fontFamily: Inter.regular,fontWeight: FontWeight.w700)),
              SizedBox(height: 20,),
              DottedLine(direction: Axis.horizontal,dashColor: HexColor('#CDD0CF'),),
              SizedBox(height: 10,),

              StreamBuilder<String>(
                  initialData: 'Taxi & Travel',
                  stream: bloc.travelType,
                  builder: (context, sna) {
                    return Container(
                        margin: EdgeInsets.only(top: 20),
                        width: MediaQuery.of(context).size.width,
                        child: CustomDropdown(hint: 'Select', value: sna.data, dropdownItems: ['Taxi & Travel'], onChanged:(val){ bloc.addTravelType.add(val!);}));
                  }
              ),
              StreamBuilder<String>(
                  initialData: 'Bike Taxi',
                  stream: bloc.taxiType,
                  builder: (context, sna) {
                    return Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        child: CustomDropdown(hint: 'Select', value: sna.data, dropdownItems: ['Bike Taxi'], onChanged:(val){ bloc.addTaxiType.add(val!);}));
                  }
              ),

              SizedBox(height: 20,),
              MyTextField(
                labelText: '',
                hintText:'MyLocation',
                sufix: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalDivider(thickness: 1,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Icon(Icons.location_on_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20,),
              MyTextField(
                labelText: '',
                hintText:'Drop Location',
                sufix: Padding(
                  padding: const EdgeInsets.only(right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      VerticalDivider(thickness: 1,color: Colors.grey,),
                      SizedBox(width: 5,),
                      Icon(Icons.location_on_outlined),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 100,),

              customButton(() {

                Navigator.pop(context);
                ServiceDetailsDialog(context,(){

                },bloc);

              }, ItemLabelText(text:'Proceed',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
              SizedBox(height: 20,),
            ],
          ),
        ),

      ),
    ),
  );


}