import 'package:byme_app/model/order_list/cart_list.dart';
import 'package:byme_app/model/signup/user_data.dart';
import 'package:byme_app/repositories/cart/cart_api.dart';
import 'package:byme_app/repositories/end_point/end_point.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../common/utilities/byme_colors.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';

typedef BlocProvider<CartBloc> CartFactory();
class CartBloc extends BlocBase {
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading = BehaviorSubject.seeded(false);
  BehaviorSubject<List<CartList>> _cartList = BehaviorSubject.seeded([]);
  Stream<List<CartList>> get cartList=> _cartList;
  Stream<bool> get isLoading=> _isLoading;
  CartBloc(this.userDataStore){
    setListeners();
    getCartList();
  }

  void setListeners() {
    

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
          _cartList.add(value.data!.fetchCart!);
        }
        else {
          _cartList.add([]);
        }
      }
    });
    
  }
  void removeCart(CartList cartList) async{
    UserData? user=await userDataStore!.getUser();
    _isLoading.add(true);
    CartService().removeCart({
      "environment": EndPoints.env,
      "user_id": user!.userId,
      "product_info":cartList.category
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

}