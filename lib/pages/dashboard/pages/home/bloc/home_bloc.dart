

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/di/i_login_page.dart';
import 'package:byme_app/model/dashboard/service_list.dart';
import 'package:byme_app/repositories/dashboard/dashboard_api.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geocoding/geocoding.dart' hide Location;
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/fonts/fonts.dart';
import '../../../../../common/label/item_label_text.dart';
import '../../../../../common/utilities/logger.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/address_data/address_data.dart';
import '../../../../../model/dashboard/menu.dart';
import '../../../../../model/shop/shop_list_deatils.dart';
import '../../../../../model/signup/user_data.dart';
import '../../../../../repositories/shop/shop_api.dart';

enum Permission{
  denied,granted
}
typedef BlocProvider<HomeBloc> HomeFactory(AddressData? address);
class HomeBloc extends BlocBase{
  UserDataStore? userDataStore;
  AddressData? address;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _isOnline =BehaviorSubject.seeded(true);
  final BehaviorSubject<bool> _isService =BehaviorSubject.seeded(false);
  final BehaviorSubject<List<Menu>> _menuList =BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Menu>> _shopCategories =BehaviorSubject.seeded([]);
  final BehaviorSubject<String> _categorieName =BehaviorSubject.seeded('');
  final BehaviorSubject<String> _selectedName =BehaviorSubject.seeded('Construction Works');
  final BehaviorSubject<String> _travelType =BehaviorSubject.seeded('Taxi & Travel');
  final BehaviorSubject<String> _taxiType =BehaviorSubject.seeded('Bike Taxi');
  final BehaviorSubject<String> _subCate =BehaviorSubject();
  final BehaviorSubject<String> _serviceType =BehaviorSubject.seeded('Pilot Service');
  final BehaviorSubject<String> _workDes = BehaviorSubject();
  final BehaviorSubject<String> _instruction = BehaviorSubject();
  final BehaviorSubject<String> _dateTime = BehaviorSubject.seeded(DateFormat("dd MMMM yyyy").format(DateTime.now()));
  final BehaviorSubject<String> _userName = BehaviorSubject();
   Stream<String> get userName => _userName;
  final BehaviorSubject<bool> _valid=BehaviorSubject.seeded(false);
  final BehaviorSubject<List<ServicesList>> _serviceList=BehaviorSubject.seeded([]);
  final BehaviorSubject<List<Subcategory>> _subcategoryList=BehaviorSubject.seeded([]);
  Sink<List<Subcategory>> get addSubcategoryList=>_subcategoryList;
  Stream<List<Subcategory>> get subcategoryList=>_subcategoryList;
  BehaviorSubject<String> _addressData =BehaviorSubject.seeded('');
  BehaviorSubject<void>  _submit = BehaviorSubject();
  Sink<void> get submit => _submit;
  Stream<String> get addressData => _addressData;
  Sink<List<ServicesList>> get addServiceList=>_serviceList;
  Stream<List<ServicesList>> get serviceListData=>_serviceList;
  Stream<String> get serviceType => _serviceType;
  Sink<String> get addServiceType => _serviceType;
  Stream<String> get subCate => _subCate;
  Sink<String> get addSubCate => _subCate;
  Stream<String> get travelType => _travelType;
  Sink<String> get addTravelType => _travelType;
  Stream<String> get taxiType => _taxiType;
  Sink<String> get addTaxiType => _taxiType;
  Stream<String> get selectedName => _selectedName;
  Sink<String> get addSelectedName => _selectedName;
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get isOnline=> _isOnline;
  Sink<bool> get addIsOnline=> _isOnline;
  Stream<bool> get isService=> _isService;
  Sink<bool> get addIsService=> _isService;
  Stream<String> get categorieName=> _categorieName;
  Sink<String> get addCategorieName=> _categorieName;
  Stream<List<Menu>> get menuList=> _menuList;
  Stream<List<Menu>> get shopCategories => _shopCategories;
  Sink<String> get addInstruction=> _instruction;
  Sink<String> get addWorkDes=> _workDes;
  Sink<String> get addDateTime => _dateTime;
  Stream<String> get dateTime => _dateTime;
  Stream<bool> get valid => _valid;
  final BehaviorSubject<List<ShopListDetails>> _shopList =BehaviorSubject();
  Stream<List<ShopListDetails>> get shopList => _shopList;
  List<ServicesList> serviceList=[];

  HomeBloc(this.userDataStore,this.address){
    setListeners();
    requestLocationPermission();
    getData(false);
  }

