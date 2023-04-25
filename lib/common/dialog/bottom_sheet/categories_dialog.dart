import 'package:byme_app/common/dialog/bottom_sheet/service_details_dialog.dart';
import 'package:byme_app/model/dashboard/categories.dart';
import 'package:byme_app/pages/dashboard/pages/home/bloc/home_bloc.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../button/byme_button.dart';
import '../../button/byme_outline_button.dart';
import '../../label/item_label_text.dart';
import '../../utilities/byme_colors.dart';
import '../../utilities/fonts.dart';
import 'mark_done_dialog.dart';

void CategoriesDialog(BuildContext context,Function() onClick,HomeBloc bloc){

  showModalBottomSheet(
    context: context,
    elevation: 0,
   // isScrollControlled: true,
    barrierColor: Colors.black.withAlpha(1),
    //backgroundColor: Colors.transparent,
    isDismissible: false,// Also default
    builder: (context) => SingleChildScrollView(
      child: Container(

        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                spreadRadius: 0,
                blurRadius: 16,
                offset: Offset(0, -6),
              )
            ]
        ),
        alignment: Alignment.bottomCenter,
        child: Column(
          children: [
            SizedBox(height: 20,),
            StreamBuilder<String>(
              initialData: '',
              stream: bloc.categorieName,
              builder: (context, sn) {
                return ItemLabelText(text:sn.data!.replaceAll("\n", " "),style: TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w800));
              }
            ),
            SizedBox(height: 20,),
            DottedLine(direction: Axis.horizontal,dashColor: HexColor('#CDD0CF'),),
            SizedBox(height: 10,),
            StreamBuilder<List<Categories>>(
              initialData: [],
              stream:bloc.categoriesList,
              builder: (context, s) {
                return ListView.builder(
                    itemCount: s.data!.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (b,i){
                      return GestureDetector(
                        onTap: (){
                          s.data![i].isClick=! s.data![i].isClick!;
                          bloc.addCategoriesList.add(s.data!);
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              ItemLabelText(text: s.data![i].title,style: TextStyle(fontWeight: FontWeight.w600,fontSize: 15,color: Colors.black,fontFamily: Inter.medium),),
                              Spacer(),
                              SvgPicture.asset(s.data![i].isClick==true?'assets/images/check.svg':'assets/images/uncheck.svg')

                            ],
                          ),
                        ),
                      );
                    });
              }
            ),
            SizedBox(height: 20,),
            customButton(() {

              Navigator.pop(context);
              ServiceDetailsDialog(context,(){

              },bloc);

            }, ItemLabelText(text:'Proceed',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),

          ],
        ),

      ),
    ),
  );


}