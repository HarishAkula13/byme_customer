import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';
import '../../../../common/label/item_label_text.dart';
import '../../app/arch/bloc_provider.dart';
import '../../common/button/byme_button.dart';
import '../../common/textfield/byme_text_field.dart';
import '../../common/utilities/byme_colors.dart';
import '../../common/utilities/fonts.dart';
import 'bloc/order_details_bloc.dart';

class OrderDetailsPage extends StatefulWidget {

  @override
  OrderDetailsPageState createState() => OrderDetailsPageState();
}
class OrderDetailsPageState extends State<OrderDetailsPage>{
  OrderDetailsBloc? _bloc;
  FocusNode _pilotFocus = FocusNode();
  FocusNode _amuntFocus = FocusNode();
  @override
  void initState() {
    _bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: ItemLabelText(text: 'New Order',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),)
        ,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
                padding: EdgeInsets.all(20),
                child: ItemLabelText(text: 'Details',style: TextStyle(fontSize: 16,color: Colors.black,fontFamily: Inter.bold),)),
            Divider(color: HexColor('#CDD0CF'),thickness: 1,),
            Container(
              margin: EdgeInsets.all(10),
              padding: EdgeInsets.all(20),

              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              ItemLabelText(text: 'ID: ',style: TextStyle(fontSize: 12,color: ByMeColors.icon_un_select,fontFamily: Inter.regular),),
                              ItemLabelText(text: '4820 5790',style: TextStyle(fontSize: 12,color: Colors.black,fontFamily: Inter.semiBold),),
                              SizedBox(width: 5,),
                              Icon(Icons.circle_sharp,size: 3,color: HexColor('#C4C4C4'),),
                              SizedBox(width: 5,),
                              ItemLabelText(text: '6:30 PM',style: TextStyle(fontSize: 12,color: ByMeColors.icon_un_select,fontFamily: Inter.regular),),

                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              ItemLabelText(text: 'Total Bill: ',style: TextStyle(fontSize: 12,color: ByMeColors.icon_un_select,fontFamily: Inter.regular),),
                              ItemLabelText(text: '₹645.00 ',style: TextStyle(fontSize: 12,color: Colors.black,fontFamily: Inter.semiBold,decoration: null),),
                            ],
                          ),
                          SizedBox(height: 8,),
                          Row(
                            children: [
                              SizedBox(
                                  width: 107,
                                  child: ItemLabelText(text: 'Bike Repair',overflow:TextOverflow.ellipsis,style: TextStyle(fontSize: 12,color: Colors.black,fontFamily: Inter.bold),)),

                            ],
                          ),
                        ],
                      ),

                    ],
                  ),
                  SizedBox(height: 15,),
                  Container(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ItemLabelText(text: 'Service Details',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium, fontWeight: FontWeight.w600,),),
                        SizedBox(height: 10,),
                        ItemLabelText(text: 'Service name: Carpentry (Pilot service) ',style: TextStyle(fontSize: 14,color: HexColor('#151716'),fontFamily: Inter.regular,fontWeight: FontWeight.w400,),),
                        SizedBox(height: 15,),
                        ItemLabelText(text: 'Description of work',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium, fontWeight: FontWeight.w600,),),
                        SizedBox(height: 10,),
                        ItemLabelText(text: 'Cup boards need to be installed at home.Approx area is 120 sft.',style: TextStyle(fontSize: 14,color: HexColor('#151716'),fontFamily: Inter.regular,fontWeight: FontWeight.w400,),),
                        SizedBox(height: 15,),
                        ItemLabelText(text: 'Additional Instructions',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium, fontWeight: FontWeight.w600,),),
                        SizedBox(height: 10,),
                        ItemLabelText(text: 'Raw material type of material is PVC. PVC rela-ted experts are needed. ',style: TextStyle(fontSize: 14,color: HexColor('#151716'),fontFamily: Inter.regular,fontWeight: FontWeight.w400,),),
                        SizedBox(height: 15,),
                        ItemLabelText(text: 'Ordered By',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium, fontWeight: FontWeight.w600,),),
                        SizedBox(height: 10,),
                        ItemLabelText(text: 'Chandu',style: const TextStyle(fontSize: 14,color: Colors.black,fontFamily: Inter.medium, fontWeight: FontWeight.w600,),),
                        SizedBox(
                            width: 150,
                            height: 60,
                            child: ItemLabelText(text: 'Love dale, 11D Cross,3 Lane, MG Road',style: TextStyle(fontSize: 14,color: HexColor('#151716'),fontFamily: Inter.regular,fontWeight: FontWeight.w400,),)),

                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
      bottomSheet: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
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
          child: StreamBuilder<int>(
            initialData: 0,
            stream: _bloc!.dialogType,
            builder: (context, snapshot) {
              return Column(
                children: [
                  SizedBox(height: 20,),
                  SvgPicture.asset('assets/images/verify.svg'),
                  SizedBox(height: 10,),
                  ItemLabelText(text:'Congratulations! \n Money sent.',textAlignment:TextAlign.center,style: TextStyle(fontSize: 18,color: Colors.black,fontFamily: Inter.medium,fontWeight: FontWeight.w700)),
                  SizedBox(height: 15,),
                  customButton(() {
                    Navigator.pop(context);
                  }, ItemLabelText(text:'Service Orders',style: TextStyle(fontSize: 16,color: Colors.white,fontFamily: Inter.regular,fontWeight: FontWeight.w500)),'#00B05A','#ffffff',context),
                  SizedBox(height: 10,),
                  RichText(
                    text:  TextSpan(
                      text: 'Facing issue?',
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: Inter.regular,
                          fontWeight: FontWeight.w400
                      ),
                      children: [
                        TextSpan(
                          text: ' Chat with Assistant',
                          style: TextStyle(
                              color: HexColor('#0E8E60'),
                              fontFamily: Inter.regular,
                              fontWeight: FontWeight.w600
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
          ),

        ),
      ),
    );


  }


}