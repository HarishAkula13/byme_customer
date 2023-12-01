
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/common/textfield/byme_search_field.dart';
import 'package:byme_app/common/utilities/logger.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/shop/shop_list_deatils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/dialog/bottom_sheet/categories_dialog.dart';
import '../../../../common/dialog/custom_dialogs.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import '../../../../di/app_injector.dart';
import '../../../../model/dashboard/menu.dart';
import 'bloc/home_bloc.dart';

class HomePage extends StatefulWidget {

  @override
  HomePageState createState() => HomePageState();
}
class HomePageState extends State<HomePage> with CustomDialogMixin{
  HomeBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Colors.white,
      elevation: 0,

      title: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StreamBuilder<String>(
                  stream: _bloc!.userName,
                  builder: (context, snap) {
                    return ItemLabelText(text: '${snap.data}',style: const TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),);
                  }
                ),
                const SizedBox(width: 10,),

                Row(
                  children: [
                    const Icon((Icons.location_on_outlined),size: 20,color: Colors.grey,),
                    const SizedBox(width: 5,),

                    ItemLabelText(text:_bloc!.address!.addressTitle,style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular),),
                              ],
                ),
              ],
            ),
            const Spacer(),
            GestureDetector(
              onTap: (){
                Get.to(AppInjector.instance.addressList(1));
              },
                child: SvgPicture.asset('assets/images/edit.svg',)),

          ],
        ),
      ),
    ),
      backgroundColor: Colors.white,
      body: LoaderContainer(
        stream: _bloc!.isLoading,
        child: SingleChildScrollView(
          child: Container(
            height: Get.height,
            color: Colors.white,
            padding: const EdgeInsets.all(20.0),
            child: StreamBuilder<bool>(
                initialData: false,
                stream: _bloc!.isService,
                builder: (context, san) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    MySearchField(
                      labelText: "",
                      hintText: "Search for items & shop",
                      inputAction: TextInputAction.done,
                      keyboardType: TextInputType.name,
                    ),
                    const SizedBox(height: 20,),
                    Row(
                      children: [
                        GestureDetector(
                            onTap: (){
                              _bloc!.addIsService.add(false);
                              _bloc!.getData(false);
                            },

                            child: ItemLabelText(text: 'Shops',style: TextStyle(fontSize: 20,color: san.data==false?Colors.black:ByMeColors.icon_un_select,fontFamily: Inter.medium,fontWeight: FontWeight.w800),)),
                        const Spacer(),
                        GestureDetector(
                            onTap: (){
                              _bloc!.addIsService.add(true);
                              _bloc!.getData(true);
                            },

                            child:  ItemLabelText(text: 'Services',style: TextStyle(fontSize: 20,color:  san.data==true?Colors.black:ByMeColors.icon_un_select,fontFamily: Inter.medium,fontWeight: FontWeight.w800),))

                      ],
                    ),
                    const SizedBox(height: 20,),
                    (san.data==true)?StreamBuilder<List<Menu>>(
                      initialData: [],
                      stream: _bloc!.menuList,
                      builder: (context, s) {
                        return GridView.count(
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 25,
                          childAspectRatio: 1,
                          shrinkWrap: true,
                          crossAxisCount: 3,
                          children: List.generate(s.data!.length, (i) => GestureDetector(
                            onTap: (){
                              _bloc!.addCategorieName.add(s.data![i].title!);
                                CategoriesDialog(context,(){

                                },_bloc!,i);
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
                          ),),);
                      }
                    ):StreamBuilder<List<Menu>>(
                        initialData: [],
                        stream: _bloc!.shopCategories,
                        builder: (context, s) {
                          return GridView.count(
                            mainAxisSpacing: 8,
                            crossAxisSpacing: 25,
                            childAspectRatio: 1,
                            shrinkWrap: true,
                            crossAxisCount: 3,
                            children: List.generate(s.data!.length, (i) => GestureDetector(
                              onTap: (){
                                //_bloc!.addCategorieName.add(s.data![i].title!);
                                Get.to(AppInjector.instance.shopList(s.data![i],_bloc!.address));
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
                            ),),);
                        }
                    ),
                    const SizedBox(height: 20,),
                    ItemLabelText(text: (san.data==true)?'Orders':"Nearby",style: const TextStyle(fontSize: 20,color:  Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w800),),
                    (san.data==false)?SizedBox(
                      height: 100,
                      child: StreamBuilder<List<ShopListDetails>>(
                        initialData: [],
                        stream: _bloc!.shopList,
                        builder: (context, snap) {
                          return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: snap.data!.length,
                              shrinkWrap: true,
                              //physics:  NeverScrollableScrollPhysics(),
                              itemBuilder: (b,j){
                                return GestureDetector(
                                  onTap:(){
                                    Get.to(AppInjector.instance.shopMenu(snap.data![j],_bloc!.address));
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Container(
                                      height: 75,
                                      width: 85,
                                      alignment: Alignment.bottomCenter,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(10)),
                                          image: DecorationImage(image:
                                          NetworkImage(snap.data![j].shopDetails!.imageLink!),
                                              fit: BoxFit.fill

                                          )
                                      ),
                                      child: Container(
                                          width: Get.width,
                                          decoration: BoxDecoration(
                                            color: Colors.black.withOpacity(0.4),
                                            borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10)),

                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.all(4.0),
                                            child: ItemLabelText(text:snap.data![j].shopDetails!.shopName,textAlignment: TextAlign.center,style: TextStyle(color: Colors.white,fontSize: 10,overflow: TextOverflow.ellipsis,fontFamily: Inter.medium,),),
                                          )),

                                    ),
                                  ),
                                );
                              });
                        }
                      ),
                    ):const SizedBox()
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );


  }


}