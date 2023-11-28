import 'dart:io';

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/fonts/fonts.dart';
import 'package:byme_app/common/label/item_label_text.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/shop/shop_menu.dart';
import 'package:byme_app/pages/shop/widget/cart_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../common/utilities/byme_colors.dart';
import '../../common/utilities/fonts.dart';
import '../../di/app_injector.dart';
import '../dashboard/dashboard_bloc.dart';
import 'bloc/shop_menu_bloc.dart';

class ShopMenuPage extends StatefulWidget {
  const ShopMenuPage({super.key});

  @override
  ShopMenuPageState createState() => ShopMenuPageState();
}

class ShopMenuPageState extends State<ShopMenuPage> {
  ShopMenuBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder<int>(
          initialData: 1,
          stream: _bloc!.selectedPos,
          builder: (b,s){
          return (s.data==1)?LoaderContainer(
            stream: _bloc!.isLoading,
            child: Container(
              height: Get.height,
              width: Get.width,
              color: Colors.white,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Stack(
                      children: [
                        Image.network((_bloc!.shopDetails!.shopDetails!=null)?_bloc!.shopDetails!.shopDetails!.imageLink!:_bloc!.shopDetails!.imageLink! ,height: 130,width: Get.width,errorBuilder: (BuildContext context, Object error,
                            StackTrace? stackTrace) {
                          return Container(
                              height: 130,width: Get.width,
                            decoration: const BoxDecoration(
                                color: Colors.grey,
                            ),
                          );
                        },),
                        Positioned(
                          left: 10,
                            top: 50,
                            child:  Row(
                          children: [
                             IconButton( onPressed: () { Navigator.pop(context); },icon:Icon(Icons.arrow_back_ios,color: Colors.white) ),
                            ItemLabelText(text:(_bloc!.shopDetails!.shopDetails!=null)?_bloc!.shopDetails!.shopDetails!.shopName : _bloc!.shopDetails!.shopName,style: const TextStyle(color: Colors.white,fontSize: 20,fontFamily: Inter.bold),),

                          ],
                        )),
                        Positioned(
                          right: 10,
                          top: 50,
                          child: Container(
                            height: 35,
                            width: 35,
                            padding: const EdgeInsets.all(7),
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.white
                            ),
                            child: SvgPicture.asset('assets/images/search.svg',width: 16,height: 16,),
                          ),
                        )

                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                        children: [
                          SvgPicture.asset('assets/images/shop.svg',width: 16,height: 16,),
                          const SizedBox(width: 10,),
                          Expanded(
                              flex: 9,
                              child: ItemLabelText(text:(_bloc!.shopDetails!.shopDetails!=null)? _bloc!.shopDetails!.shopDetails!.shopAddress : _bloc!.shopDetails!.shopAddress,textAlignment: TextAlign.start,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: ByMeColors.text_color,fontWeight: FontWeight.w400),)),
                          const SizedBox(width: 50,),
                        Expanded(
                            flex:5,

                            child: Container(
                              padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(Radius.circular(110)),
                                  color:(_bloc!.shopDetails!.shopDetails!=null)?(_bloc!.shopDetails!.shopDetails!.shopStatus=="True")?ByMeColors.green_color.withOpacity(0.2):ByMeColors.text_red_color.withOpacity(0.2):(_bloc!.shopDetails!.shopStatus=="True")?ByMeColors.green_color.withOpacity(0.2):ByMeColors.text_red_color.withOpacity(0.2),
                                ),
                                child: ItemLabelText(text:(_bloc!.shopDetails!.shopDetails!=null)? (_bloc!.shopDetails!.shopDetails!.shopStatus=="True")?"Open Now":"Closes Soon":(_bloc!.shopDetails!.shopStatus=="True")?"Open Now":"Closes Soon",textAlignment: TextAlign.center,maxlines: 1,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: (_bloc!.shopDetails!.shopDetails!=null)?(_bloc!.shopDetails!.shopDetails!.shopStatus=="True")?ByMeColors.green_color:ByMeColors.text_red_color:(_bloc!.shopDetails!.shopStatus=="True")?ByMeColors.green_color:ByMeColors.text_red_color,fontWeight: FontWeight.w400),)),
                          ),

                        ],
                      ),
                    ),
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.only(left: 15,right: 15),
                      child: ItemLabelText(text: 'Menu',style: const TextStyle(color: Colors.black,fontFamily: Inter.bold,fontSize: 23),),
                    ),
                    StreamBuilder<List<ShopMenu>>(
                        initialData: [],
                        stream: _bloc!.isShopMenu,
                        builder: (context, sp) {
                          return ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                              itemCount: sp.data!.length,
                              itemBuilder: (b,i){
                                return GestureDetector(
                                  onTap: (){
                                    _bloc!.addCartQty.add(sp.data![i].cartQty!>0?sp.data![i].cartQty!:1);
                                     cartBottomSheet(menu: sp.data![i],onCallback: (qty,itemId){

                                      _bloc!.addCart(qty, itemId);
                                     },bloc: _bloc);
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    margin: const EdgeInsets.only(left: 15.0,right: 15,top: 8,bottom: 8),
                                    child: Row(
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                              border: Border.all(color: HexColor('#C4C4C4'),width: 1 ),
                                              borderRadius: const BorderRadius.all(Radius.circular(9))
                                          ),
                                          child: Image.network(sp.data![i].imageLink!,height: 74,width: 74,errorBuilder: (BuildContext context, Object error,
                                              StackTrace? stackTrace) {
                                            return Container(
                                              padding: EdgeInsets.all(10),
                                              height: 74,width: 74,
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.all(Radius.circular(10))
                                              ),
                                            );
                                          },),
                                        ),
                                        SizedBox(width: 8,),
                                        Expanded(
                                          flex: 4,
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              ItemLabelText(text: sp.data![i].productName,style: TextStyle(color: Colors.black,fontSize: 16,fontFamily: Inter.regular),),
                                              SizedBox(height: 8,),
                                              ItemLabelText(text: sp.data![i].productDescription,style: TextStyle(color: HexColor('#444444'),fontSize: 12,fontFamily: Inter.regular),),
                                              SizedBox(height: 8,),
                                              RichText(
                                                text:  TextSpan(
                                                  text: '₹',
                                                  style: TextStyle(
                                                      color: HexColor('#858E8B'),
                                                      fontFamily: Inter.regular,
                                                      fontWeight: FontWeight.w400
                                                  ),
                                                  children: [
                                                    TextSpan(
                                                      text: sp.data![i].mrpPrice,
                                                      style: TextStyle(
                                                          color:Colors.black,
                                                          fontFamily: Inter.regular,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: '/ ${ sp.data![i].unit}',
                                                      style: TextStyle(
                                                          color: HexColor('#858E8B'),
                                                          fontFamily: Inter.regular,
                                                          fontWeight: FontWeight.w600
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )

                                            ],
                                          ),
                                        ),
                                        Expanded(
                                            flex: 1,
                                            child: Container(
                                              alignment: Alignment.center,
                                              height: 45,
                                              width: 45,
                                              decoration: BoxDecoration(
                                                  color: sp.data![i].cartQty!>0?HexColor('#E7F6EA'):HexColor('F5F5F5'),
                                                  borderRadius: BorderRadius.all(Radius.circular(9))
                                              ),
                                              child: SvgPicture.asset('assets/images/add_cart.svg',width: 19,height: 19,color: sp.data![i].cartQty!>0?ByMeColors.app_color:HexColor('#858E8B'),),
                                            ))
                                      ],
                                    ),
                                  ),
                                );
                              });
                        }
                    )
                  ],
                ),
              ),
            ),
          ):_bloc!.pagesList[s.data!]();
        }
      ),
      bottomNavigationBar: Container(
        height: (Platform.isAndroid) ? 64 : 94,
        decoration: BoxDecoration(boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15), //color of shadow
            blurRadius: 12, // blur radius
            offset: Offset(4.27, -2), // changes position of shadow
          ),
        ]),
        child: StreamBuilder<int>(
            initialData: 0,
            stream: _bloc!.selectedPos,
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
                    _bloc!.addSelectedPos.add(value);
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