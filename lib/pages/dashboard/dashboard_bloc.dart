
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../app/arch/bloc_provider.dart';
import '../../di/app_injector.dart';
import '../../manager/user_data_store/user_data_store.dart';
import '../../repositories/login/login_api.dart';
typedef TabBarPage = Widget Function();

typedef BlocProvider<DashboardBloc> DashboardFactory();
class DashboardBloc extends BlocBase{
  LoginService? loginService;
  UserDataStore? userDataStore;
  BehaviorSubject<bool> _isLoading =BehaviorSubject.seeded(false);
  BehaviorSubject<int> _selectedPos= BehaviorSubject.seeded(0);
  BehaviorSubject<bool> _isOrder =BehaviorSubject.seeded(false);
  BehaviorSubject<List<TabBarPage>> _pagesList =BehaviorSubject.seeded([]);
  Stream<List<TabBarPage>> get pagesList => _pagesList;
  Stream<bool> get isLoading=> _isLoading;
  Stream<int> get selectedPos => _selectedPos;
  Sink<int> get addSelectedPos => _selectedPos;
  Stream<bool> get isOrder => _isOrder;
  Sink<bool> get addIsOrder => _isOrder;
  DashboardBloc(this.loginService,this.userDataStore){
    setListeners();
  }

  void setListeners() {

    _pagesList.add([
          ()=> AppInjector.instance.home,
          ()=> AppInjector.instance.orders,
          ()=> AppInjector.instance.orders,
          ()=> AppInjector.instance.profile((){viewOrders();}),
    ]);

  }

  void viewOrders(){
    _pagesList.add([
          ()=> AppInjector.instance.home,
          ()=> AppInjector.instance.orders,
          ()=> AppInjector.instance.orders,
          ()=> AppInjector.instance.ordersHistory((type,pos){
            if(type==0){
              _pagesList.add([
                    ()=> AppInjector.instance.home,
                    ()=> AppInjector.instance.orders,
                    ()=> AppInjector.instance.orders,
                    ()=> AppInjector.instance.profile((){viewOrders();}),
              ]);
            }else _pagesList.add([
                  ()=> AppInjector.instance.home,
                  ()=> AppInjector.instance.orders,
                  ()=> AppInjector.instance.orders,
                  ()=>  AppInjector.instance.ordersHistoryDetails(pos,(type){
                    _pagesList.add([
                          ()=> AppInjector.instance.home,
                          ()=> AppInjector.instance.orders,
                          ()=> AppInjector.instance.orders,
                          ()=> AppInjector.instance.ordersHistory((type,pos){
                        if(type==0){
                          _pagesList.add([
                                ()=> AppInjector.instance.home,
                                ()=> AppInjector.instance.orders,
                                ()=> AppInjector.instance.orders,
                                ()=> AppInjector.instance.profile((){viewOrders();}),
                          ]);
                        }else _pagesList.add([
                              ()=> AppInjector.instance.home,
                              ()=> AppInjector.instance.orders,
                              ()=> AppInjector.instance.orders,
                              ()=>  AppInjector.instance.ordersHistoryDetails(pos,(type){

                          }),
                        ]);

                      }),
                    ]);
                  }),
            ]);

          }),
    ]);
  }
}