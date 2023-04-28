
import 'package:byme_app/common/textfield/byme_search_field.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/dialog/bottom_sheet/categories_dialog.dart';
import '../../../../common/dialog/custom_dialogs.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/textfield/byme_text_field.dart';
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
                ItemLabelText(text: 'Ranjith Kumar',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),),
                SizedBox(width: 10,),

                Row(
                  children: [
                    Icon((Icons.location_on_outlined),size: 20,color: Colors.grey,),
                    SizedBox(width: 5,),

                    ItemLabelText(text: 'kavuri hills  ',style: TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular),),
                              ],
                ),
              ],
            ),
            Spacer(),
            GestureDetector(
              onTap: (){
                Get.to(AppInjector.instance.changeAddress);
              },
                child: SvgPicture.asset('assets/images/edit.svg',)),

          ],
        ),
      ),
    ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
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
                  SizedBox(height: 20,),
                  Row(
                    children: [
                      GestureDetector(
                          onTap: (){
                            _bloc!.addIsService.add(false);
                          },

                          child: ItemLabelText(text: 'Shops',style: TextStyle(fontSize: 20,color: san.data==false?Colors.black:ByMeColors.icon_un_select,fontFamily: Inter.medium,fontWeight: FontWeight.w800),)),
                      Spacer(),
                      GestureDetector(
                          onTap: (){
                            _bloc!.addIsService.add(true);
                          },

                          child:  ItemLabelText(text: 'Services',style: TextStyle(fontSize: 20,color:  san.data==true?Colors.black:ByMeColors.icon_un_select,fontFamily: Inter.medium,fontWeight: FontWeight.w800),))

                    ],
                  ),
                  SizedBox(height: 20,),
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
                              SizedBox(height: 10,),
                              ItemLabelText(text: s.data![i].title!,textAlignment: TextAlign.center,style: TextStyle(fontFamily: Inter.medium,fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400),)
                            ],
                          ),
                        ),),);
                    }
                  ):SizedBox(),
                  SizedBox(height: 20,),
                  (san.data==true)?ItemLabelText(text: 'Orders',style: TextStyle(fontSize: 20,color:  Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w800),):SizedBox(),
                  (san.data==true)?SizedBox(
                    height: 110,
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: 8,
                        itemBuilder: (b,j){
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset('assets/images/order_load.svg'),
                          );
                        }),
                  ):SizedBox()
                ],
              );
            }
          ),
        ),
      ),
    );


  }


}