import 'dart:typed_data';
import 'package:byme_app/common/utilities/logger.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'dart:ui' as ui;

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../common/utils/pyc_colors.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/signup/user_data.dart';
import '../../../../../repositories/end_point/end_point.dart';
import '../../../../../repositories/login/login_api.dart';
import '../../../../../repositories/profile/Profile_api.dart';

typedef BlocProvider<ChangeAddressBloc> ChangeAddressFactory();
class ChangeAddressBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<Tuple2<LatLng ,List<Marker>>> _data =BehaviorSubject();
  BehaviorSubject<String> _address = BehaviorSubject.seeded('');
  BehaviorSubject<bool> _isChange = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _city = BehaviorSubject();
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  Stream<bool> get isLoading=> _isLoading;
  Stream<String> get city => _city;
  Sink<String> get addCity  => _city;
  Sink<bool> get addIsChange  => _isChange;
  Stream<bool> get isChange => _isChange;
  Stream<Tuple2<LatLng ,List<Marker>>> get data=> _data;
  Stream<String> get address => _address;
   LatLng _latLen = LatLng(17.4523004,78.3630278);
   List<Marker> _markers = [];
   String? pincode='';
   String? cityName='';
  String? state='';
   String? landmark='';
   String? areName='';
  String? _currentAddress='';




  ChangeAddressBloc(this.loginService,this.userDataStore){

    setListeners();
    getLocation();
  }

  void setListeners() {


  }
  void addAddress(String type) async{
    if(_currentAddress!.isNotEmpty){
      _isLoading.add(true);
      UserData? user= await userDataStore!.getUser();
      ProfileService().saveAddress({
        "environment": EndPoints.env,
        "address": _currentAddress,
        "user_id_value": user!.userId,
        "area_name": areName,
        "landmark": landmark,
        "city_name": cityName,
        "pin_code": pincode,
        "state": state,
        "address_title": "${user.fullName} ${type}",
        "latitude": _latLen.latitude,
        "longitude":_latLen.longitude
      }).then((value) {
        _isLoading.add(false);
        if(value.error==null){
          if(value.data!.addressId!=null){
            Get.snackbar('Success',
              "Address Saved Successfully",
              colorText: Colors.white,
              backgroundColor: PYCColors.app_color,
              icon: const Icon(Icons.verified_outlined,color: Colors.white,),
            );
          }


        }

      });
    }


  }

  Future<void> getLocation() async {

    Uint8List markIcons = await getImages('assets/images/my_loc.png', 100);
    _markers.add(Marker(
      markerId: MarkerId("0"),
      icon: BitmapDescriptor.fromBytes(markIcons),
      position: _latLen,
    ));

    _data.add(Tuple2(_latLen,_markers));
    getUserCurrentLocation().then((value) async {
      _latLen= LatLng(value.latitude, value.longitude);
      _markers.add(
          Marker(
            markerId: MarkerId("0"),
            icon: BitmapDescriptor.fromBytes(markIcons),
            position: LatLng(value.latitude, value.longitude),
          )
      );

      GetAddressFromLatLong(value);
      //print(address);
      _data.add(Tuple2(_latLen,_markers));
    });

  }
  Future<Position> getUserCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();

    if (permission == LocationPermission.denied) {
      return Future.error('Location permissions are denied');
    }


    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }
    Position position=await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
    printLog("Position", position);
    return position;
  }
  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  Future<void> GetAddressFromLatLong(Position position)async {
    await placemarkFromCoordinates(
        position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      pincode=place.postalCode;
      state=place.subAdministrativeArea;
       cityName=place.subLocality;
       landmark=place.street;
       areName=place.street;
       _currentAddress = '${place.street}, ${place.subLocality},${place.subAdministrativeArea}, ${place.postalCode}';
      _address.add(_currentAddress!);
    }).catchError((e) {
      debugPrint(e);
    });
  }
}