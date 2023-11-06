

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../../app/arch/bloc_provider.dart';
import '../../../../../manager/user_data_store/user_data_store.dart';


typedef PrivacyPolicyPageFactory = BlocProvider<PrivacyPolicyPageBloc> Function(int type);
class PrivacyPolicyPageBloc extends BlocBase {
  UserDataStore? userDataStore;
  int? type;
  final BehaviorSubject<bool> _isLoading=BehaviorSubject.seeded(false);
  final BehaviorSubject<int> _selectedPos= BehaviorSubject();

  Stream<bool> get isLoading=>_isLoading;
  Sink<bool> get addIsLoading=>_isLoading;
  Stream<int> get selectedPos => _selectedPos;
  Sink<int> get addSelectedPos => _selectedPos;
  PrivacyPolicyPageBloc({this.userDataStore,this.type}){

  }



}