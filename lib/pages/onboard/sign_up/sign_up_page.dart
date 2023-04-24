
import 'package:byme_app/di/i_login_page.dart';
import 'package:byme_app/pages/onboard/sign_up/sign_up_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import '../../../app/arch/bloc_provider.dart';
import '../../../common/button/byme_button.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/load_container/load_container.dart';
import '../../../common/utilities/byme_colors.dart';
import '../../../common/utilities/fonts.dart';
import '../../../di/app_injector.dart';


class SignUpPage extends StatefulWidget {

  @override
  SignUpPageState createState() => SignUpPageState();
}
class SignUpPageState extends State<SignUpPage>{
  SignUpBloc? _bloc;

  String text = "";
  TextEditingController _number=TextEditingController();
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
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
          alignment: Alignment.bottomCenter,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios,size: 24,color: HexColor("#828785"),)),
                  Flexible(child: ItemLabelText(text: "Enter your \nmobile Number",style: TextStyle(fontSize: 24,color: Colors.black,fontFamily: Inter.bold),)),
                ],
              ),
             
              SizedBox(height: 20,),
              ItemLabelText(text: "We will send you a conformation code ",style: TextStyle(fontSize: 13,color: Colors.black,fontFamily: Inter.regular),),
              SizedBox(height: 20,),
              SizedBox(
                width: MediaQuery.of(context).size.width*0.8,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ItemLabelText(text: '+91 ',style: TextStyle(fontSize: 22,color: HexColor('#C4C4C4'),fontWeight: FontWeight.w600),),
                    SizedBox(
                      height: 48,
                      width: MediaQuery.of(context).size.width*0.4,
                      child: TextField(
                        controller: _number,
                        readOnly: true,
                        showCursor: true,
                        style: TextStyle(fontSize: 22,color: Colors.black,fontWeight: FontWeight.w600),
                        cursorColor: ByMeColors.app_color,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: Colors.black,
                  rightButtonFn: () {
                    text = text.substring(0, text.length - 1);
                    _number.text=text;
                  },
                  rightIcon: Icon(Icons.backspace, color: Colors.black,),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
              ),
              customButton(() {
                _bloc!.sendOTP.add(null);
                Get.to(AppInjector.instance.otpPage);

              }, ItemLabelText(text:'Sign In',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
              SizedBox(height: 20,),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                margin: EdgeInsets.all(8),
                child: RichText(
                  text:  TextSpan(
                    text: 'By creating a passcode you agree with our ',
                    style: TextStyle(
                        fontSize: 11,
                        color: HexColor('#838080'),
                        fontFamily: Inter.regular,
                        fontWeight: FontWeight.w400
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions ',
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#0E8E60'),
                            fontFamily: Inter.regular,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#838080'),
                            fontFamily: Inter.regular,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#0E8E60'),
                            fontFamily: Inter.regular,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                    ],
                  ),
                  textAlign: TextAlign.center,
                ),
              ),

            ],
          ),

        ),
      )
,
    );


  }
  void _onKeyboardTap(String value) {
    text = text + value;
    _number.text=text;
   /* setState(() {
      text = text + value;
    });*/
  }

}

