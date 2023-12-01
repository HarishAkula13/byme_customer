import 'package:byme_app/common/fonts/fonts.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/user/user_profile.dart';
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
    return StreamBuilder<UserProfile>(
      stream: _bloc!.userProfile,
      builder: (context, sna) {
        return Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: MediaQuery.of(context).size.height*0.12,
            elevation: 0,
            backgroundColor: HexColor('#E7F6EA'),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: Get.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ItemLabelText(text: (sna.data!=null)? sna.data!.fullName:'',style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black),),
                    const SizedBox(height: 5,),
                    ItemLabelText(text: '@${(sna.data!=null)? sna.data!.phoneNumber:''}',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#6F7C75')),)
                  ],
                ),
              ),
            ),
          ),
          body: LoaderContainer(
            stream: _bloc!.isLoading,
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 3,),
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
                            const SizedBox(width: 20,),
                            ItemLabelText(text: 'Your Orders',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),)
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
                              const SizedBox(width: 20,),
                              ItemLabelText(text: '+91-${(sna.data!=null)? sna.data!.phoneNumber:''}',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),

                          Row(
                            children: [
                              Icon(Icons.email_sharp,color: HexColor('#858E8B'),),
                              const SizedBox(width: 20,),
                              ItemLabelText(text: '${(sna.data!=null)? sna.data!.emailId:''}',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          InkWell(
                            onTap: (){
                              Get.to(AppInjector.instance.addressList(1));
                            },
                            child: Row(
                              children: [
                                Icon(Icons.location_on_outlined,color: HexColor('#858E8B'),),
                                const SizedBox(width: 20,),
                                ItemLabelText(text: 'Add Address',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                                const Spacer(),
                                Icon(Icons.arrow_forward_ios_sharp,color: HexColor('#C4C4C4'),size: 14,)

                              ],
                            ),
                          ),
                        /*  Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          Row(
                            children: [
                              SvgPicture.asset('assets/images/wallet.svg',height: 16,width: 22,),
                              const SizedBox(width: 20,),
                              ItemLabelText(text: '${(sna.data!=null)? sna.data!.recentPaymentMethod:''}',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios_sharp,color: HexColor('#C4C4C4'),size: 14,)

                            ],
                          ),*/
                         /* Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),*/
                          /*Row(
                            children: [
                              Icon(Icons.settings_sharp,color: HexColor('#858E8B'),),
                              const SizedBox(width: 20,),
                              ItemLabelText(text: 'Settings',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                              const Spacer(),
                              Icon(Icons.arrow_forward_ios_sharp,color: HexColor('#C4C4C4'),size: 14,)
                            ],
                          ),
                          */
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          InkWell(
                            onTap: (){

                            Get.to(AppInjector.instance.privacyPolicy(2));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/terms.svg'),
                                const SizedBox(width: 20,),
                                ItemLabelText(text: 'Terms & Conditions',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                                const Spacer(),
                                Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          InkWell(
                            onTap: (){

                              Get.to(AppInjector.instance.privacyPolicy(1));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/privacy.svg'),
                                const SizedBox(width: 20,),
                                ItemLabelText(text: 'Privacy Policy',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                                const Spacer(),
                                Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          InkWell(
                            onTap: (){

                              Get.to(AppInjector.instance.privacyPolicy(3));
                            },
                            child: Row(
                              children: [
                                SvgPicture.asset('assets/images/refund.svg'),
                                const SizedBox(width: 20,),
                                ItemLabelText(text: 'Refund Policy',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: Colors.black),),
                                const Spacer(),
                                Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          Row(
                            children: [
                              Icon(Icons.star_border_sharp,color: HexColor('#858E8B'),),
                              const SizedBox(width: 20,),
                              ItemLabelText(text: 'Rate Our App',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                              const Spacer(),
                              Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 10.0,bottom: 10),
                            child: Divider(color: HexColor('#E9E9E9'),thickness: 1,indent: 40,),
                          ),
                          InkWell(
                            onTap: (){
                              showAlertDialog(context);
                            },
                            child: Row(
                              children: [
                                RotatedBox(
                                    quarterTurns: 90,
                                    child: Icon(Icons.exit_to_app_sharp,color: HexColor('#858E8B'),)),
                                const SizedBox(width: 20,),
                                ItemLabelText(text: 'Log Out',style: TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w400,color: HexColor('#292929')),),
                                const Spacer(),
                                Icon(Icons.chevron_right,color: HexColor('#C4C4C4'),)
                              ],
                            ),
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
    );


  }
  showAlertDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: ItemLabelText(text:'Logout',style: const TextStyle(fontSize: 16,fontFamily: Fonts.semibold)),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ItemLabelText( text: 'Are you sure do you want to logout?',style: const TextStyle(fontSize: 14,fontFamily: Fonts.regular)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: ItemLabelText( text:'Logout',style: const TextStyle(fontSize: 14,fontFamily: Fonts.regular,color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _bloc!.userLogout();
              },
            ),
            TextButton(
              child: ItemLabelText( text:'Cancel',style: const TextStyle(fontSize: 14,fontFamily: Fonts.regular,color: Colors.green)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


}