
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/dialog/custom_dialogs.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/textfield/byme_text_field.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import '../../../../di/app_injector.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> with CustomDialogMixin{
  HomeBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,

      title:Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ItemLabelText(text: 'Ranjith Kumar',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),),
          SizedBox(width: 10,),

          Row(
            children: [
              SvgPicture.asset('assets/images/icon_shop.svg',),
              SizedBox(width: 5,),
              ItemLabelText(text: 'kavuri hills  ',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular),),
                        ],
          ),
        ],
      ),
    ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              MyTextField(
                labelText: "",
                hintText: "Search for items & shop",
                inputAction: TextInputAction.done,
                keyboardType: TextInputType.name,
              ),

            ],
          ),
        ),
      ),
    );


  }


}