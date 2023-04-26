import 'dart:async';
import 'package:byme_app/common/dialog/request_dialogue.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tuple/tuple.dart';

import '../../app/arch/bloc_provider.dart';
import '../../common/button/byme_button.dart';
import '../../common/button/byme_outline_button.dart';
import '../../common/label/item_label_text.dart';
import '../../common/utilities/byme_colors.dart';
import '../../common/utilities/fonts.dart';
import '../../di/app_injector.dart';
import 'bloc/track_order_bloc.dart';

class TrackOrderPage extends StatefulWidget {

  @override
  TrackOrderPageState createState() => TrackOrderPageState();
}
class TrackOrderPageState extends State<TrackOrderPage>{
  TrackOrderBloc? _bloc;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(17.4523004,78.3630278),
    zoom: 14.4746,
  );



  @override
  void initState() {
    _bloc=BlocProvider.of(context);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          StreamBuilder<Tuple3<List<LatLng> ,List<Marker> ,Map<PolylineId, Polyline>>>(
            initialData: Tuple3([],[],{}),
            stream: _bloc!.data,
            builder: (context, s) {
              return (s.data!.item1.length>0)?GoogleMap(
                markers: Set<Marker>.of(s.data!.item2),
                mapType: MapType.normal,
                myLocationEnabled: true,
                myLocationButtonEnabled: true,
                compassEnabled: true,
                polylines: Set<Polyline>.of(s.data!.item3.values),
                initialCameraPosition: CameraPosition(
                  target: s.data!.item1[0],
                  zoom: 14,
                ),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);

                },
              ):SizedBox();
            }
          ),
        ],
      ),
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
          child: StreamBuilder<int>(
            initialData: 0,
            stream: _bloc!.dialogType,
            builder: (context, sn) {
              return Column(
                children: [
                  (sn.data==0)?Column(
                    children: [
                      SizedBox(height: 20,),
                      SvgPicture.asset('assets/images/verify.svg'),
                      SizedBox(height: 20,),
                      ItemLabelText(text:'Order Confirmed',textAlignment:TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
                      SizedBox(height: 15,),
                      ItemLabelText(text:'Your order has been confirmed',textAlignment:TextAlign.center,style: TextStyle(fontSize: 14,color: HexColor('#444444'),fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                    ],
                  ):Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                        Navigator.pop(context);
                        requestDialogue(title: 'Request Received !',amount: '500',des: 'Request to Pay remaining \nService Changes.',subTitle:'4820 5790');

                      },
                      child: Row(
                        children: [
                          Flexible(
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/images/verify.svg'),
                                SizedBox(height: 5,),
                                ItemLabelText(text:'Order Confirmed',textAlignment:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Icon(Icons.more_horiz_sharp,color: ByMeColors.app_color,size: 40,),
                              ItemLabelText(text:'',textAlignment:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),

                            ],
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/images/verify.svg'),
                                SizedBox(height: 5,),
                                ItemLabelText(text:'Service Agent reached',textAlignment:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Icon(Icons.more_horiz_sharp,color: ByMeColors.app_color,size: 40,),
                              ItemLabelText(text:'',textAlignment:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),

                            ],
                          ),
                          Flexible(
                            child: Column(
                              children: [
                                SvgPicture.asset('assets/images/verify.svg'),
                                SizedBox(height: 5,),
                                ItemLabelText(text:'Order Delivered',textAlignment:TextAlign.center,style: TextStyle(fontSize: 15,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 5,),
                  GestureDetector(
                      onTap: (){
                        Get.to(AppInjector.instance.dashboardPage(1));
                      },
                      child: ItemLabelText(text:'See Order details',textAlignment:TextAlign.center,style: TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.regular,fontWeight: FontWeight.w400))),
                  Container(
                    width: 200,
                    margin: EdgeInsets.only(top: 15,bottom: 15),
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(44)),
                      color: HexColor('#E9E9E9'),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset('assets/images/clock.svg'),
                        SizedBox(width: 10,),
                        ItemLabelText(text:'Arriving in 45 Mins',textAlignment:TextAlign.center,style: TextStyle(fontSize: 14,color: ByMeColors.un_select,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),

                      ],
                    ),
                  ),
                  Divider(color: HexColor('#E9E9E9'),thickness: 1,),
                  SizedBox(height: 15,),
                  Container(
                    decoration: BoxDecoration(
                      color: HexColor('#F5F5F5'),
                      borderRadius: BorderRadius.all(Radius.circular(11)),
                    ),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: Row(
                            children: [
                              SvgPicture.asset('assets/images/icon.svg'),
                              SizedBox(width: 10,),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ItemLabelText(text:'Karthik Raacha',textAlignment:TextAlign.center,style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600)),
                                  ItemLabelText(text:'Carmel Lane, Bhattupalli',textAlignment:TextAlign.center,style: TextStyle(fontSize: 11,color: ByMeColors.un_select,fontFamily: Inter.medium,fontWeight: FontWeight.w400)),

                                ],
                              ),
                              Spacer(),
                              GestureDetector(
                                  onTap: (){
                                     _bloc!.addDialogType.add(1);
                                  },
                                  child: SvgPicture.asset('assets/images/call.svg')),

                            ],
                          ),
                        ),

                      ],
                    ),
                  ),
                  SizedBox(height: 15,),
                  RichText(
                    text:  TextSpan(
                      text: 'Facing issue?',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Inter.regular,
                          fontWeight: FontWeight.w400
                      ),
                      children: [
                        TextSpan(
                          text: ' Chat with Assistant',
                          style: TextStyle(
                              color: HexColor('#0E8E60'),
                              fontFamily: Inter.regular,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          ),

        ),
      ),

    );


  }


}