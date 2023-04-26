
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../app/arch/bloc_provider.dart';
import '../../../../common/button/byme_outline_button.dart';
import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import 'bloc/orders_bloc.dart';

class OrdersPage extends StatefulWidget {

  @override
  OrdersPageState createState() => OrdersPageState();
}
class OrdersPageState extends State<OrdersPage>{
  OrdersBloc? _bloc;
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
          title: ItemLabelText(text: '',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),)
          ,
        ),
        body: Container(),
    );


  }


}