import 'package:byme_app/common/dropdown/custom_dropdown.dart';
import 'package:byme_app/common/textfield/byme_custom_text_filed.dart';
import 'package:byme_app/common/textfield/byme_text_field.dart';
import 'package:byme_app/model/dashboard/categories.dart';
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

void ServiceDetailsDialog(BuildContext context,Function() onClick,HomeBloc bloc){

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
                initialData: 'Construction Works',
                stream: bloc.selectedName,
                builder: (context, sna) {
                  return Container(
                      margin: EdgeInsets.only(top: 20),
                      width: MediaQuery.of(context).size.width,
                      child: CustomDropdown(hint: 'Select', value: sna.data, dropdownItems: ['Construction Works'], onChanged:(val){ bloc.addSelectedName.add(val!);}));
                }
              ),
              StreamBuilder<String>(
                  initialData: 'Carpentry',
                  stream: bloc.subCate,
                  builder: (context, sna) {
                    return Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        child: CustomDropdown(hint: 'Select', value: sna.data, dropdownItems: ['Carpentry'], onChanged:(val){ bloc.addSubCate.add(val!);}));
                  }
              ),
              StreamBuilder<String>(
                  initialData: 'Pilot Service (Instant)',
                  stream: bloc.serviceType,
                  builder: (context, sna) {
                    return Container(
                        margin: EdgeInsets.only(top: 15),
                        width: MediaQuery.of(context).size.width,
                        child: CustomDropdown(hint: 'Service type', value: sna.data, dropdownItems: ['Pilot Service (Instant)','Firm Service (Appointment)'], onChanged:(val){ bloc.addServiceType.add(val!);}));
                  }
              ),
              StreamBuilder<String>(
                initialData: 'Pilot Service (Instant)',
                stream: bloc.serviceType,
                builder: (context, sna) {
                  return (sna.data=='Pilot Service (Instant)')?SizedBox(height: 15,):Column(
                    children: [
                      SizedBox(height: 15,),
                      StreamBuilder<String>(
                        initialData: "",
                        stream: bloc.dateTime,
                        builder: (context, snapshot) {
                          return MyTextField(
                            controller: TextEditingController(text: snapshot.data),
                            labelText: '',
                            hintText: 'Select Date',
                            readOnly: true,
                            onTap: () async {
                              var pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2050)).then((value) {
                                if (value != null) {
                                  var text = DateFormat("dd-MM-yyyy").format(value);
                                  printLog("text", text);
                                  bloc.addDateTime.add(text);
                                }
                              });

                            },
                            inputAction: TextInputAction.next,
                            keyboardType: TextInputType.text,
                          );
                        }
                      ),
                      SizedBox(height: 15,)
                    ],
                  );
                }
              ),

              SizedBox(height: 15,),
              MyCustomTextField(
                labelText: '',
                hintText: 'Description of Work',
                inputAction: TextInputAction.next,
                keyboardType: TextInputType.text,
                onChange: bloc.addWorkDes.add,

              ),
              SizedBox(height: 15,),
              MyCustomTextField(
                labelText: '',
                hintText: 'Additional Instructions',
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.text,
                onChange: bloc.addInstruction.add,

              ),
              SizedBox(height: 20,),
              StreamBuilder<bool>(
                initialData: false,
                stream: bloc.valid,
                builder: (context, snap) {
                  return customButton(() {
                    if(snap.data==true) {
                      Navigator.pop(context);
                      requestDialogue(title: 'Service Order Request',amount: '20',des: 'Would you like to place the order with selected service?');
                    }

                  }, ItemLabelText(text:(snap.data==true)?'Proceed to checkout':'Proceed',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context);
                }
              ),
              SizedBox(height: 20,),
            ],
          ),
        ),

      ),
    ),
  );


}