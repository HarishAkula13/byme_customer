import 'dart:async';
import 'package:byme_app/common/button/byme_outline_button.dart';
import 'package:byme_app/common/dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
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
import '../../../../common/validators/validators.dart';
import '../../../../repositories/end_point/end_point.dart';
import 'bloc/change_address_bloc.dart';


class ChangeAddressPage extends StatefulWidget{
  const ChangeAddressPage({super.key});

  @override
  ChangeAddressPageState createState()=> ChangeAddressPageState();
}
class ChangeAddressPageState extends State<ChangeAddressPage>{

  ChangeAddressBloc? _bloc;
  final Completer<GoogleMapController> _controller =
  Completer<GoogleMapController>();
  TextEditingController houseNumber= TextEditingController();
  TextEditingController pinCode= TextEditingController();
  TextEditingController street= TextEditingController();
  TextEditingController landmark= TextEditingController();
  TextEditingController addressType= TextEditingController();

  @override
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
          child:
          StreamBuilder<bool>(
            initialData: false,
            stream: _bloc!.isChange,
            builder: (context, san) {
              return (san.data==false)?Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ItemLabelText(text: "Select location",style: const TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),),
                  const SizedBox(height: 10,),
                  Column(
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
                          Expanded(flex: 2,
                          child: GestureDetector(
                              onTap:(){
                          _bloc!.addIsChange.add(true);
                          },
                              child: ItemLabelText(text: 'CHANGE',style:  TextStyle(fontSize: 14,color: ByMeColors.app_color,fontFamily: Inter.regular,fontWeight: FontWeight.w500),)),)

                            ],
                          );
                        }
                      ),



                    ],
                  ),
                  const SizedBox(height: 20,),
                  Divider(color: HexColor('#CDD0CF'),thickness: 0.5,),
                  const SizedBox(height: 10,),
                  ItemLabelText(text: "Your Location",style: TextStyle(fontSize: 13,color: HexColor('#858E8B'),fontFamily: Inter.regular,fontWeight: FontWeight.w400),),
                  const SizedBox(height: 10,),
                  Row(
                    children: [
                      SizedBox(
                        width: 72,
                        height: 40,
                        child: customOutlineButton(() {
                          _bloc!.addAddress('Home');

                        }, ItemLabelText(text:'Home',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),'#00B05A','#ffffff',context),
                      ),
                      const SizedBox(width: 5,),
                      SizedBox(
                        width: 72,
                        height: 40,
                        child: customOutlineButton(() {
                          _bloc!.addAddress('Office');

                        }, ItemLabelText(text:'Office',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),'#00B05A','#ffffff',context),
                      ),
                      const SizedBox(width: 5,),
                      SizedBox(
                        width: 100,
                        height: 40,
                        child: customOutlineButton(() {
                            _bloc!.addIsChange.add(true);
                        }, Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            Icon(Icons.edit_outlined,color: HexColor('#B6B6B6'),size: 16,),
                            const SizedBox(width: 5,),
                            ItemLabelText(text:'Custom',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
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
                      child: ItemLabelText(text: "Change Manually",style: const TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w600),)),
                  const SizedBox(height: 15,),
                  MyTextField(
                    controller: houseNumber,
                    labelText: "",
                    hintText: "House/Flat Number",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validationStream: _bloc!.nameValidationMsg,
                    //onChange: _bloc!.name.add,
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    controller: street,
                    labelText: "",
                    hintText: "Street/Area",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validationStream: _bloc!.streetValidationMsg,
                    //onChange: _bloc!.email.add,
                  ),
                 /* StreamBuilder<String>(
                      stream: _bloc!.city,
                      builder: (context, snapshot) {
                        return CustomDropdown(
                          hint: 'Choose City',
                          dropdownItems: _bloc!.cities,
                          buttonWidth: 500,
                          buttonHeight: 50,
                          value: snapshot.data,
                          onChanged: (value) {
                            _bloc!.addCity.add(value!);
                          },
                        );
                      }
                  ),*/
                 /* StreamBuilder<String>(
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
                  ),*/
                  const SizedBox(height: 15,),
                  MyTextField(
                    controller: pinCode,
                    labelText: "",
                    hintText: "PIN Code",
                    charactersLimit: 6,
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.number,
                    validationStream: _bloc!.pincodeValidationMsg,
                    //onChange: _bloc!.email.add,
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    controller: landmark,
                    labelText: "",
                    hintText: "Land mark",
                    inputAction: TextInputAction.next,
                    keyboardType: TextInputType.text,
                    validationStream: _bloc!.landMarkValidationMsg,
                    //onChange: _bloc!.email.add,
                  ),
                  const SizedBox(height: 15,),
                  MyTextField(
                    controller: addressType,
                    labelText: "",
                    hintText: "Address Title",
                    inputAction: TextInputAction.done,
                    keyboardType: TextInputType.text,
                    validationStream: _bloc!.titleValidationMsg,
                    //onChange: _bloc!.email.add,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.15,),
                  Row(

                    children: [
                      Expanded(
                        flex: 4,
                        child: customButton(() {

                          Navigator.pop(context);


                        }, ItemLabelText(text:'Cancel',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#C4C4C4','#ffffff',context),
                      ),
                      const SizedBox(width: 20,),
                      Expanded(
                        flex: 4,
                        child: customButton(() {
                          if(street.text.isNotEmpty&&landmark.text.isNotEmpty&&pinCode.text.isNotEmpty&&addressType.text.isNotEmpty&&houseNumber.text.isNotEmpty&&addressType.text.isNotEmpty){
                            var map={
                              "environment": EndPoints.env,
                              "house": houseNumber.text,
                              "area_name": street.text,
                              "landmark": landmark.text,
                              "pin_code": pinCode.text,
                              "address_title": addressType.text,
                            };
                            _bloc!.saveManualAddress(map,context);
                          }else{
                            _bloc!.addNameValidationMsg.add(FormValidator().validateField(houseNumber.text)!);
                            _bloc!.addStreetValidationMsg.add(FormValidator().validateField(street.text)!);
                            _bloc!.addPincodeValidationMsg.add(FormValidator().isValidPIN(pinCode.text)!);
                            _bloc!.addLandMarkValidationMsg.add(FormValidator().validateField(landmark.text)!);
                            _bloc!.addTitleValidationMsg.add(FormValidator().validateField(addressType.text)!);



                          }

                         // Navigator.pop(context);


                        }, ItemLabelText(text:'Done',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
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
                  top: 30,
                  left: 10,
                  child: GestureDetector(
                      onTap: (){
                        Navigator.pop(context);
                      },
                      child: SvgPicture.asset('assets/images/arrow_back.svg'))),
            ],
          ):const SizedBox();
        }
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



}