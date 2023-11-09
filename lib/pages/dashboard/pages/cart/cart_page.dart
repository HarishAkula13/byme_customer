

import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/di/app_injector.dart';
import 'package:byme_app/di/i_home_page.dart';
import 'package:byme_app/model/order_list/cart_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/button/byme_button.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/cart_bloc.dart';

class CartPage extends StatefulWidget{
  const CartPage({super.key});


  @override
  CartPageState createState()=> CartPageState();
}
class CartPageState extends State<CartPage>{
  CartBloc? _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Colors.white ,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leadingWidth: 205,
        leading:InkWell(
          onTap: (){
       // Navigator.pop(context);
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 14.0),
            child: Row(
              children: [
                const Icon(Icons.arrow_back_ios_new_rounded,color: Colors.grey,size: 16,),
                const SizedBox(width: 10,),
                ItemLabelText(text: 'Cart',style: const TextStyle(fontSize: 20,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w700),)
              ],
            ),
          ),
        ),
      ),
      body: LoaderContainer(
        stream: _bloc!.isLoading,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.white,
          child: StreamBuilder<List<CartList>>(
            initialData: [],
            stream: _bloc!.cartList,
            builder: (context, s) {
              return ListView.builder(
                  itemCount: s.data!.length,
                  shrinkWrap: true,
                  physics: const ScrollPhysics(),
                  itemBuilder: (b,i){
                    return Container(
                        height: 90,
                        margin: const EdgeInsets.only(left: 20,right: 20,top: 10),
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: HexColor("#F5F5F5"),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(right: 10),
                              height: 44,
                                alignment: Alignment.center,
                                width: 44,
                                decoration: BoxDecoration(
                                    color: HexColor("#E7F6EA"),
                                    borderRadius: const BorderRadius.all(Radius.circular(10))
                                ),
                                child: (s.data![i].productImage!=null)?Image.network(s.data![i].productImage!):SvgPicture.asset('assets/images/Construction.svg',height: 24,width: 24,)),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ItemLabelText(text: (s.data![i].productName!=null)?s.data![i].productName:s.data![i].category,style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.bold,fontWeight: FontWeight.w500),),
                                const SizedBox(height: 5,),
                                Container(
                                    height: 20,
                                    alignment: Alignment.center,
                                    width: 100,
                                    decoration: BoxDecoration(
                                        color: HexColor("#E9E9E9"),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: ItemLabelText(text:  (s.data![i].unit!=null)?"${s.data![i].qty}/${s.data![i].unit}":'${s.data![i].subCategory} - 1 No',style: const TextStyle(fontSize: 11,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w400),)),


                              ],
                            ),
                            const SizedBox(width: 20,),
                            StreamBuilder<String>(
                              initialData: '',
                              stream: _bloc!.cartPrice,
                              builder: (context, s) {
                                return RichText(
                                    text:  TextSpan( children: [
                                      const TextSpan(
                                          text: "₹",
                                          style: TextStyle(
                                              color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                                      TextSpan(
                                          text: s.data.toString(),
                                          style: const TextStyle(fontSize: 20,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                                    ]));
                              }
                            ),
                           const Spacer(),
                            IconButton(onPressed: (){
                              _bloc!.removeCart(s.data![i]);

                            }, icon: Icon(Icons.close,color: HexColor("#858E8B"),size: 16,))
                          ],
                        )
                    );
                  });
            }
          ),
        ),
      ),

      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(20),
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
          child: StreamBuilder<CartList>(
            initialData: null,
            stream: _bloc!.cartPricesInfo,
            builder: (context, sp) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: 'Base Amount: ',style: TextStyle(fontSize: 14,color: HexColor('#858E8B'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                        RichText(
                            text:  TextSpan( children: [
                              const TextSpan(
                                  text: "₹",
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                              TextSpan(
                                  text: '${(sp.data!=null)?sp.data!.baseCharges ?? '':''}',
                                  style: const TextStyle(fontSize: 16,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                            ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: 'GST: ',style: TextStyle(fontSize: 14,color: HexColor('#858E8B'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                        RichText(
                            text:  TextSpan( children: [
                              const TextSpan(
                                  text: "₹",
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                              TextSpan(
                                  text: '${(sp.data!=null)?sp.data!.gst ?? '':''}',
                                  style: const TextStyle(fontSize: 16,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                            ]))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: 'Total Amount: ',style: TextStyle(fontSize: 16,color: HexColor('#858E8B'),fontFamily: Inter.medium,fontWeight: FontWeight.w500),),

                        RichText(
                            text:  TextSpan( children: [
                              const TextSpan(
                                  text: "₹",
                                  style: TextStyle(
                                      color: Colors.grey, fontFamily: Inter.regular,fontWeight: FontWeight.w400,fontSize: 12)),
                              TextSpan(
                                  text: '${(sp.data!=null)?sp.data!.total ?? '':''}',
                                  style: const TextStyle(fontSize: 18,fontFamily: Inter.medium,fontWeight: FontWeight.w700,color: Colors.black)),
                            ]))
                      ],
                    ),
                  ),
                  const SizedBox(height: 20,),
                  customButton(() {
                    _bloc!.submit.add(null);
                  }, ItemLabelText(text:'Pay',style: const TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular)),'#00B05A','#ffffff',context),

                ],
              );
            }
          ),
        ),
      ),

    );
  }


}