import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../common/button/byme_button.dart';
import '../../../common/fonts/fonts.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/load_container/load_container.dart';
import '../../../common/utilities/byme_colors.dart';
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
      stream: _bloc!.isLoading,
      bottomSheet:  SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(25),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 0,
                  blurRadius: 16,
                  offset: const Offset(0, -6),
                )
              ]
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child:RichText(
                      text: TextSpan(style: const TextStyle(fontSize: 11), children: [
                        const TextSpan(
                            text: "STEP: ",
                            style: TextStyle(
                                color: Colors.grey, fontFamily: Fonts.regular)),
                        TextSpan(text: "1",style: TextStyle(
                            color: ByMeColors.app_color, fontFamily: Fonts.regular)),
                        const TextSpan(
                            text: "/",
                            style: TextStyle(
                                color: Colors.grey, fontFamily: Fonts.regular)),
                        const TextSpan(text: "7",style: TextStyle(
                            color: Colors.grey, fontFamily: Fonts.regular))
                      ]))),

              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios,size: 24,color: HexColor("#828785"),)),
                  ItemLabelText(text: "Enter the code \nsent to your phone",style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Fonts.medium,fontWeight: FontWeight.w600),),
                ],
              ),
              const SizedBox(height: 20,),
              Padding(
                  padding: const EdgeInsets.only(left: 50),
                  child: ItemLabelText(text: "We have sent the code to ${_bloc!.verifyData!.mobileNumber}",style: const TextStyle(fontSize: 13,color: Colors.black,fontFamily: Fonts.regular),)),
              const SizedBox(height: 20,),
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
                  rightIcon: const Icon(Icons.backspace, color: Colors.black,),
                  mainAxisAlignment: MainAxisAlignment.spaceBetween
              ),
              const SizedBox(height: 10,),
              StreamBuilder<String>(
                initialData: '00:60',
                stream: _bloc!.isTimer,
                builder: (context, st) {
                  return Center(child: TextButton(onPressed: (){
                    _bloc!.resendOTP();
                  }, child:  ItemLabelText(text:(st.data=="00:00")?'Resend a code':'Resend a code in  ${st.data}',style: TextStyle(fontSize: 12,color: (st.data=="00:00")?ByMeColors.app_color:ByMeColors.un_select,fontFamily: Fonts.regular))));
                }
              ),
              customButton(() {
                _bloc!.navigate(_otp);

              }, ItemLabelText(text:(_bloc!.type==0)?'Proceed':'Verify OTP',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Fonts.regular)),'#00B05A','#ffffff',context),


              const SizedBox(height: 20,),
              Container(
                color: Colors.white,
                alignment: Alignment.center,
                child: RichText(
                  text:  TextSpan(
                    text: 'By creating a passcode you agree with our ',
                    style: TextStyle(
                        fontSize: 11,
                        color: HexColor('#838080'),
                        fontFamily: Fonts.regular,
                        fontWeight: FontWeight.w400
                    ),
                    children: [
                      TextSpan(
                        text: 'Terms & Conditions ',
                        recognizer: TapGestureRecognizer()..onTap = () =>Get.to(AppInjector.instance.privacyPolicy(2)),
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#0E8E60'),
                            fontFamily: Fonts.regular,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextSpan(
                        text: ' and ',
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#838080'),
                            fontFamily: Fonts.regular,
                            fontWeight: FontWeight.w600
                        ),
                      ),
                      TextSpan(
                        text: 'Privacy Policy',
                        recognizer: TapGestureRecognizer()..onTap = () =>Get.to(AppInjector.instance.privacyPolicy(1)),
                        style: TextStyle(
                            fontSize: 11,
                            color: HexColor('#0E8E60'),
                            fontFamily: Fonts.regular,
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
        _otp = _otp+value;
      }
    });
  }

}

