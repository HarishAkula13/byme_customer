import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/common/utilities/byme_colors.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/shop/shop_list_deatils.dart';
import 'package:byme_app/pages/dashboard/pages/shops/bloc/near_shop_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import '../../../../common/utilities/logger.dart';
import '../../../../model/dashboard/menu.dart';

class NearShops extends StatefulWidget {
  const NearShops({super.key});

  @override
  _NearShopsState createState() => _NearShopsState();
}

class _NearShopsState extends State<NearShops> {
  NearShopsBloc? bloc;
  @override
  void initState() {
  bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoaderContainer(
        stream: bloc!.isLoading,
        child: Container(
          color: Colors.white,
          height: Get.height,
          child:SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 50,),
              StreamBuilder<List<Menu>>(
                  initialData: [],
                  stream: bloc!.shopCategories,
                  builder: (context, s) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: s.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (b,i){
                            return  Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: GestureDetector(
                                onTap: (){

                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundColor:HexColor('#E7F6EA'),
                                        child: SvgPicture.asset(s.data![i].icon!)),
                                    const SizedBox(height: 10,),
                                    ItemLabelText(text: s.data![i].title!,textAlignment: TextAlign.center,style: const TextStyle(fontFamily: Inter.medium,fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            );
                          }),
                    );



                  }
              ),
              Container(
                padding: const EdgeInsets.only(left: 10.0,right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    ItemLabelText(text: "Popular shops nearby ",style: const TextStyle(fontFamily: Inter.medium,fontSize: 16,color: Colors.black,fontWeight: FontWeight.w700),),
                    CircleAvatar(
                      radius: 20,
                      backgroundColor: HexColor("#F5F5F5"),
                      child: Icon(Icons.search,color: ByMeColors.text_unselect_color,),
                    )
                  ],
                ),
              ),

              StreamBuilder<List<ShopListDetails>>(
                  initialData: [],
                  stream: bloc!.shopList,
                  builder: (context, sp) {
                    return ListView.builder(
                        itemCount: sp.data!.length,
                        shrinkWrap: true,
                        physics:  NeverScrollableScrollPhysics(),
                        itemBuilder: (b,i){
                          return  Container(
                            padding: const EdgeInsets.only(left: 10.0,right: 10,bottom: 10),
                            child: GestureDetector(
                              onTap: (){
                                Get.to(AppInjector.instance.shopMenu(sp.data![i],bloc!.address));
                              },
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.network(sp.data![i].shopDetails!.imageLink!,height: 75,width: 75,errorBuilder: (BuildContext context, Object error,
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
                                          ItemLabelText(text: sp.data![i].shopDetails!.shopName,textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.medium,fontSize: 14,color: Colors.black,fontWeight: FontWeight.w600),),
                                          SizedBox(height: 5,),
                                          ItemLabelText(text: sp.data![i].shopDetails!.shopAddress,textAlignment: TextAlign.start,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: ByMeColors.text_unselect_color,fontWeight: FontWeight.w400),),
                                          ItemLabelText(text: "${sp.data![i].distance.toString()}KM Away",textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.medium,fontSize: 12,color: ByMeColors.text_unselect_color,fontWeight: FontWeight.w400),),
                                          SizedBox(height: 5,),
                                          ItemLabelText(text: (sp.data![i].shopDetails!.shopStatus=="True")?"Open Now":"Closes Soon",textAlignment: TextAlign.center,style:  TextStyle(fontFamily: Inter.regular,fontSize: 12,color: (sp.data![i].shopDetails!.shopStatus=="True")?ByMeColors.green_color:ByMeColors.text_red_color,fontWeight: FontWeight.w400),),

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
                        });



                  }
              ),

            ],
          ),
        ),
      ),
    ));
  }
}
