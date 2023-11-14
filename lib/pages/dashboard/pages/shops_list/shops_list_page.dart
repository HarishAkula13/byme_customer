import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/pages/dashboard/pages/shops_list/bloc/shops_list_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';

class ShopsListPage extends StatefulWidget {
  const ShopsListPage({Key? key}) : super(key: key);

  @override
  State<ShopsListPage> createState() => _ShopsListPageState();
}

class _ShopsListPageState extends State<ShopsListPage> {
  ShopsListBloc? _bloc;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _bloc=BlocProvider.of(context);
  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        automaticallyImplyLeading: false,
        title: ItemLabelText(text: 'Shops List',style: TextStyle(fontSize: 22,color: Colors.black,fontFamily: Inter.bold),)
        ,
      ),
    );
  }
}
