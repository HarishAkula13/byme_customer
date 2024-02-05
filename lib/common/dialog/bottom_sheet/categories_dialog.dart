import 'package:byme_app/common/dialog/bottom_sheet/service_details_dialog.dart';
import 'package:byme_app/common/dialog/bottom_sheet/taxi_service_details_dialog.dart';
import 'package:byme_app/pages/dashboard/pages/home/bloc/home_bloc.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../model/dashboard/service_list.dart';
import '../../button/byme_button.dart';
import '../../label/item_label_text.dart';
import '../../utilities/fonts.dart';
import '../../utilities/logger.dart';

void CategoriesDialog(BuildContext context,Function() onClick,HomeBloc bloc,int type){

  showModalBottomSheet(
    context: context,
    elevation: 10,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(30.0)),
    ),
    backgroundColor: Colors.white,
   // isScrollControlled: true,
    barrierColor: Colors.black.withAlpha(1),
    //backgroundColor: Colors.transparent,
    //isDismissible: false,// Also default
    builder: (context) => SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: const BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 16,
                offset: const Offset(0, -6),
              )
            ]
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            StreamBuilder<List<ServicesList>>(
              initialData: const [],
              stream:bloc.serviceListData,
              builder: (context, s) {
                return (s.data!.isNotEmpty)?Column(
                  children: [
                    ItemLabelText(text: s.data![type].serviceName,style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w800)),
                    const SizedBox(height: 20,),
                    DottedLine(direction: Axis.horizontal,dashColor: HexColor('#CDD0CF'),),
                    const SizedBox(height: 10,),
                    ListView.builder(
                        itemCount: s.data![type].category!.length,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (b,i){
                          return GestureDetector(
                            onTap: (){

                              for(int k=0;k< s.data![type].category!.length;k++){
                                if( s.data![type].category![k].categoryName== s.data![type].category![i].categoryName){
                                  s.data![type].category![k].isClick=!s.data![type].category![k].isClick!;
                                  if(s.data![type].category![k].isClick==true) {
                                    bloc.addSelectedName.add(s.data![type].category![k].categoryName!);
                                    bloc.addSubcategoryList.add(s.data![type].category![k].subCategory!);
                                    bloc.addSubCate.add(s.data![type].category![k].subCategory![0].serviceName!);

                                  }
                                }else {
                                  s.data![type].category![k].isClick=false;
                                }
                              }
                              bloc.addServiceList.add(s.data!);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Row(
                                children: [
                                  ItemLabelText(text: s.data![type].category![i].categoryName,style: const TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black,fontFamily: Inter.medium),),
                                  const Spacer(),
                                  SvgPicture.asset(s.data![type].category![i].isClick==true?'assets/images/check.svg':'assets/images/uncheck.svg')

                                ],
                              ),
                            ),
                          );
                        }),
                  ],
                ):const SizedBox();
              }
            ),
            const SizedBox(height: 20,),
            customButton(() {

              Navigator.pop(context);
              if(type==6) {
                TaxiServiceDetailsDialog(context,(){
              },bloc);
              } else {
                ServiceDetailsDialog(context,(){},bloc);
              }

            }, ItemLabelText(text:'Proceed',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),

          ],
        ),

      ),
    ),
  );


}