
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
import '../../../../model/order_list/orders_list.dart';
import 'bloc/orders_history_bloc.dart';

class OrdersHistoryPage extends StatefulWidget {

  @override
  OrdersHistoryPageState createState() => OrdersHistoryPageState();
}
class OrdersHistoryPageState extends State<OrdersHistoryPage>{
  OrdersHistoryBloc? _bloc;
  static OrdersList? order;
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

            child: StreamBuilder<List<OrdersList>>(
              initialData: [],
              stream: _bloc!.ordersList,
              builder: (c, s) {
                return ListView.builder(
                    itemCount: s.data!.length,
                    shrinkWrap: true,
                    physics: const ScrollPhysics(),
                    itemBuilder: (b,i){
                      return StreamBuilder<Tuple2<int,bool>>(
                        initialData: const Tuple2(-1,false),
                        stream: _bloc!.selectPos,
                        builder: (context, sp) {
                          return GestureDetector(
                            onTap: (){


                                //_bloc!.onNavigate(1,i);
                              _bloc!.addSelectPos.add(Tuple2(i, !sp.data!.item2));
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
                                           Image.network(s.data![i].shopPhoto ?? s.data![i].shopCategoryImg!,height: 60,width: 60,errorBuilder: (BuildContext context, Object error,
                                               StackTrace? stackTrace) {
                                             return Container(
                                               height: 60,width: 60,
                                               decoration: const BoxDecoration(
                                                 color: Colors.grey,
                                                 borderRadius: BorderRadius.all(Radius.circular(10))
                                               ),
                                             );
                                           },),
                                            const SizedBox(width: 15,),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                ItemLabelText(text: (s.data![i].productInfo!=null)?'${s.data![i].productInfo!.length} items':'',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w600,color: Colors.black),),
                                                const SizedBox(height: 5,),
                                                RichText(
                                                    text:  TextSpan(style: const TextStyle(fontSize: 12), children: [
                                                      const TextSpan(
                                                          text: "from  ",
                                                          style: TextStyle(
                                                              color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                                                      TextSpan(
                                                          text:s.data![i].shopName ?? (s.data![i].servcieOwnerName ?? ''),
                                                          style: const TextStyle(fontSize: 12,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black)),
                                                    ])),
                                                const SizedBox(height: 5,),
                                                RichText(
                                                    text:  TextSpan( children: [
                                                      const TextSpan(
                                                          text: "₹",
                                                          style: TextStyle(
                                                              color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                      TextSpan(
                                                          text: (s.data![i].orderCost!=null)?s.data![i].orderCost.toString():(s.data![i].total!=null)?s.data![i].total.toString():'',
                                                          style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                    ])),

                                              ],
                                            )

                                          ],
                                        ),
                                      ),
                                      (sp.data!.item2==true&&sp.data!.item1==i)?Column(
                                        children: [
                                          const Padding(
                                            padding: EdgeInsets.only(left: 10.0,right: 10),
                                            child: DottedLine(
                                              direction: Axis.horizontal,
                                              dashColor: Colors.grey,
                                            ),
                                          ),
                                          (s.data![i].productInfo!=null)?ListView.builder(
                                              itemCount: s.data![i].productInfo!.length,
                                              shrinkWrap: true,
                                              physics: const ScrollPhysics(),
                                              itemBuilder: (c,ind){
                                                return Container(
                                                  margin: const EdgeInsets.only(left: 10,right: 10,top: 10),
                                                  padding: const EdgeInsets.all(10),
                                                  width: MediaQuery.of(context).size.width,
                                                  decoration: BoxDecoration(
                                                    color: HexColor('#F5F5F5'),
                                                    borderRadius: const BorderRadius.all(Radius.circular(10))

                                                  ),
                                                  child: Stack(
                                                   children: [
                                                     Row(
                                                       children: [
                                                       Container(
                                                         height: 40,width: 40,
                                                         decoration: const BoxDecoration(
                                                           color: Colors.grey,
                                                           borderRadius: BorderRadius.all(Radius.circular(10))
                                                         ),
                                                       ),
                                                         const SizedBox(width: 10,),
                                                         Column(
                                                           mainAxisAlignment: MainAxisAlignment.start,
                                                           crossAxisAlignment: CrossAxisAlignment.start,
                                                           children: [
                                                             ItemLabelText(text:  s.data![i].productInfo![ind].productName??'',style: const TextStyle(fontSize: 14,fontFamily: Inter.regular,fontWeight: FontWeight.w600,color: Colors.black),),
                                                             Container(
                                                               margin: const EdgeInsets.only(top: 5),
                                                               alignment: Alignment.center,
                                                               height: 30,
                                                               width: 50,
                                                               decoration: BoxDecoration(
                                                                   color: HexColor('#E9E9E9'),
                                                                   borderRadius: const BorderRadius.all(Radius.circular(15))

                                                               ),
                                                               child: ItemLabelText(text:  '${s.data![i].productInfo![ind].qty} ${s.data![i].productInfo![ind].unit}',style: const TextStyle(fontSize: 11,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black),),


                                                             )

                                                           ],
                                                         ),


                                                       ],
                                                     ),
                                                     Positioned(top: 10,right: 20,
                                                         child: ItemLabelText(text: s.data![i].productInfo![ind].amount.toString() ?? '',style: const TextStyle(fontSize: 18,fontFamily: Inter.bold,fontWeight: FontWeight.w500,color: Colors.black),)),

                                                   ],
                                                  ),
                                                );


                                              }):const SizedBox(),
                                          Container(
                                            margin: const EdgeInsets.all( 10),
                                            decoration: BoxDecoration(
                                                color: HexColor('#F5F5F5'),
                                                borderRadius: const BorderRadius.all(Radius.circular(10))

                                            ),
                                            child: Column(
                                              children: [
                                                Container(
                                                  padding: const EdgeInsets.all( 10),

                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ItemLabelText(text: 'Subtotal',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                          RichText(
                                                              text:  TextSpan( children: [
                                                                const TextSpan(
                                                                    text: "₹",
                                                                    style: TextStyle(
                                                                        color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                                TextSpan(
                                                                    text: s.data![i].subTotal.toString() ?? '',
                                                                    style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                              ])),
                                                        ],
                                                      ),
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ItemLabelText(text: 'GST',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                          RichText(
                                                              text:  TextSpan( children: [
                                                                const TextSpan(
                                                                    text: "₹",
                                                                    style: TextStyle(
                                                                        color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                                TextSpan(
                                                                    text: s.data![i].gst.toString() ?? '',
                                                                    style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                              ])),
                                                        ],
                                                      ),
                                                      s.data![i].deliveryCharges!=null?Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          ItemLabelText(text: 'Delivery Charge',style:  TextStyle(fontSize: 14,color: HexColor('#828785'),fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                          RichText(
                                                              text:  TextSpan( children: [
                                                                const TextSpan(
                                                                    text: "₹",
                                                                    style: TextStyle(
                                                                        color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                                TextSpan(
                                                                    text: s.data![i].deliveryCharges.toString() ?? '',
                                                                    style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                              ])),
                                                        ],
                                                      ):const SizedBox(),
                                                    ],
                                                  ),
                                                ),

                                                Container(
                                                  padding: const EdgeInsets.all(8),
                                                  decoration: BoxDecoration(
                                                      color: HexColor('#DADADA'),
                                                      borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight: Radius.circular(10))
                                                  ),
                                                  child:Row(
                                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      ItemLabelText(text: 'Total Amount',style:  const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.regular,fontWeight: FontWeight.w500),),
                                                      RichText(
                                                          text:  TextSpan( children: [
                                                            const TextSpan(
                                                                text: "₹",
                                                                style: TextStyle(
                                                                    color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                                            TextSpan(
                                                                text:  (s.data![i].orderCost!=null)?s.data![i].orderCost.toString():(s.data![i].total!=null)?s.data![i].total.toString():'',
                                                                style: const TextStyle(fontSize: 16,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                                          ])),
                                                    ],
                                                  ),

                                                )

                                              ],
                                            ),

                                          ),
                                          const SizedBox(height:10),
                                          (s.data![i].orderStatus!.contains('Process'))?customOutlineButton(() {


                                          },
                                              ItemLabelText(text:'Cancel Order',style: TextStyle(fontSize: 16,color: HexColor('#F85959'),fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#F85959','#ffffff',context):
                                          customButton(() {

                                            }, ItemLabelText(text:'Reorder',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                                         const SizedBox(height:20),
                                          customButton(() {

                                          }, ItemLabelText(text:'Share Order Details',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#C4C4C4','#ffffff',context),
                                        ],
                                      ): Container(
                                        height: MediaQuery.of(context).size.height*0.03,
                                        padding: const EdgeInsets.all(6),
                                        width: MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                            color:  (s.data![i].orderStatus!.contains('Process'))?HexColor("#FFE4D0"):(s.data![i].orderStatus!.contains('Cancel'))?HexColor('#E9E9E9'):HexColor('#D3F3D9'),
                                            borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10),bottomRight:Radius.circular(10) )

                                        ),
                                        child:RichText(
                                            text:  TextSpan(style: TextStyle(
                                                color: (s.data![i].orderStatus!.contains('Process'))?HexColor('#D96410'):(s.data![i].orderStatus!.contains('Cancel'))?HexColor('#858E8B'):HexColor('#0E8E60')),children: [
                                              const TextSpan(
                                                  text: "Status: ",
                                                  style: TextStyle(fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                              TextSpan(
                                                  text:s.data![i].orderStatus,
                                                  style: const TextStyle(fontSize: 12,fontFamily: Inter.regular,fontWeight: FontWeight.w400)),
                                            ])),
                                      ),


                                    ],
                                  ),
                                  Positioned(top: 10,right: 20,
                                      child: ItemLabelText(text: s.data![i].orderDateTime ?? '',style: const TextStyle(fontSize: 12,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black),)),

                                ],
                              ),

                            ),
                          );
                        }
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