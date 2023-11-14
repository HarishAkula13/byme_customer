
import 'dart:convert';

import 'package:byme_app/common/utils/Constants.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/shop/shop_list_deatils.dart';
import 'package:byme_app/repositories/shop/shop_api.dart';
import 'package:rxdart/rxdart.dart';
import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../common/utilities/logger.dart';
import '../../../../../di/app_injector.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';
import '../../../../../model/address_data/address_data.dart';
import '../../../../../model/dashboard/menu.dart';
import '../../../../../repositories/end_point/end_point.dart';
import '../../../dashboard_bloc.dart';


typedef BlocProvider<ShopsListBloc> ShopsListFactory(Menu? menu, AddressData? addressData);
class ShopsListBloc extends BlocBase{
  UserDataStore? userDataStore;
  Menu? menu;
  AddressData? addressData;
  final BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  final BehaviorSubject<int> _selectPos =BehaviorSubject.seeded(0);
  final BehaviorSubject<bool> _isSelect =BehaviorSubject.seeded(false);
  final BehaviorSubject<List<dynamic>> _shopList =BehaviorSubject.seeded([]);
  Stream<List<dynamic>> get shopList => _shopList;
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectPos=> _selectPos;
  Sink<int> get addSelectPos=> _selectPos;
  Stream<bool> get isSelect=> _isSelect;
  Sink<bool> get addIsSelect => _isSelect;
  List<TabBarPage> pagesList=[];
  ShopsListBloc(this.userDataStore,this.menu,this.addressData){
    setListeners();
  }

  void setListeners() {

    _isLoading.add(true);
    pagesList=[
          ()=> AppInjector.instance.home(addressData),
          ()=> AppInjector.instance.nearShop(addressData),
          ()=> AppInjector.instance.cartPage(addressData),
          ()=> AppInjector.instance.profile((){viewOrders();},addressData),
    ];
    ShopService().getShopList({
      "environment" : EndPoints.env,
      // "city_name":place.locality,
      // "latitude": position.latitude,
      // "longitude":position.longitude
      "city_name":"Karimnagar",
      "latitude": 17.4134871,
      "longitude":78.3012398
    }).then((value) {
      _isLoading.add(false);
      if(value.error==null){
        if(value.data!.shops_list!=null){
          _shopList.add([]);
          if(menu?.tag=='KG'){
           // printLog("map", value.data!.shops_list!.KG!.removeAt(value.data!.shops_list!.KG!.length-1));
            //printLog("map last", value.data!.shops_list!.KG!.removeLast());
           // ShopListDetails shop=ShopListDetails.fromJson();
            _shopList.add(value.data!.shops_list!.KG!);

          }else  if(menu?.tag=='PH'){
            _shopList.add(value.data!.shops_list!.PH!);

          }else  if(menu?.tag=='LT'){
            _shopList.add(value.data!.shops_list!.LT!);

          }else  if(menu?.tag=='FV'){
            _shopList.add(value.data!.shops_list!.FV!);

          }else  if(menu?.tag=='FB'){
            _shopList.add(value.data!.shops_list!.FB!);

          }else  if(menu?.tag=='HW'){
            _shopList.add(value.data!.shops_list!.HW!);

          }else  if(menu?.tag=='MD'){
            _shopList.add(value.data!.shops_list!.MD!);

          }else  if(menu?.tag=='LQ'){
            _shopList.add(value.data!.shops_list!.LQ!);

          }else  if(menu?.tag=='ME'){
            _shopList.add(value.data!.shops_list!.ME!);

          }else{
            _shopList.add([]);
          }



        }else{
          _shopList.add([]);
        }
      }else{
        _shopList.add([]);
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
}