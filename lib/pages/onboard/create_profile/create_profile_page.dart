
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../common/button/byme_button.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/load_container/load_container.dart';
import '../../../common/textfield/byme_text_field.dart';
import '../../../common/utilities/byme_colors.dart';
import '../../../common/utilities/fonts.dart';
import '../../../di/app_injector.dart';
import 'create_profile_bloc.dart';


class CreateProfilePage extends StatefulWidget{

  CreateProfilePageState createState()=> CreateProfilePageState();
}
class CreateProfilePageState extends State<CreateProfilePage>{

  CreateProfileBloc? _bloc;
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(25),
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
           mainAxisAlignment: MainAxisAlignment.start,
           crossAxisAlignment: CrossAxisAlignment.start,
           children: [
             SizedBox(height: 30,),
             Padding(
                 padding: EdgeInsets.only(left: 50),
                 child:RichText(
                     text: TextSpan(style: TextStyle(fontSize: 11), children: [
                       TextSpan(
                           text: "STEP: ",
                           style: TextStyle(
                               color: Colors.grey, fontFamily: Inter.regular)),
                       TextSpan(text: "2",style: TextStyle(
                           color: ByMeColors.app_color, fontFamily: Inter.regular)),
                       TextSpan(
                           text: "/",
                           style: TextStyle(
                               color: Colors.grey, fontFamily: Inter.regular)),
                       TextSpan(text: "7",style: TextStyle(
                           color: Colors.grey, fontFamily: Inter.regular))
                     ]))),

             Row(
               children: [
                 IconButton(onPressed: (){
                   Navigator.pop(context);
                 }, icon: Icon(Icons.arrow_back_ios,size: 24,color: HexColor("#828785"),)),
                 Flexible(child: ItemLabelText(text: "Now Please tell us about you",style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),)),
               ],
             ),
             Padding(
                 padding: EdgeInsets.only(left: 50),
                 child: ItemLabelText(text: "We will keep this data safe with us",style: TextStyle(fontSize: 13,color: Colors.black,fontFamily: Inter.regular),)),
             SizedBox(height: 20,),
             MyTextField(
               labelText: "",
               hintText: "Your Full Name",
               inputAction: TextInputAction.next,
               keyboardType: TextInputType.emailAddress,
               onChange: _bloc!.name.add,
               validationStream: _bloc!.nameValidationData,
             ),
             SizedBox(height: 20,),
             MyTextField(
               labelText: "",
               hintText: "Email Address",
               inputAction: TextInputAction.next,
               keyboardType: TextInputType.emailAddress,
               onChange: _bloc!.email.add,
               validationStream: _bloc!.emailValidation,
             ), SizedBox(height: 20,),
             SizedBox(height: 40,),
             customButton(() {
             _bloc!.proceed.add(null);
             }, ItemLabelText(text:'Finish',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),

           ],
         ),
        ),
      ),
    );
  }



}