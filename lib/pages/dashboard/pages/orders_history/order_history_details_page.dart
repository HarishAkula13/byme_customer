
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/order_history_details_bloc.dart';
import 'bloc/orders_history_bloc.dart';

class OrdersHistoryDetailsPage extends StatefulWidget {

  @override
  OrdersHistoryDetailsPageState createState() => OrdersHistoryDetailsPageState();
}
class OrdersHistoryDetailsPageState extends State<OrdersHistoryDetailsPage>{
  OrdersHistoryDetailsBloc? _bloc;
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return LoaderContainer(
      child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            leading: IconButton(onPressed: () {
              Navigator.pop(context);
            }, icon: const Icon(Icons.arrow_back_ios,color: Colors.grey,),),
            automaticallyImplyLeading: false,
            title: ItemLabelText(text: 'Your Orders',style: const TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),),
          ),
          body: Container(
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



                              ],
                            )

                          ],
                        ),
                      ),


                    ],
                  ),
                  Positioned(top: 10,right: 20,
                      child: ItemLabelText(text:'Today 11:00 AM',style: const TextStyle(fontSize: 12,fontFamily: Inter.medium,fontWeight: FontWeight.w400,color: Colors.black),)),

                ],
              ),

            )

          )
      ),
    );


  }


}