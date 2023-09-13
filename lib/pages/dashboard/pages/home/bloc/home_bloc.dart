

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/address_data/address_data.dart';
import 'package:byme_app/model/dashboard/service_list.dart';
import 'package:byme_app/repositories/dashboard/dashboard_api.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:byme_app/repositories/profile/Profile_api.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../common/utilities/logger.dart';
import '../../../../../common/utils/pyc_colors.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/dashboard/menu.dart';
import '../../../../../model/signup/user_data.dart';

enum Permission{
  denied,granted
}
typedef BlocProvider<HomeBloc> HomeFactory();
class HomeBloc extends BlocBase{
  UserDataStore? userDataStore;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<bool> _isOnline =BehaviorSubject.seeded(true);
  final BehaviorSubject<bool> _isService =BehaviorSubject.seeded(false);
  final BehaviorSubject<List<Menu>> _menuList =BehaviorSubject.seeded([]);
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
  BehaviorSubject<AddressData> _addressData =BehaviorSubject();
  BehaviorSubject<void>  _submit = BehaviorSubject();
  Sink<void> get submit => _submit;
  Stream<AddressData> get addressData => _addressData;
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

  Sink<String> get addInstruction=> _instruction;
  Sink<String> get addWorkDes=> _workDes;
  Sink<String> get addDateTime => _dateTime;
  Stream<String> get dateTime => _dateTime;
  Stream<bool> get valid => _valid;

  List<ServicesList> serviceList=[];

  HomeBloc(this.userDataStore){
    setListeners();
    requestLocationPermission();
  }

  void setListeners() async{

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
      if(val.error==null){
        if(val.data!['message']!=null){
          Get.snackbar('Success',
            val.data!['message'],
            colorText: Colors.white,
            backgroundColor: ByMeColors.app_color,
            icon: const Icon(Icons.verified_outlined,color: Colors.white,),
          );
          Get.to(AppInjector.instance.cartPage);
        }
      }

    }
    );

  }



  void requestLocationPermission() async{
    UserData? user= await userDataStore!.getUser();
    Location location =  Location();
    late PermissionStatus _permissionStatus;
    bool _serviceEnabled;
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
    _isLoading.add(true);
    ProfileService().getAddressCheck({
      "environment" : EndPoints.env,
      "user_id_value" : user!.userId,
      "latitude": _locationData.latitude,
      "longitude":_locationData.longitude
    }).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        _addressData.add(value.data!);
      }

    });

    printLog("lang ", _locationData.longitude);
  }
}