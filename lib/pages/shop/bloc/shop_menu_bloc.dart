

import 'package:byme_app/common/utilities/fonts.dart';
import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/address_data/address_data.dart';
import 'package:byme_app/model/signup/user_data.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:rxdart/rxdart.dart';

import '../../../app/arch/bloc_provider.dart';
import '../../../common/fonts/fonts.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/utilities/byme_colors.dart';
import '../../../di/app_injector.dart';
import '../../../manager/user_data_store/user_data_store.dart';
import '../../../model/shop/shop_list_deatils.dart';
import '../../../model/shop/shop_menu.dart';
import '../../../repositories/end_point/end_point.dart';
import '../../../repositories/shop/shop_api.dart';
import '../../dashboard/dashboard_bloc.dart';


typedef ShopMenuFactory = BlocProvider<ShopMenuBloc> Function(ShopListDetails? shopDetails, AddressData? addressData);
class ShopMenuBloc extends BlocBase{
  UserDataStore? userDataStore;
  ShopListDetails? shopDetails;
  AddressData? addressData;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<int> _cartQty =BehaviorSubject.seeded(1);
  final BehaviorSubject<List<ShopMenu>> _isShopMenu =BehaviorSubject.seeded([]);
  final BehaviorSubject<int> _selectedPos= BehaviorSubject.seeded(0);
  final BehaviorSubject<bool> _isSelectTab= BehaviorSubject.seeded(false);
  Stream<bool> get isSelectTab => _isSelectTab;
  Sink<bool> get addIsSelectTab => _isSelectTab;
  Stream<int> get selectedPos => _selectedPos;
  Sink<int> get addSelectedPos => _selectedPos;
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get cartQty=> _cartQty;
  Sink<int> get addCartQty=> _cartQty;
  Stream<List<ShopMenu>> get isShopMenu=> _isShopMenu;
  Sink<List<ShopMenu>> get addIsShopMenu=> _isShopMenu;
  List<TabBarPage> pagesList=[];
  String? menu_id='';
  List<ShopMenu>? menuList=[];
  ShopMenuBloc(this.userDataStore,this.shopDetails,this.addressData){
    setListeners();

  }

  void setListeners() async{
    printLog("shopDetails", shopDetails!.shopId);
    UserData? user=await userDataStore!.getUser();
      _selectedPos.add(1);
      pagesList=[
            ()=> AppInjector.instance.home(addressData),
            ()=> AppInjector.instance.nearShop(addressData),
            ()=> AppInjector.instance.cartPage(addressData),
            ()=> AppInjector.instance.profile((){viewOrders();},addressData),
      ];


    _isLoading.add(true);
    ShopService().getShopMenu({
      "environment" : EndPoints.env,
      "shop_id":shopDetails!.shopId,
      "user_id":user!.userId,
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
  void viewOrders(){
    pagesList.clear();
    pagesList=[
          ()=> AppInjector.instance.home(addressData),
          ()=> AppInjector.instance.nearShop(addressData),
          ()=> AppInjector.instance.cartPage(addressData),
          ()=> AppInjector.instance.ordersHistory((type,pos){
        if(type==0){
          pagesList.clear();
          pagesList=[
                ()=> AppInjector.instance.home(addressData),
                ()=> AppInjector.instance.nearShop(addressData),
                ()=> AppInjector.instance.cartPage(addressData),
                ()=> AppInjector.instance.profile((){viewOrders();},addressData),
          ];
        }else {
          pagesList.clear();
          pagesList=[
                ()=> AppInjector.instance.home(addressData),
                ()=> AppInjector.instance.nearShop(addressData),
                ()=> AppInjector.instance.cartPage(addressData),
                ()=>  AppInjector.instance.ordersHistoryDetails(pos,(type){
                  pagesList.clear();
                  pagesList=[
                    ()=> AppInjector.instance.home(addressData),
                    ()=> AppInjector.instance.nearShop(addressData),
                    ()=> AppInjector.instance.cartPage(addressData),
                    ()=> AppInjector.instance.ordersHistory((type,pos){
                  if(type==0){
                    pagesList.clear();
                    pagesList=[
                          ()=> AppInjector.instance.home(addressData),
                          ()=> AppInjector.instance.nearShop(addressData),
                          ()=> AppInjector.instance.cartPage(addressData),
                          ()=> AppInjector.instance.profile((){viewOrders();},addressData),
                    ];
                  }else {
                    pagesList.clear();
                    pagesList=[
                          ()=> AppInjector.instance.home(addressData),
                          ()=> AppInjector.instance.nearShop(addressData),
                          ()=> AppInjector.instance.cartPage(addressData),
                          ()=>  AppInjector.instance.ordersHistoryDetails(pos,(type){
                        viewOrders();
                      }),
                    ];
                  }

                }),
              ];
            }),
          ];
        }

      }),
    ];
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
        if(value.data!.status!=null){
          if(value.data!.status==3){
            showAlertDialog(value.data!.key!,{
              "environment" : EndPoints.env,
              "user_id": user!.userId,
              "menu_id": menu_id,
              "product_info": {
                itemId: qty,
              }
            });


          }

        }else {
          if (value.data!.cart != null) {
            GetBar(
              messageText: Row(
                children: [
                  Text(value.data!.cart!, style: const TextStyle(
                      color: Colors.black,
                      fontFamily: Inter.regular,
                      fontSize: 14),),
                  Spacer(),
                  GestureDetector(
                      onTap: () {
                        addSelectedPos.add(2);
                      },
                      child: Text('View cart', style: TextStyle(
                          color: HexColor('#0E8E60'),
                          fontFamily: Inter.medium,
                          fontSize: 12),)),

                ],
              ),
              margin: EdgeInsets.only(bottom: 68, left: 5, right: 5),
              duration: const Duration(seconds: 3),
              backgroundColor: HexColor('#E7F6EA'),
              snackPosition: SnackPosition.BOTTOM,
              animationDuration: const Duration(milliseconds: 500),
            ).show();
            for (int i = 0; i < menuList!.length; i++) {
              if (menuList![i].productId == itemId) {
                menuList![i].cartQty = int.parse(qty!);
                break;
              }
            }

            _isShopMenu.add(menuList!);
          } else {

          }
        }

      }
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
                ShopService().addOtherShopItem(data).then((value) {
                  _isLoading.add(false);
                  if (value.data!.cart != null) {
                    GetBar(
                      messageText: Row(
                        children: [
                          Text(value.data!.cart!, style: const TextStyle(
                              color: Colors.black,
                              fontFamily: Inter.regular,
                              fontSize: 14),),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                addSelectedPos.add(2);
                              },
                              child: Text('View cart', style: TextStyle(
                                  color: HexColor('#0E8E60'),
                                  fontFamily: Inter.medium,
                                  fontSize: 12),)),

                        ],
                      ),
                      margin: EdgeInsets.only(bottom: 68, left: 5, right: 5),
                      duration: const Duration(seconds: 3),
                      backgroundColor: HexColor('#E7F6EA'),
                      snackPosition: SnackPosition.BOTTOM,
                      animationDuration: const Duration(milliseconds: 500),
                    ).show();
                    for (int i = 0; i < menuList!.length; i++) {
                      if (menuList![i].productId == data['itemId']) {
                        menuList![i].cartQty = int.parse(data['qty']);
                        break;
                      }
                    }

                    _isShopMenu.add(menuList!);
                  } else {

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
