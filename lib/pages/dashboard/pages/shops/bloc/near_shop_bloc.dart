
import 'package:byme_app/model/address_data/address_data.dart';
import 'package:byme_app/repositories/shop/shop_api.dart';
import 'package:flutter/cupertino.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../common/utilities/logger.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/dashboard/menu.dart';
import '../../../../../model/shop/shop_list_deatils.dart';
import '../../../../../repositories/end_point/end_point.dart';


typedef BlocProvider<NearShopsBloc> NearShopFactory(AddressData? address);
class NearShopsBloc extends BlocBase{
  UserDataStore? userDataStore;
  AddressData? address;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<List<Menu>> _shopCategories =BehaviorSubject.seeded([]);
  Stream<List<Menu>> get shopCategories => _shopCategories;
  final BehaviorSubject<List<ShopListDetails>> _shopList =BehaviorSubject();
  Stream<List<ShopListDetails>> get shopList => _shopList;
  Stream<bool> get isLoading=> _isLoading;

  NearShopsBloc(this.userDataStore,this.address){
    setListeners();
    requestLocationPermission();
  }

  void setListeners() {
    List<Menu> categoryList=[
      Menu(icon: 'assets/images/kg.svg',title: 'Kirana & General stores',tag: 'KG'),
      Menu(icon: 'assets/images/ph.svg',title: 'Pharmacy',tag: 'PH'),
      Menu(icon: 'assets/images/lab.svg',title: 'Lab Tests',tag: 'LT'),
      Menu(icon: 'assets/images/meat.svg',title: 'Meat & Eggs',tag: 'ME'),
      Menu(icon: 'assets/images/fv.svg',title: 'Fruits & Vegetables',tag: 'FV'),
      Menu(icon: 'assets/images/fb.svg',title: 'Food & Beverages',tag: 'FB'),
      Menu(icon: 'assets/images/auto.svg',title: 'Hardware',tag: 'HW'),
      Menu(icon: 'assets/images/milk.svg',title: 'Milk & Dairy',tag: 'MD'),
      Menu(icon: 'assets/images/liquor.svg',title: 'Liquor Store',tag: 'LQ'),
    ];
    _shopCategories.add(categoryList);

  }
  void requestLocationPermission() async{
    _isLoading.add(true);
    Location location =  Location();
    bool _serviceEnabled;
    LocationData _locationData;
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _locationData = await location.getLocation();
    GetAddressFromLatLong(LatLng(_locationData.latitude!, _locationData.longitude!));


    printLog("lang ", _locationData.longitude);
  }

  void GetAddressFromLatLong(LatLng position) async {
    await placemarkFromCoordinates(position.latitude, position.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];
      String _currentAddress =
          '${place.street}, ${place.subLocality},${place.locality},${place.administrativeArea} ,${place.country},${place.postalCode}';
      ShopService().getNearShopList({
        "environment" : EndPoints.env,
        // "city_name":place.locality,
        // "latitude": position.latitude,
        // "longitude":position.longitude
        "city_name":"Karimnagar",
        "latitude": 17.4134871,
        "longitude":78.3012398
      }).then((value) {
        _isLoading.add(false);
        if(value.data!=null){
          if(value.data!.shopsListDistance!.shopsList!=null){
            _shopList.add(value.data!.shopsListDistance!.shopsList!);
         }

        }

      });
    }).catchError((e) {
      debugPrint(e);
    });
  }

}