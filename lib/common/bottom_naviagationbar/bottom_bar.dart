import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../utilities/byme_colors.dart';

Widget bottomBar(){
  return SizedBox(
    height: 48,
    child: Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: ByMeColors.app_color,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        onTap: (value){
          if(value==0){
            //Get.to(AppInjector.instance.homePage);
          }else  if(value==1){
            //Get.to(AppInjector.instance.profilePage);
          }else if(value==2){
            //Get.to(AppInjector.instance.dashboard(1));
          }

        },
        items:  <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home,size: 18,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person,size: 18,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard,size: 18,),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications,size: 18,),
            label: '',
          ),
        ],

      ),
    ),
  );
}