  void setListeners() async{



    UserData? user= await userDataStore!.getUser();
    _userName.add(user!.fullName!);


    CombineLatestStream.combine6(_selectedName, _subCate,_serviceType,_workDes,_instruction,_categorieName,
            (String a, String b,String c,String d,String e,String f)
        {
          return a.isNotEmpty&&b.isNotEmpty&&c.isNotEmpty&&d.isNotEmpty&&e.isNotEmpty;})
        .listen(_valid.add)
        .addTo(disposeBag);


    _submit
        .withLatestFrom(_valid, (_, bool v) => v)
        .where((event)=>event)
        .withLatestFrom7(_selectedName, _subCate,_serviceType,_workDes,_instruction,_categorieName,_dateTime,
            (t,String a, String b,String c,String d,String e,String f,String g)
        {

          return {
            "environment": EndPoints.env,
            "user_id": user.userId,
            "service_name": b,
            "category": f.replaceAll("\n", ''),
            "sub_category": a,
            "service_type": (c=='Firm Service')?'firm':'pilot',
            "date": g,
            "additional_instructions": e,
            "description_of_work": d
          };})
        .listen(addCart)
        .addTo(disposeBag);


  }

  void addCart(Map<String,dynamic> data){
    _isLoading.add(true);
    DashboardService().addCart(data).then((val) {
      _isLoading.add(false);
      if(val.error==null){
        if(val.data!["status"]!=null){
          if(val.data!["status"]==3){
            showAlertDialog(val.data!['key'],data);


          }

        }else{
          if(val.data!['message']!=null){
            Get.snackbar('Success',
              val.data!['message'],
              colorText: Colors.white,
              backgroundColor: ByMeColors.app_color,
              icon: const Icon(Icons.verified_outlined,color: Colors.white,),
            );
            Get.to(AppInjector.instance.dashboardPage(2,address));
          }
        }

      }

    }
    );

  }

  void getData(bool isValue){
    if(isValue){
      _isLoading.add(true);

      List<Menu> list=[
        Menu(icon: 'assets/images/house.svg',title: 'Household \nChores'),
        Menu(icon: 'assets/images/personal.svg',title: 'Personal \nCare'),
        Menu(icon: 'assets/images/event.svg',title: 'Event \nnManagement'),
        Menu(icon: 'assets/images/Construction.svg',title: 'Construction \nWorks'),
        Menu(icon: 'assets/images/auto.svg',title: 'Automobile \nRepairs'),
        Menu(icon: 'assets/images/electronics.svg',title: 'Electronics \nRepairs'),
        Menu(icon: 'assets/images/taxi.svg',title: 'Taxi & Travel'),
        Menu(icon: 'assets/images/tutor.svg',title: 'Tutor'),
        Menu(icon: 'assets/images/medical.svg',title: 'Medical'),
      ];
      _menuList.add(list);


      DashboardService().getService({
        "environment": EndPoints.env,
        "hash": "4f199925662bc27b8196fc18428f8e3434a"
      }).then((val) {
        _isLoading.add(false);
        Map keyData=val.data!['key'];
        keyData.forEach((service, serviceData) {
          List<Category> categoryList=[];
          serviceData.forEach((categoryName,subCategoryList){
            List  list=subCategoryList as List<dynamic>;
            List<Subcategory>? subCategory=[];
            for(int i=0;i<list.length;i++){
              subCategory.add(Subcategory(serviceName: list[i]['service_name'],serviceId: list[i]['service_id'],serviceType: list[i]['service_type'],status: list[i]['status']));
            }

            categoryList.add(Category(categoryName: categoryName,subCategory: subCategory,isClick: false));
          });
          serviceList.add(ServicesList(serviceName: service,category: categoryList));
          _serviceList.add(serviceList);
        });

      });
    }else{

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
      GetAddressFromLatLong(LatLng(address!.latitude!, address!.longitude!));
    }

  }

  void requestLocationPermission() async{
    _isLoading.add(true);
    UserData? user= await userDataStore!.getUser();
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
   // GetAddressFromLatLong(LatLng(_locationData.latitude!, _locationData.longitude!));




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
         "city_name":place.locality,
         "latitude": position.latitude,
         "longitude":position.longitude
        /*"city_name":"Karimnagar",
        "latitude": 17.4134871,
        "longitude":78.3012398*/
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

  showAlertDialog(String msg,Map<String,dynamic> data) {
    return showDialog<void>(
      context: Get.context!,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                ItemLabelText( text: msg,style: const TextStyle(fontSize: 14,fontFamily: Fonts.regular)),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: ItemLabelText( text:'Replace',style: const TextStyle(fontSize: 14,fontFamily: Fonts.regular,color: Colors.red)),
              onPressed: () {
                Navigator.of(context).pop();
                _isLoading.add(true);
                DashboardService().addOtherCart(data).then((val) {
                  _isLoading.add(false);
                  if(val.error==null){
                    if(val.data!['message']!=null){
                      Get.snackbar('Success',
                        val.data!['message'],
                        colorText: Colors.white,
                        backgroundColor: ByMeColors.app_color,
                        icon: const Icon(Icons.verified_outlined,color: Colors.white,),
                      );
                      Get.to(AppInjector.instance.dashboardPage(2,address));
                    }
                  }

                }
                );
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