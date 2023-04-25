
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:tuple/tuple.dart';
import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/button/byme_button.dart';
import '../../../../common/button/byme_outline_button.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/byme_colors.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/orders_history_bloc.dart';

class OrdersHistoryPage extends StatefulWidget {

  @override
  OrdersHistoryPageState createState() => OrdersHistoryPageState();
}
class OrdersHistoryPageState extends State<OrdersHistoryPage>{
  OrdersHistoryBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      child: WillPopScope(
        onWillPop: () async {
      _bloc!.onCallBack(0,0);
      return false;
        },
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: () {
              _bloc!.onNavigate(0,0);
            }, icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,),),
            automaticallyImplyLeading: false,
            title: ItemLabelText(text: 'Your Orders',style: const TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),),
          ),
          body: Container(

            child: ListView.builder(
                itemCount: 3,
                shrinkWrap: true,
                physics: const ScrollPhysics(),
                itemBuilder: (b,i){
                  return StreamBuilder<Tuple2<int,bool>>(
                    initialData: Tuple2(-1,false),
                    stream: _bloc!.selectPos,
                    builder: (context, sp) {
                      return GestureDetector(
                        onTap: (){
                            _bloc!.onNavigate(1,i);
                         // _bloc!.addSelectPos.add(Tuple2(i, !sp.data!.item2));
                        },
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          margin: const EdgeInsets.only(left: 20,right: 20,bottom: 15),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                              border: Border.all(color: HexColor("#E9E9E9"))
                          ),
                          child: Stack(
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Row(
                                      children: [
                                       Image.asset("assets/images/market.png",),
                                        const SizedBox(width: 15,),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            ItemLabelText(text: '11 items',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w600,color: Colors.black),),
                                            const SizedBox(height: 5,),
                                            RichText(
                                                text: const TextSpan(style: TextStyle(fontSize: 12), children: [
                                                  TextSpan(
                                                      text: "from  ",
                                                      style: TextStyle(
                                                          color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                                                  TextSpan(
                                                      text: 'The form store',
                                                      style: TextStyle(fontSize: 12,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black)),
                                                ])),
                                            const SizedBox(height: 5,),
                                            RichText(
                                                text: const TextSpan( children: [
                                                  TextSpan(
                                                      text: "₹",
                                                      style: TextStyle(
                                                          color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                  TextSpan(
                                                      text: '1261',
                                                      style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                ])),

                                          ],
                                        )

                                      ],
                                    ),
                                  ),
                                  (sp.data!.item2==true&&sp.data!.item1==i)?Column(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(left: 10.0,right: 10),
                                        child: DottedLine(
                                          direction: Axis.horizontal,
                                          dashColor: Colors.grey,
                                        ),
                                      ),
                                      ListView.builder(
                                          itemCount: 3,
                                          shrinkWrap: true,
                                          physics: const ScrollPhysics(),
                                          itemBuilder: (c,index){
                                            return Container(
                                              margin: EdgeInsets.only(left: 10,right: 10,top: 10),
                                              padding: EdgeInsets.all(10),
                                              width: MediaQuery.of(context).size.width,
                                              decoration: BoxDecoration(
                                                color: HexColor('#F5F5F5'),
                                                borderRadius: BorderRadius.all(Radius.circular(10))

                                              ),
                                              child: Stack(
                                               children: [
                                                 Row(
                                                   children: [
                                                     Image.asset('assets/images/market.png',height: 40,width: 40,),
                                                     SizedBox(width: 10,),
                                                     Column(
                                                       mainAxisAlignment: MainAxisAlignment.start,
                                                       crossAxisAlignment: CrossAxisAlignment.start,
                                                       children: [
                                                         ItemLabelText(text: 'Cauly Flower',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w600,color: Colors.black),),
                                                         Container(
                                                           alignment: Alignment.center,
                                                           height: 30,
                                                           width: 50,
                                                           decoration: BoxDecoration(
                                                               color: HexColor('#E9E9E9'),
                                                               borderRadius: BorderRadius.all(Radius.circular(15))

                                                           ),
                                                           child: ItemLabelText(text: '2 kg',style: const TextStyle(fontSize: 11,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black),),


                                                         )

                                                       ],
                                                     ),


                                                   ],
                                                 ),
                                                 Positioned(top: 10,right: 20,
                                                     child: ItemLabelText(text: '195',style: const TextStyle(fontSize: 18,fontFamily: Inter.bold,fontWeight: FontWeight.w500,color: Colors.black),)),

                                               ],
                                              ),
                                            );


                                          }),
                                      Container(
                                        margin: EdgeInsets.all( 10),
                                        decoration: BoxDecoration(
                                            color: HexColor('#F5F5F5'),
                                            borderRadius: BorderRadius.all(Radius.circular(10))

                                        ),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: EdgeInsets.all( 10),

                                              child: Column(
                                                children: [
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ItemLabelText(text: 'Subtotal',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                      RichText(
                                                          text: const TextSpan( children: [
                                                            TextSpan(
                                                                text: "₹",
                                                                style: TextStyle(
                                                                    color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                            TextSpan(
                                                                text: '1261',
                                                                style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                          ])),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ItemLabelText(text: 'GST',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                      RichText(
                                                          text: const TextSpan( children: [
                                                            TextSpan(
                                                                text: "₹",
                                                                style: TextStyle(
                                                                    color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                            TextSpan(
                                                                text: '121',
                                                                style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                          ])),
                                                    ],
                                                  ),
                                                  Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ItemLabelText(text: 'Delivery Charge',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                      RichText(
                                                          text: const TextSpan( children: [
                                                            TextSpan(
                                                                text: "₹",
                                                                style: TextStyle(
                                                                    color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                            TextSpan(
                                                                text: '40',
                                                                style: TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                          ])),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ),

                                            Container(
                                              padding: EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                  color: HexColor('#DADADA'),
                                                  borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                              ),
                                              child:Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  ItemLabelText(text: 'Total Amount',style:  TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                  RichText(
                                                      text: const TextSpan( children: [
                                                        TextSpan(
                                                            text: "₹",
                                                            style: TextStyle(
                                                                color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                        TextSpan(
                                                            text: '1422',
                                                            style: TextStyle(fontSize: 16,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                      ])),
                                                ],
                                              ),

                                            )

                                          ],
                                        ),

                                      ),
                                      SizedBox(height:10),
                                      (i==0)?customOutlineButton(() {


                                      },
                                          ItemLabelText(text:'Cancel Order',style: TextStyle(fontSize: 16,color: HexColor('#F85959'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#F85959','#ffffff',context):customButton(() {

                                        }, ItemLabelText(text:'Reorder',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                                     SizedBox(height:20),
                                      customButton(() {

                                      }, ItemLabelText(text:'Share Order Details',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#C4C4C4','#ffffff',context),
                                    ],
                                  ): Container(
                                    height: MediaQuery.of(context).size.height*0.03,
                                    padding: EdgeInsets.all(6),
                                    width: MediaQuery.of(context).size.width,
                                    decoration: BoxDecoration(
                                        color: i==0?HexColor("#FFE4D0"):i==1?HexColor('#D3F3D9'):HexColor('#E9E9E9'),
                                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10) )

                                    ),
                                    child:RichText(
                                        text:  TextSpan(style: TextStyle(
                                            color: (i==0)?HexColor('#D96410'):(i==1)?HexColor('#0E8E60'):HexColor('#858E8B')),children: [
                                          TextSpan(
                                              text: "Status: ",
                                              style: TextStyle(fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                          TextSpan(
                                              text: (i==0)?'Processing':(i==1)?'Delivered yesterday 3:43 PM':'Cancelled yesterday 3:43 PM',
                                              style: TextStyle(fontSize: 12,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                                        ])),
                                  ),


                                ],
                              ),
                              Positioned(top: 10,right: 20,
                                  child: ItemLabelText(text: (i==0)?'Today 11:00 AM':(i==1)?'Yesterday 2:14 PM':'Jan 2, 2022 8:00AM',style: const TextStyle(fontSize: 12,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black),)),

                            ],
                          ),

                        ),
                      );
                    }
                  );

                }
            ),
          )
        ),
      ),
    );


  }


}