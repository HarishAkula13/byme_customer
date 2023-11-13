import 'dart:convert';

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

typedef BlocProvider<CartBloc> CartFactory(AddressData? addressData);
class CartBloc extends BlocBase {
  UserDataStore? userDataStore;
  AddressData? addressData;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  BehaviorSubject<String> _price = BehaviorSubject.seeded('');
  BehaviorSubject<AddressData> _addressDataInfo = BehaviorSubject();
  BehaviorSubject<List<CartList>> _cartList = BehaviorSubject.seeded([]);
  BehaviorSubject<CartList> _cartPricesInfo=BehaviorSubject();
  final BehaviorSubject<bool> _valid=BehaviorSubject.seeded(true);
  BehaviorSubject<void>  _submit = BehaviorSubject();
  Stream<CartList> get cartPricesInfo=> _cartPricesInfo;
  Stream<String> get cartPrice=> _price;
  Stream<AddressData> get addressDataInfo=> _addressDataInfo;
  Stream<List<CartList>> get cartList=> _cartList;
  Stream<bool> get isLoading=> _isLoading;
  Stream<bool> get valid => _valid;
  Sink<void> get submit => _submit;
  bool isShop=false;
  CartList? cartData;
  CartBloc(this.userDataStore,this.addressData){
    setListeners();


  }

  void setListeners() async{
    UserData? user= await userDataStore!.getUser();

    CombineLatestStream.combine2(_cartList, _cartPricesInfo,
            (List<CartList> a, CartList b){
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
        .withLatestFrom2(_cartList, _cartPricesInfo,
            (t,List<CartList> a, CartList b,)
        {
          Map<String,dynamic> data={};
          List<Map<String,dynamic>> listData=[];
          printLog("Cart length", a.length);
          if(isShop){
            if(a.isNotEmpty){
              for(int i=0;i<a.length;i++){
                Map<String,dynamic> mapData={
                  "product_name": a[i].productName,
                  "qty":  a[i].qty,
                  "unit":  a[i].unit,
                  "amount":  a[i].amount};
                listData.add(mapData);
                Map<String,dynamic> map={a[i].productId!:a[i].qty};
                data.addAll(map);
              }

            }
          }

          return isShop?{
            "environment": EndPoints.env,
            "user_id": user!.userId,
            "address_title": addressData!.addressTitle,
            "order_list": listData,
            "products_list":data,
            "total_amount": b.totalAmount ?? 0.0,
            "tax": b.tax ?? 0.0,
            "overall_discount": b.overallDiscount ?? 0.0,
            "final_amount": b.finalAmount ?? 0.0,
            "latitude": addressData!.latitude,
            "longitude":addressData!.longitude,
            "shop_latitude": b.shopLatitude,
            "shop_longitude":  b.shopLongitude,
            "shop_id": cartData!.shopId,
           "delivery_charges":b.deliveryCharges ?? 0.0

          }:{
            "environment": EndPoints.env,
            "user_id": user!.userId,
            "address_title": addressData!.addressTitle,
            "order_list": [
              {
                "${a[0].serviceId}": "1"
              }
            ],
            "total_amount": b.baseCharges ?? 0.0,
            "tax": b.gst ?? 0.0,
            "overall_discount": 0.0,
            "final_amount": b.total ?? 0.0,
            "latitude": addressData!.latitude,
            "longitude":addressData!.longitude,
            "description_of_work": a[0].descriptionOfWork,
            "additional_instructions": a[0].additionalInstructions,
            "service_id": a[0].serviceId

          };

        })
        .listen(navigatePayment)
        .addTo(disposeBag);
    getCartList();
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
        cartData=value.data!;
        if(value.data!.fetchCart!=null){
          isShop=false;
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

        }else if(value.data!.userCart!=null){
          isShop=true;
         // _price.add((value.data!.servicePrice!=null)?value.data!.servicePrice!.toString() ?? '':'');
          _cartList.add(value.data!.userCart!);
          if(value.data!.userCart!.isNotEmpty){
            _isLoading.add(true);
            Map<String,dynamic> data={};
            if(value.data!.userCart!.isNotEmpty){
              for(int i=0;i<value.data!.userCart!.length;i++){
                Map<String,dynamic> map={value.data!.userCart![i].productId!:value.data!.userCart![i].qty!};
                data.addAll(map);
              }

            }
            CartService().getShopPriceSchedule({
              "environment": EndPoints.env,
              "shop_id": value.data!.shopId,
              "shop_menu": value.data!.menuId,
              "user_id":  user.userId,
              "address_title": addressData!.addressTitle,
              "products_list": data,
              "latitude": addressData!.latitude,
              "longitude": addressData!.longitude
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
      }else{
        _cartList.add([]);
      }
    });


  }
  void removeCart(CartList cartList) async{
    UserData? user=await userDataStore!.getUser();
    _isLoading.add(true);
    (isShop)? CartService().shopRemoveCartItem({
      "environment": EndPoints.env,
      "user_id": user!.userId,
      "menu_id":cartData!.menuId,
      "product_info": {
        cartList.productId: cartList.qty
      }
    }).then((val) {
      _isLoading.add(false);
      if(val.error==null){
        if(val.data!['cart']!=null){
          Get.snackbar('Success',
            val.data!['cart'],
            colorText: Colors.white,
            backgroundColor: ByMeColors.app_color,
            icon: const Icon(Icons.verified_outlined,color: Colors.white,),
          );
          getCartList();
        }
      }

    }
    ):
    CartService().removeCart({
      "environment": EndPoints.env,
      "user_id": user!.userId,
      "product_info":cartList.serviceId
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
    Get.to(AppInjector.instance.paymentMethodPage(data,addressData,isShop));

  }

}