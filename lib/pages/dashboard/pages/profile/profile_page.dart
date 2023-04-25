import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/load_container/load_container.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/profile_bloc.dart';


class ProfilePage extends StatefulWidget {

  @override
  ProfilePageState createState() => ProfilePageState();
}
class ProfilePageState extends State<ProfilePage>{
  ProfileBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        toolbarHeight: MediaQuery.of(context).size.height*0.12,
        elevation: 0,
        backgroundColor: HexColor('#E7F6EA'),
        title: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ItemLabelText(text: 'NandaKumar',style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black),),
              SizedBox(height: 5,),
              ItemLabelText(text: '@9048005555',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#6F7C75')),)
            ],
          ),
        ),
      ),
      body: LoaderContainer(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 3,),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                  child: InkWell(
                    onTap: (){
                      _bloc!.onNavigate();
                     // Get.to(AppInjector.instance.ordersHistory);
                    },
                    child: Row(
                      children: [
                        SvgPicture.asset('assets/images/order.svg',height: 21,width: 21,color:ByMeColors.un_select,),
                        SizedBox(width: 20,),
                        ItemLabelText(text: 'Your Orders',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),)
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: DottedLine(direction: Axis.horizontal,dashColor: HexColor('#CDD0CF'),),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Icon(Icons.call,color: HexColor('#858E8B'),),
                          SizedBox(width: 20,),
                          ItemLabelText(text: '+91-9048005555',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),

                      Row(
                        children: [
                          Icon(Icons.email_sharp,color: HexColor('#858E8B'),),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'nandakumar@gmail.com',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),
                      Row(
                        children: [
                          Icon(Icons.location_on_outlined,color: HexColor('#858E8B'),),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'Ammavari Peta, Bhattupalli',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),
                      Row(
                        children: [
                          Icon(Icons.settings_sharp,color: HexColor('#858E8B'),),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'Settings',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                          Spacer(),
                          Icon(Icons.arrow_forward_ios_sharp,color: HexColor('#C4C4C4'),size: 14,)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/images/terms.svg'),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'Terms & Conditions',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),
                      Row(
                        children: [
                          Icon(Icons.star_border_sharp,color: HexColor('#858E8B'),),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'Rate Our App',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                        child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                      ),
                      Row(
                        children: [
                          RotatedBox(
                              quarterTurns: 90,
                              child: Icon(Icons.exit_to_app_sharp,color: HexColor('#858E8B'),)),
                          SizedBox(width: 20,),
                          ItemLabelText(text: 'Log Out',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                          Spacer(),
                          Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                        ],
                      ),

                    ],
                  ),
                )


              ],
            ),
          ),
        ),

      ),
    );


  }


}