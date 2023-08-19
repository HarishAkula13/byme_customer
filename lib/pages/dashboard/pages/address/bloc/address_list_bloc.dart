

import 'dart:typed_data';

import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tuple/tuple.dart';
import 'dart:ui' as ui;

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/signup/user_data.dart';


typedef BlocProvider<AddressListBloc> AddressListFactory();
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


  AddressListBloc(this.userDataStore){

    setListeners();
    getLocation();
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
        if(value.data!.savedAddresses!=null){
          _addressList.add(value.data!.savedAddresses);
        }

      }

    });

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