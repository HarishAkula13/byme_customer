import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../common/button/byme_button.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/load_container/load_container.dart';
import '../../../common/utilities/byme_colors.dart';
import '../../../common/utilities/fonts.dart';
import '../../../di/app_injector.dart';
import 'otp_bloc.dart';

class OTPPage extends StatefulWidget {

  @override
  OTPPageState createState() => OTPPageState();
}
class OTPPageState extends State<OTPPage>{
  OTPBloc? _bloc;
  String _otp = '';
  String text = "";
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      bottomSheet:  SingleChildScrollView(
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
              Padding(
                  padding: EdgeInsets.only(left: 50),
              child:RichText(
                  text: TextSpan(style: TextStyle(fontSize: 11), children: [
                    TextSpan(
                        text: "STEP: ",
                        style: TextStyle(
                            color: Colors.grey, fontFamily: Inter.regular)),
                    TextSpan(text: "1",style: TextStyle(
                        color: ByMeColors.app_color, fontFamily: Inter.regular)),
                    TextSpan(
                        text: "/",
                        style: TextStyle(
                            color: Colors.grey, fontFamily: Inter.regular)),
                    TextSpan(text: "7",style: TextStyle(
                        color: Colors.grey, fontFamily: Inter.regular))
                  ]))
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios,size: 24,color: HexColor("#828785"),)),
                  ItemLabelText(text: "Enter the code \nsent to your phone",style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),),
                ],
              ),
              SizedBox(height: 20,),
              Padding(
                  padding: EdgeInsets.only(left: 50),
                  child: ItemLabelText(text: "We have sent the code to ******8052",style: TextStyle(fontSize: 13,color: Colors.black,fontFamily: Inter.regular),)),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  for (int index = 0; index < 2 * 6 - 1; index++)
                    if (index.isEven)
                      CircleAvatar(
                        radius: 7,
                        backgroundColor:index ~/ 2 < _otp.length ? ByMeColors.app_color : Colors.grey,
                        child: CircleAvatar(
                          radius: 6,
                          backgroundColor: index ~/ 2 < _otp.length ? ByMeColors.app_color : ByMeColors.white_color,
                        ),
                      )
                    else const SizedBox(width: 24),
                ],
              ),
              NumericKeyboard(
                  onKeyboardTap: _onKeyboardTap,
                  textColor: Colors.black,
                  rightButtonFn: () {
                    setState(() {
                      if (_otp.isNotEmpty) {
                        _otp = _otp.substring(0, _otp.length - 1);
                      }
                    });
                  },
                  rightIcon: Icon(Icons.backspace, color: Colors.black,),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
              ),
              customButton(() {
                _bloc!.navigate();
              }, ItemLabelText(text:'Proceed',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
              SizedBox(height: 20,),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
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
      ),

    );


  }
  void _onKeyboardTap(String value) {
    setState(() {
      if (_otp.length < 6) {
        _otp += '0';
      }
    });
  }

}

