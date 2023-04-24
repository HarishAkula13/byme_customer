
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../app/arch/bloc_provider.dart';
import '../../common/button/byme_button.dart';
import '../../common/label/item_label_text.dart';
import '../../common/load_container/load_container.dart';
import '../../common/textfield/byme_text_field.dart';
import '../../common/textfield/pyc_text_filed.dart';
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ItemLabelText(text: "Login",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: Inter.bold),),
                ItemLabelText(text: "Forgot Password",style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: Inter.regular),)

              ],
            ),
            SizedBox(height: 20,),
            MyTextField(
              labelText: '',
              hintText: 'Enter phone/email',
              inputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              onChange: _bloc!.email.add,
              onSubmit: (_) => _passwordFocus.requestFocus(),

            ),
            SizedBox(height: 20,),
            MyTextField(
              labelText: '',
              hintText: 'Password',
              focusNode: _passwordFocus,
              inputAction: TextInputAction.done,
              onSubmit: (_) => _bloc!.login.add(null),
              onChange: _bloc!.password.add,
            ),
            SizedBox(height: 20,),
            customButton(() {
             // _bloc!.login.add(null);
             _bloc!.navigate();
            }, ItemLabelText(text:'Sign In',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),
            SizedBox(height: 20,),
            Align(alignment: Alignment.center,
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
            )),

          ],
        ),
      ),
    ),
    child: Container(
      height: MediaQuery.of(context).size.height*0.6,
       alignment: Alignment.center,
       child: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
            SvgPicture.asset('assets/images/shop.svg'),
           SizedBox(height: 10,),
           ItemLabelText(text: "ByMe for business",style: TextStyle(fontSize: 24,color: Colors.black,fontFamily: Inter.bold),),
           SizedBox(height: 10,),
           ItemLabelText(text: "Manage your store from anywhere",style: TextStyle(fontSize: 16,color: ByMeColors.hint_text_color,fontFamily: Inter.regular),)

         ],
       ),
    ),
   );


  }


}