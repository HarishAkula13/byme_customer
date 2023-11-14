import 'dart:convert';

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/shop/shop_list_deatils.dart';
import 'package:byme_app/pages/dashboard/pages/shops_list/bloc/shops_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/fonts/fonts.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import '../../../../di/app_injector.dart';

class ShopsListPage extends StatefulWidget {
  const ShopsListPage({Key? key}) : super(key: key);

  @override
  State<ShopsListPage> createState() => _ShopsListPageState();
}

class _ShopsListPageState extends State<ShopsListPage> {
  ShopsListBloc? _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body:  StreamBuilder<int>(
          initialData: 0,
          stream: _bloc!.selectPos,
          builder: (b,s){
            return (s.data==0)?
           LoaderContainer(
            stream: _bloc!.isLoading,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 50,),
                    Padding(
                      padding: const EdgeInsets.only(left: 14.0),
                      child: InkWell(
                        onTap: (){
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,size: 16,),
                            const SizedBox(width: 10,),
                            ItemLabelText(text: '${_bloc!.menu!.title} Shops',style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w700),)
                          ],
                        ),
                      ),
                    ),
                    StreamBuilder<List<dynamic>>(
                      initialData: [],
                      stream: _bloc!.shopList,
                      builder: (b,sp){
                        return (sp.data!.isNotEmpty)?ListView.builder(
                            shrinkWrap: true,
                            physics:  const NeverScrollableScrollPhysics(),
                            itemCount: sp.data!.length-1,
                            itemBuilder: (b,i){

                             ShopListDetails shop=ShopListDetails.fromJson(Map<String, dynamic>.from(sp.data![i]));
                              return Container(
                                padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                                child: GestureDetector(
                                  onTap: (){
                                    Get.to(AppInjector.instance.shopMenu(shop,_bloc!.addressData));
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Image.network(shop.imageLink!,height: 75,width: 75,errorBuilder: (BuildContext context, Object error,
                                          StackTrace? stackTrace) {
                                        return Container(
                                          height: 90,width: 90,
                                          decoration: const BoxDecoration(
                                              color: Colors.grey,
                                              borderRadius: BorderRadius.all(Radius.circular(10))
                                          ),
                                        );
                                      },),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(left: 8.0),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ItemLabelText(text: shop.shopName,textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.medium,fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),),
                                              SizedBox(height: 5,),
                                              ItemLabelText(text: shop.shopAddress,textAlignment: TextAlign.start,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: ByMeColors.text_unselect_color,fontWeight: FontWeight.w400),),
                                              ItemLabelText(text: "${shop.distance ?? ''}KM Away",textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.medium,fontSize: 12,color: ByMeColors.text_unselect_color,fontWeight: FontWeight.w400),),
                                              SizedBox(height: 5,),
                                              ItemLabelText(text: (shop.shopStatus=="True")?"Open Now":"Closes Soon",textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: (shop.shopStatus=="True")?ByMeColors.green_color:ByMeColors.text_red_color,fontWeight: FontWeight.w400),),

                                            ],
                                          ),
                                        ),
                                      ),

                                      Center(
                                        child: Container(
                                          height: 45,
                                          width: 45,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.all(Radius.circular(10)),
                                              color: HexColor("#F3F3F3")
                                          ),
                                          child: Icon(Icons.arrow_forward_ios,color: HexColor("#828785"),size: 14,),
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                              );
                            }):SizedBox();
                      },
                    ),
                  ],
                ),
              ),
            ),
          ):_bloc!.pagesList[s.data!]();
        }
      ),
      bottomNavigationBar: Container(
        height: 64,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), //color of shadow
            blurRadius: 12, // blur radius
            offset: Offset(4.27, -2), // changes position of shadow
          ),
        ]),
        child: StreamBuilder<int>(
            initialData: 0,
            stream: _bloc!.selectPos,
            builder: (context, snapshot) {
              return BottomNavigationBar(
                  type: BottomNavigationBarType.fixed,
                  backgroundColor: Colors.white,
                  selectedItemColor: ByMeColors.app_color,
                  unselectedItemColor: ByMeColors.un_select,
                  selectedLabelStyle: TextStyle(
                      fontSize: 11,
                      fontFamily: Fonts.medium,
                      color: ByMeColors.app_color),
                  unselectedLabelStyle: TextStyle(
                      fontSize: 11,
                      fontFamily: Fonts.medium,
                      color: ByMeColors.un_select),
                  selectedFontSize: 0.0,
                  unselectedFontSize: 0,
                  currentIndex: snapshot.data!,
                  onTap: (value) {
                    _bloc!.addSelectPos.add(value);
                  },
                  items: <BottomNavigationBarItem>[
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/home.svg',height: 16,width: 16,color: (snapshot.data ==0)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Home",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/nearby.svg',height: 16,width: 16,color: (snapshot.data ==1)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Near Me",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/cart.svg',height: 16,width: 16,color: (snapshot.data ==2)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Cart",
                    ),
                    BottomNavigationBarItem(
                      icon: Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: SvgPicture.asset('assets/images/profile.svg',height: 16,width: 16,color: (snapshot.data ==3)?ByMeColors.app_color:ByMeColors.icon_un_select,),
                      ),
                      label: "Profile",
                    ),

                  ]);
            }

        ),
      ),
    );
  }
}
