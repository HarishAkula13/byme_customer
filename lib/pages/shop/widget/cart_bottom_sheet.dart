import 'package:byme_app/pages/shop/bloc/shop_menu_bloc.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../common/button/byme_button.dart';
import '../../../common/label/item_label_text.dart';
import '../../../common/utilities/fonts.dart';
import '../../../model/shop/shop_menu.dart';

void cartBottomSheet({ShopMenu? menu,  Function(String qty,String itemId)? onCallback,ShopMenuBloc? bloc}){
  showModalBottomSheet(
      isDismissible: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
      context: Get.context!, builder: (BuildContext context){

    return StreamBuilder<int>(
      initialData: 1,
      stream: bloc!.cartQty,
      builder: (context, s) {
        return Container(
          decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) )
          ),
          height: 200,
          alignment: Alignment.center,

          child:   Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: Colors.white,
                margin: const EdgeInsets.only(left: 15.0,right: 15,top: 8,bottom: 8),
                child: Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          border: Border.all(color: HexColor('#C4C4C4'),width: 1 ),
                          borderRadius: const BorderRadius.all(Radius.circular(9))
                      ),
                      child: Image.network(menu!.imageLink!,height: 74,width: 74,errorBuilder: (BuildContext context, Object error,
                          StackTrace? stackTrace) {
                        return Container(
                          padding: const EdgeInsets.all(10),
                          height: 74,width: 74,
                          decoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.all(Radius.circular(10))
                          ),
                        );
                      },),
                    ),
                    const SizedBox(width: 8,),
                    Expanded(
                      flex: 4,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ItemLabelText(text: menu.productName,style: const TextStyle(color: Colors.black,fontSize: 16,fontFamily: Inter.regular),),
                          const SizedBox(height: 5,),
                          ItemLabelText(text: menu.productDescription,style: TextStyle(color: HexColor('#444444'),fontSize: 12,fontFamily: Inter.regular),),
                          const SizedBox(height: 5,),
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
                                  text: menu.mrpPrice,
                                  style: const TextStyle(
                                      color:Colors.black,
                                      fontFamily: Inter.regular,
                                      fontWeight: FontWeight.w600
                                  ),
                                ),
                                TextSpan(
                                  text: '/ ${ menu.unit}',
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
                        flex: 2,
                        child: Align(
                          alignment: Alignment.center,
                          child: Container(
                            height: 74,
                            width: 84,
                            decoration: BoxDecoration(
                                color: HexColor('F5F5F5'),
                                borderRadius: const BorderRadius.all(Radius.circular(9))
                            ),
                            child:Column(
                              children: [
                                Container(
                                  height: 20,
                                  width: 84,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: HexColor('#E6E6E6'),
                                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(9),topRight: Radius.circular(9))
                                  ),
                                  child: ItemLabelText(text: 'TOTAL',style: TextStyle(color: HexColor('#828785'),fontSize: 12)),
                                ),
                                Container(
                                  height: 54,
                                  width: 84,
                                  alignment: Alignment.center,
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      ItemLabelText(text:  '₹',style:  TextStyle(fontSize: 12,color:  Colors.black,fontFamily: Inter.regular),),
                                      ItemLabelText(text:  (double.parse(menu.mrpPrice!)*s.data!).toStringAsFixed(1),style:  TextStyle(fontSize: 16,color: Colors.black,fontFamily: Inter.medium),),
                                    ],
                                  ),
                                )
                              ],
                            )
                          ),
                        ))
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: DottedLine(direction: Axis.horizontal,dashColor: HexColor('#CDD0CF'),),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Row(
                      children: [
                        GestureDetector(
                          onTap: (){
                            if(s.data!>1)
                            bloc.addCartQty.add(s.data!-1);
                          },
                          child:  SvgPicture.asset('assets/images/cart_minus.svg'),
                        ),

                        const SizedBox(width: 10,),
                        RichText(
                          text:  TextSpan(
                            text: s.data.toString(),
                            style: const TextStyle(
                              fontSize: 16,
                                color:Colors.black,
                                fontFamily: Inter.regular,
                                fontWeight: FontWeight.w600
                            ),
                            children: [

                              TextSpan(
                                text: '${ menu.unit}',
                                style: TextStyle(
                                    fontSize: 10,
                                    color: HexColor('#858E8B'),
                                    fontFamily: Inter.regular,
                                    fontWeight: FontWeight.w600
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(width: 10,),
                        GestureDetector(
                          onTap: (){
                            bloc.addCartQty.add(s.data!+1);
                          },
                          child:  SvgPicture.asset('assets/images/cart_plus.svg'),
                        ),
                      ],
                    ),
                    Spacer(),
                    SizedBox(
                      height: 46,
                      width: 90,
                      child: customButton(() {
                        Navigator.pop(context);
                        onCallback!(s.data!.toString(),menu.productId!);
                      }, ItemLabelText(text:'Add',style: TextStyle(fontSize: 14,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context,),
                    ),
                  ],
                ),
              )
            ],
          ),

        );
      }
    );
  });
}