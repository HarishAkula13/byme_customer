
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../app/arch/bloc_provider.dart';
import '../../common/button/byme_button.dart';
import '../../common/button/byme_outline_button.dart';
import '../../common/label/item_label_text.dart';
import '../../common/load_container/load_container.dart';
import '../../common/textfield/byme_text_field.dart';
import '../../common/utilities/byme_colors.dart';
import '../../common/utilities/fonts.dart';
import '../../di/app_injector.dart';
import 'login_bloc.dart';

class LoginPage extends StatefulWidget {

  @override
  LoginPageState createState() => LoginPageState();
}
class LoginPageState extends State<LoginPage>{
  LoginBloc? _bloc;
  FocusNode _passwordFocus = FocusNode();

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
        child: Column(
          children: [
            SizedBox(height: 40,),
            customButton(() {
              _bloc!.navigate();
            }, ItemLabelText(text:'Login',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
            SizedBox(height: 20,),
            customOutlineButton(() {
              //_bloc!.navigate();
              Get.to(AppInjector.instance.signUpPage(1));
            }, ItemLabelText(text:'Sign up',style: TextStyle(fontSize: 16,color: HexColor('#00B05A'),fontFamily: Inter.regular)),'#00B05A','#ffffff',context),

              SizedBox(height: 20,),
           /* Align(alignment: Alignment.center,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ItemLabelText(text: "Don't have an account? ",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: Inter.regular),),
                GestureDetector(
                  onTap: (){
                    Get.to(AppInjector.instance.signUpPage);

                  },
                    child: ItemLabelText(text: "Sign Up",style: TextStyle(fontSize: 16,color: ByMeColors.app_color,fontFamily: Inter.regular),)),

              ],
            )),*/
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
                      recognizer: TapGestureRecognizer()..onTap = () =>Get.to(AppInjector.instance.privacyPolicy(2)),
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
                      recognizer: TapGestureRecognizer()..onTap = () =>Get.to(AppInjector.instance.privacyPolicy(1)),
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
    child: Container(
      padding: EdgeInsets.all(30),
      height: MediaQuery.of(context).size.height*0.4,
       alignment: Alignment.centerLeft,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.start,
         children: [
           ItemLabelText(text: "Get everything \nsimply delivered",style: TextStyle(fontSize: 32,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700),),
           SizedBox(height: 10,),
           ItemLabelText(text: "Enjoy the hussle-free delivery",style: TextStyle(fontSize: 16,color: ByMeColors.hint_text_color,fontFamily: Inter.regular),)

         ],
       ),
    ),
   );


  }


}