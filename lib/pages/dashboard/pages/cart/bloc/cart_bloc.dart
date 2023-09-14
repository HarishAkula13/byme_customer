import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/address_data/address_data.dart';
import 'package:byme_app/model/order_list/cart_list.dart';
import 'package:byme_app/model/signup/user_data.dart';
import 'package:byme_app/repositories/cart/cart_api.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../common/utilities/byme_colors.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../repositories/profile/Profile_api.dart';
import '../../home/bloc/home_bloc.dart';

typedef BlocProvider<CartBloc> CartFactory();
class CartBloc extends BlocBase {
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _price = BehaviorSubject.seeded('');
  BehaviorSubject<String> _cartPriceInfo = BehaviorSubject.seeded('');
  BehaviorSubject<String> _cartListInfo = BehaviorSubject.seeded('');
  BehaviorSubject<AddressData> _addressDataInfo = BehaviorSubject();
  BehaviorSubject<List<CartList>> _cartList = BehaviorSubject.seeded([]);
  BehaviorSubject<CartList> _cartPricesInfo=BehaviorSubject();
  final BehaviorSubject<bool> _valid=BehaviorSubject.seeded(true);
  BehaviorSubject<void>  _submit = BehaviorSubject();
  Stream<CartList> get cartPricesInfo=> _cartPricesInfo;
  Stream<String> get cartPrice=> _price;
  Stream<AddressData> get addressDataInfo=> _addressDataInfo;
  Stream<String> get cartPriceInfo=> _cartPriceInfo;
  Stream<String> get cartListInfo=> _cartListInfo;
  Stream<List<CartList>> get cartList=> _cartList;
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get valid => _valid;
  Sink<void> get submit => _submit;

  CartBloc(this.userDataStore){
    setListeners();


  }

  void setListeners() async{
    UserData? user= await userDataStore!.getUser();

    CombineLatestStream.combine3(_cartList, _cartPricesInfo,_addressDataInfo,
            (List<CartList> a, CartList b,AddressData c){
          return b!=null;

        })
        .listen(_valid.add)
        .addTo(disposeBag);

    _submit
        .withLatestFrom(_valid, (_, bool v) {
          printLog("_valid", v);
          return v;
    })
        .where((event)=>event)
        .withLatestFrom3(_cartList, _cartPricesInfo,_addressDataInfo,
            (t,List<CartList> a, CartList b,AddressData c)
        {
          printLog("Cart length", a.length);
          return {
            "environment": EndPoints.env,
            "user_id": user!.userId,
            "address_title": c.addressTitle,
            "order_list": [
              {
                "${a[0].serviceId}": "1"
              }
            ],
            "total_amount": b.baseCharges ?? 0.0,
            "tax": b.GST ?? 0.0,
            "overall_discount": 0.0,
            "final_amount": b.total ?? 0.0,
            "latitude": c.latitude,
            "longitude": c.longitude,
            "description_of_work": a[0].descriptionOfWork,
            "additional_instructions": a[0].additionalInstructions,
            "service_id": a[0].serviceId

          };})
        .listen(navigatePayment)
        .addTo(disposeBag);
    getCartList();
    requestLocationPermission();
  }

  void getCartList() async{
    _isLoading.add(true);
    UserData? user=await userDataStore!.getUser();
    CartService().getCartList({
      "environment": EndPoints.env,
      "user_id": user!.userId
    }).then((value) {
      _isLoading.add(false);
      if(value.error==null){

        if(value.data!.fetchCart!=null){
          _price.add(value.data!.servicePrice!.toString() ?? '');
          _cartList.add(value.data!.fetchCart!);
          printLog("_valid", value.data!.fetchCart!.length);
          if(value.data!.fetchCart!.isNotEmpty){
            _isLoading.add(true);
            CartService().getPriceSchedule({
              "environment": EndPoints.env,
              "service_id": value.data!.fetchCart![0].serviceId
            }).then((value) {
              _isLoading.add(false);
              if(value.error==null){
                _cartPricesInfo.add(value.data!);
              }
            });
          }

        }
        else {
          _cartList.add([]);
        }
      }
    });


  }
  void requestLocationPermission() async{
    UserData? user= await userDataStore!.getUser();
    Location location =  Location();
    late PermissionStatus _permissionStatus;
    bool _serviceEnabled;
    LocationData locationData;
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
    locationData = await location.getLocation();
    _isLoading.add(true);
    ProfileService().getAddressCheck({
      "environment" : EndPoints.env,
      "user_id_value" : user!.userId,
      "latitude": locationData.latitude,
      "longitude":locationData.longitude
    }).then((value) {
      _isLoading.add(true);
      if(value.error==null){
        _isLoading.add(false);
        _addressDataInfo.add(value.data!);

      }

    });
  }
  void removeCart(CartList cartList) async{
    UserData? user=await userDataStore!.getUser();
    _isLoading.add(true);
    CartService().removeCart({
      "environment": EndPoints.env,
      "user_id": user!.userId,
      "product_info":cartList.productId
    }).then((val) {
      _isLoading.add(false);
      if(val.error==null){
        if(val.data!['message']!=null){
          Get.snackbar('Success',
            val.data!['message'],
            colorText: Colors.white,
            backgroundColor: ByMeColors.app_color,
            icon: const Icon(Icons.verified_outlined,color: Colors.white,),
          );
          getCartList();
        }
      }

    }
    );

  }

  void navigatePayment(Map<String,dynamic> data){


    printLog('title', 'message');
    Get.to(AppInjector.instance.paymentMethodPage(data));

  }

}