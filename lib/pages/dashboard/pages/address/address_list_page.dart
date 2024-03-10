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
    return WillPopScope(
      onWillPop: showExitPopup,
      child: LoaderContainer(
        stream: _bloc!.isLoading,
        bottomSheet: SingleChildScrollView(
          child: Container(
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
              children: [
                Container(
                  padding: const EdgeInsets.all(20),
                    alignment: Alignment.centerLeft,
                    child: ItemLabelText(text: 'Select Location',style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w700))),
                Column(
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(AppInjector.instance.changeAddress(null))!.then((value) => _bloc!.getAddress());
                      },child: Padding(
                        padding: const EdgeInsets.all(15.0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 4,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                SvgPicture.asset('assets/images/gps.svg'),
                                const SizedBox(width: 10,),
                                Flexible(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      ItemLabelText(text: 'Use Current Location',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                                      const SizedBox(height: 5,),
                                      StreamBuilder<String>(
                                          initialData: '',
                                          stream: _bloc!.address,
                                          builder: (context, s) {
                                            return ItemLabelText(text: s.data,style:  const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500));
                                          }
                                      ),
                                    ],
                                  ),
                                ),

                              ],),
                            ),
                            const Expanded(flex:1,child: Align(alignment:Alignment.centerRight,child: Icon(Icons.arrow_right_outlined)))
                          ],
                        ),
                      ),
                    ),
                    Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                    GestureDetector(
                      onTap: (){
                        Get.to(AppInjector.instance.changeAddress(null))!.then((value) => _bloc!.getAddress());
                      },
                      child: Container(
                        width: Get.width,
                        padding: const EdgeInsets.all(15),

                      child: InkWell(
                        onTap: (){
                          Get.to(AppInjector.instance.changeAddress(null))!.then((value) => _bloc!.getAddress());
                        },
                        child: Row(children: [
                          SvgPicture.asset('assets/images/plus.svg'),
                          const SizedBox(width: 10,),
                          ItemLabelText(text: 'Add Address',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                          const Spacer(),
                          Icon(Icons.arrow_right,color: HexColor('#828785'),),
                        ],),
                      ),),
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
                        return sp.data!.length>0?SizedBox(
                          height: Get.height*0.4,
                          width: Get.width,
                          child: ListView.builder(
                              itemCount: sp.data!.length,
                              itemBuilder: (b,i){
                                return Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          SvgPicture.asset('assets/images/address.svg'),
                                          const SizedBox(width: 10,),

                                          Expanded(
                                            flex:5,
                                            child: InkWell(
                                              onTap: (){
                                                _bloc!.addressCheck(sp.data![i]);
                                              },
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ItemLabelText(text: sp.data![i][1],style:  const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),
                                                  const SizedBox(height: 5,),
                                                  ItemLabelText(text: '${sp.data![i][2]},${sp.data![i][3]},${sp.data![i][4]}',style:   TextStyle(fontSize: 14,color: HexColor('#858E8B'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),

                                                ],
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                              flex:1,
                                              child: Container(
                                              child: GestureDetector(
                                                  onTap: (){
                                                    Get.to(AppInjector.instance.changeAddress(sp.data![i][0]))!.then((value) => _bloc!.getAddress());
                                                  },
                                                  child: SvgPicture.asset('assets/images/edit.svg',height: 30,width: 30,)),
                                          ))

                                          /**/
                                        ],
                                      ),
                                    ),
                                    Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                                  ],
                                );
                              }),
                        ):const SizedBox();
                      })
                  ],
                ),


              ],
            ),

          ),
        ),
        child: StreamBuilder<Tuple2<LatLng ,List<Marker>>>(
            initialData: const Tuple2(LatLng(0.0,0.0),[]),
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
                      zoom: 18,
                    ),
                    onMapCreated: (GoogleMapController controller) {
                      _controller.complete(controller);

                    },
                  ),
                  Positioned(
                     top: 50,
                      left: 10,
                      child: GestureDetector(
                          onTap: (){
                            if(_bloc!.screenType==1) {
                              Navigator.pop(context);
                            }else{
                              showExitPopup();
                            }
                          },
                          child: SvgPicture.asset('assets/images/arrow_back.svg'))),
                ],
              ):const SizedBox();
            }
        ),
      ),
    );
  }

  void updateCamera(LatLng latLng) async{
    CameraPosition cameraPosition = new CameraPosition(
      target: latLng,
      zoom: 18,
    );

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

  }


  Future<bool> showExitPopup() async {

    return (_bloc!.screenType==0)?await showDialog( //show confirm dialogue
      context: context,
      builder: (context) => AlertDialog(
        title: ItemLabelText(text:'Exit App',style: const TextStyle(fontSize: 16,fontFamily: Inter.bold,color: Colors.black)),
        content:  ItemLabelText(text:'Do you want to exit an App?',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,color: Colors.black)),
        actions:[
          GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child:  Container(
              height: 40,
              width: 100,
                alignment: Alignment.center,
              decoration: BoxDecoration(
                color: ByMeColors.app_color,
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
                child: ItemLabelText(text:'No',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,color: Colors.white))),
          ),
        const SizedBox(width: 10,),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child:  Container(
                height: 40,
                width: 100,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  border: Border.all(color: ByMeColors.app_color),
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                ),
                child: ItemLabelText(text:'Yes',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,color: Colors.black))),
          ),


        ],
      ),
    )??false:false;
  }

}