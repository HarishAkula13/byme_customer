import 'dart:async';
import 'package:byme_app/common/button/byme_outline_button.dart';
import 'package:byme_app/common/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tuple/tuple.dart';
import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/button/byme_button.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/load_container/load_container.dart';
import '../../../../common/textfield/byme_text_field.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/change_address_bloc.dart';


class ChangeAddressPage extends StatefulWidget{

  ChangeAddressPageState createState()=> ChangeAddressPageState();
}
class ChangeAddressPageState extends State<ChangeAddressPage>{

  ChangeAddressBloc? _bloc;
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
          child:
          StreamBuilder<bool>(
            initialData: false,
            stream: _bloc!.isChange,
            builder: (context, san) {
              return (san.data==false)?Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemLabelText(text: "Select location",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),),

                  SizedBox(height: 10,),
                  Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: "Your Location",style: TextStyle(fontSize: 13,color: HexColor('#858E8B'),fontFamily: Inter.regular,fontWeight: FontWeight.w400),),
                        StreamBuilder<String>(
                          initialData: '',
                          stream: _bloc!.address,
                          builder: (context, sn) {
                            return Row(
                              children: [
                                Expanded(
                                    flex: 8,
                                    child: ItemLabelText(text: sn.data,style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500),)),
                            Expanded(
                            flex: 2,
                            child:ItemLabelText(text: 'CHANGE',style:  TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.regular,fontWeight: FontWeight.w500),),)

                              ],
                            );
                          }
                        ),



                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                  SizedBox(height: 10,),
                  ItemLabelText(text: "Your Location",style: TextStyle(fontSize: 13,color: HexColor('#858E8B'),fontFamily: Inter.regular,fontWeight: FontWeight.w400),),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(
                        width: 72,
                        height: 40,
                        child: customOutlineButton(() {
                          _bloc!.addAddress('Home');

                        }, ItemLabelText(text:'Home',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),'#00B05A','#ffffff',context),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: 72,
                        height: 40,
                        child: customOutlineButton(() {
                          _bloc!.addAddress('Office');

                        }, ItemLabelText(text:'Office',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),'#00B05A','#ffffff',context),
                      ),
                      SizedBox(width: 5,),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: customOutlineButton(() {
                            _bloc!.addIsChange.add(true);
                        }, Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(Icons.edit_outlined,color: HexColor('#B6B6B6'),size: 16,),
                            SizedBox(width: 5,),
                            ItemLabelText(text:'Custom',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                          ],
                        ),'#00B05A','#ffffff',context),
                      )
                    ],
                  )

                ],
              ):Column(
                children: [
                  Align(
                      alignment: Alignment.centerLeft,
                      child: ItemLabelText(text: "Change Manually",style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),)),
                  SizedBox(height: 15,),
                  MyTextField(
                    labelText: "",
                    hintText: "House/Flat Number",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    //onChange: _bloc!.name.add,
                  ),
                  SizedBox(height: 15,),
                  MyTextField(
                    labelText: "",
                    hintText: "Street/Area",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    //onChange: _bloc!.email.add,
                  ),
                  SizedBox(height: 15,),
                  StreamBuilder<String>(
                    stream: _bloc!.city,
                    builder: (context, snap) {
                      return CustomDropdown(
                          hint: 'Choose City',
                          buttonWidth: 500,
                          buttonHeight: 50,
                          value: snap.data,
                          dropdownItems: ['Hyderabad','Vizag'],
                          onChanged:(value)=> _bloc!.addCity.add(value!));
                    }
                  ),
                  SizedBox(height: 15,),
                  MyTextField(
                    labelText: "",
                    hintText: "PIN Code",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    //onChange: _bloc!.email.add,
                  ),
                  SizedBox(height: 15,),
                  MyTextField(
                    labelText: "",
                    hintText: "Land mark",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    //onChange: _bloc!.email.add,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  Row(

                    children: [
                      Expanded(
                        flex: 4,
                        child: customButton(() {

                          Navigator.pop(context);


                        }, ItemLabelText(text:'Cancel',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#C4C4C4','#ffffff',context),
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        flex: 4,
                        child: customButton(() {

                          Navigator.pop(context);


                        }, ItemLabelText(text:'Done',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                      ),

                    ],
                  )
                ],
              );
            }
          ),
        ),
      ),
      child: StreamBuilder<Tuple2<LatLng ,List<Marker>>>(
          initialData: Tuple2(LatLng(0.0,0.0),[]),
        stream: _bloc!.data,
        builder: (context, s) {

            updateCamera(s.data!.item1);


          return (s.data!.item1.latitude>0.0)?GoogleMap(
            markers: Set<Marker>.of(s.data!.item2),
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: s.data!.item1,
              zoom: 14.4746,
            ),
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);

            },
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