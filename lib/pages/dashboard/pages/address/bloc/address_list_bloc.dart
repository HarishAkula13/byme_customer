

import 'dart:typed_data';

import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'dart:ui' as ui;
import 'package:location/location.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/signup/user_data.dart';
enum Permission{
  denied,granted
}

typedef BlocProvider<AddressListBloc> AddressListFactory(int screenType);
class AddressListBloc extends BlocBase{
  UserDataStore? userDataStore;

  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<List<dynamic>> _addressList =BehaviorSubject.seeded([]);
  BehaviorSubject<String> _address = BehaviorSubject.seeded('');
  BehaviorSubject<Tuple2<LatLng ,List<Marker>>> _data =BehaviorSubject();
  Stream<Tuple2<LatLng ,List<Marker>>> get data=> _data;
  Stream<String> get address => _address;
  LatLng _latLen = LatLng(17.4523004,78.3630278);
  Stream<bool> get isLoading=> _isLoading;
  Stream<List<dynamic>> get addressList=> _addressList;
  List<Marker> _markers = [];
  String? pincode='';
  String? cityName='';
  String? state='';
  String? landmark='';
  String? areName='';
  String? _currentAddress='';
  int screenType;
  late PermissionStatus _permissionStatus;


  AddressListBloc(this.userDataStore,this.screenType){

    setListeners();
    requestLocationPermission();
    getAddress();
  }

  void setListeners() {



  }
  getAddress() async{
    _isLoading.add(true);
    UserData? user= await userDataStore!.getUser();
    ProfileService().getAddress({
      "environment": EndPoints.env,
      "user_id_value": user!.userId
    }).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        if(value.data!.savedAddresses!=null||value.data!.savedAddresses!='empty'){
          _addressList.add(value.data!.savedAddresses! as List<dynamic>);
        }

      }

    });

  }

  void requestLocationPermission() async{

    Location location =  Location();

    bool _serviceEnabled;
    Permission _permissionGranted;
    LocationData _locationData;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }
    _permissionStatus = await location.hasPermission();
    if (_permissionStatus == Permission.denied) {
      _permissionStatus =  await location.requestPermission();
      if (_permissionStatus != Permission.granted) {
        return;
      }
    }

    _locationData = await location.getLocation();
    _latLen= LatLng(_locationData.latitude!, _locationData.longitude!);
    Uint8List markIcons = await getImages('assets/images/my_loc.png', 100);
    _markers.add(
        Marker(
          markerId: MarkerId("0"),
          icon: BitmapDescriptor.fromBytes(markIcons),
          position: LatLng(_locationData.latitude!, _locationData.longitude!),
        )
    );

    //print(address);
    _data.add(Tuple2(_latLen,_markers));
    GetAddressFromLatLong(LatLng(_locationData.latitude!, _locationData.longitude!));
  }



  Future<Uint8List> getImages(String path, int width) async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return(await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();

  }

  Future<void> GetAddressFromLatLong(LatLng position)async {
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

  void addressCheck(List<dynamic>? data) async{
    _isLoading.add(true);
    UserData? user= await userDataStore!.getUser();
    ProfileService().getAddressCheck({
      "environment" : EndPoints.env,
      "user_id_value" : user!.userId,
      "latitude": data![5],
      "longitude":data[6]
    }).then((value) {
      _isLoading.add(false);
      if(value.data!=null){

        Get.to(AppInjector.instance.dashboardPage(0,value.data!));
      }

    });
  }

}