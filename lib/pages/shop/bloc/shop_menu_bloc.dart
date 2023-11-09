

import 'package:byme_app/model/signup/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../common/utilities/byme_colors.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../model/shop/shop_list_deatils.dart';
import '../../../model/shop/shop_menu.dart';
import '../../../repositories/end_point/end_point.dart';
import '../../../repositories/shop/shop_api.dart';


typedef ShopMenuFactory = BlocProvider<ShopMenuBloc> Function(ShopListDetails? shopDetails);
class ShopMenuBloc extends BlocBase{
  UserDataStore? userDataStore;
  ShopListDetails? shopDetails;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<int> _cartQty =BehaviorSubject.seeded(1);
  final BehaviorSubject<List<ShopMenu>> _isShopMenu =BehaviorSubject.seeded([]);
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get cartQty=> _cartQty;
  Sink<int> get addCartQty=> _cartQty;
  Stream<List<ShopMenu>> get isShopMenu=> _isShopMenu;
  Sink<List<ShopMenu>> get addIsShopMenu=> _isShopMenu;
  String? menu_id='';
  List<ShopMenu>? menuList=[];
  ShopMenuBloc(this.userDataStore,this.shopDetails){
    setListeners();

  }

  void setListeners() {
    _isLoading.add(true);
    ShopService().getShopMenu({
      "environment" : EndPoints.env,
      "shop_id":shopDetails!.shopId,
    }).then((value) {
      _isLoading.add(false);
      if(value.data!=null){
     if(value.data!.shopMenu!.productInfo!=null){
       menu_id=value.data!.shopMenu!.menuId;
       menuList=value.data!.shopMenu!.productInfo!;
       _isShopMenu.add(value.data!.shopMenu!.productInfo!);
     }else {
       _isShopMenu.add([]);
     }

      }else{
        _isShopMenu.add([]);
      }

    });
  }

  addCart(String? qty,String? itemId) async{
    UserData? user=await userDataStore!.getUser();
    _isLoading.add(true);
    ShopService().addShopItem({
      "environment" : EndPoints.env,
      "user_id": user!.userId,
      "menu_id": menu_id,
      "product_info": {
        itemId: qty,
      }
    }).then((value) {
      _isLoading.add(false);
      if(value.data!=null){
        if(value.data!.cart!=null){
          Get.snackbar('Success',
            value.data!.cart!,
            colorText: Colors.white,
            backgroundColor: ByMeColors.app_color,
            icon: const Icon(Icons.verified_outlined,color: Colors.white,),
          );
          for(int i=0;i<menuList!.length;i++){
            if(menuList![i].productId==itemId){
              menuList![i].cartQty=int.parse(qty!);
              break;
            }

          }

          _isShopMenu.add(menuList!);
        }else {

        }

      }

    });
  }
}
