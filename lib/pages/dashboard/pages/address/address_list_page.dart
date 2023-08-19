import 'dart:async';
import 'package:byme_app/common/label/item_label_text.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tuple/tuple.dart';
import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/load_container/load_container.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/address_list_bloc.dart';


class AddressListPage extends StatefulWidget{

  AddressListPageState createState()=> AddressListPageState();
}
class AddressListPageState extends State<AddressListPage>{

  AddressListBloc? _bloc;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();

  void initState() {
    _bloc=BlocProvider.of(context);

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      stream: _bloc!.isLoading,
      bottomSheet: SingleChildScrollView(
        child: Container(

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
              Container(
                padding: const EdgeInsets.all(20),
                  alignment: Alignment.centerLeft,
                  child: ItemLabelText(text: 'Select Location',style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w700))),
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Column(
                            children: [
                              Row(children: [
                                SvgPicture.asset('assets/images/gps.svg'),
                                SizedBox(width: 10,),
                                ItemLabelText(text: 'Use Current Location',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),

                              ],),
                              StreamBuilder<String>(
                                  initialData: '',
                                  stream: _bloc!.address,
                                  builder: (context, s) {
                                    return Padding(
                                      padding: const EdgeInsets.only(left: 20.0),
                                      child: ItemLabelText(text: s.data,style:  const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                                    );
                                  }
                              ),

                            ],
                          ),
                        ),
                        Expanded(flex:1,child: Align(alignment:Alignment.centerRight,child: Icon(Icons.arrow_right_outlined)))
                      ],
                    ),
                  ),
                  Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                  GestureDetector(
                    onTap: (){
                      Get.to(AppInjector.instance.changeAddress);
                    },
                    child: Padding(padding: EdgeInsets.all(15),
                    child: Row(children: [
                      SvgPicture.asset('assets/images/plus.svg'),
                      SizedBox(width: 10,),
                      ItemLabelText(text: 'Add Address',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                      Spacer(),
                      Icon(Icons.arrow_right,color: HexColor('#828785'),),
                    ],),),
                  ),
                  Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                  Container(
                      padding: const EdgeInsets.all(20),
                      alignment: Alignment.centerLeft,
                      child: ItemLabelText(text: 'Saved addresses',style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w700))),
                  StreamBuilder<List<dynamic>>(
                    initialData: [],
                    stream: _bloc!.addressList,
                    builder: (context, sp) {
                      return sp.data!.length>0?ListView.builder(
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemCount: sp.data!.length,
                          itemBuilder: (b,i){
                            return Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SvgPicture.asset('assets/images/address.svg'),
                                      SizedBox(width: 10,),
                                      Flexible(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ItemLabelText(text: sp.data![i][1],style:  const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                                            SizedBox(height: 5,),
                                            ItemLabelText(text: '${sp.data![i][2]},${sp.data![i][3]},${sp.data![i][4]}',style:   TextStyle(fontSize: 14,color: HexColor('#858E8B'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),

                                          ],
                                        ),
                                      ),

                                    ],
                                  ),
                                ),
                                Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                              ],
                            );
                          }):SizedBox();
                    })
                ],
              ),


            ],
          ),

        ),
      ),
      child: StreamBuilder<Tuple2<LatLng ,List<Marker>>>(
          initialData: Tuple2(LatLng(0.0,0.0),[]),
          stream: _bloc!.data,
          builder: (context, s) {

            updateCamera(s.data!.item1);

            return (s.data!.item1.latitude>0.0)?Stack(
              children: [


                GoogleMap(
                  markers: Set<Marker>.of(s.data!.item2),
                  mapType: MapType.normal,
                  initialCameraPosition: CameraPosition(
                    target: s.data!.item1,
                    zoom: 14.4746,
                  ),
                  onMapCreated: (GoogleMapController controller) {
                    _controller.complete(controller);

                  },
                ),
                Positioned(
                   top: 30,
                    left: 10,
                    child: GestureDetector(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: SvgPicture.asset('assets/images/arrow_back.svg'))),
              ],
            ):SizedBox();
          }
      ),
    );
  }

  void updateCamera(LatLng latLng) async{
    CameraPosition cameraPosition = new CameraPosition(
      target: latLng,
      zoom: 14,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }




}