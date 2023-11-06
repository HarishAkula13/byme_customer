import 'package:byme_app/app/arch/bloc_provider.dart';
import 'package:byme_app/common/load_container/load_container.dart';
import 'package:byme_app/pages/dashboard/pages/shops/bloc/near_shop_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../../../common/label/item_label_text.dart';
import '../../../../common/utilities/fonts.dart';
import '../../../../model/dashboard/menu.dart';

class NearShops extends StatefulWidget {
  const NearShops({super.key});

  @override
  _NearShopsState createState() => _NearShopsState();
}

class _NearShopsState extends State<NearShops> {
  NearShopsBloc? bloc;
  @override
  void initState() {
  bloc=BlocProvider.of(context);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: LoaderContainer(
        stream: bloc!.isLoading,
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50,),
              StreamBuilder<List<Menu>>(
                  initialData: [],
                  stream: bloc!.shopCategories,
                  builder: (context, s) {
                    return SizedBox(
                      height: 100,
                      child: ListView.builder(
                          itemCount: s.data!.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (b,i){
                            return  Padding(
                              padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                              child: GestureDetector(
                                onTap: (){

                                },
                                child: Column(
                                  children: [
                                    CircleAvatar(
                                        radius: 25,
                                        backgroundColor:HexColor('#E7F6EA'),
                                        child: SvgPicture.asset(s.data![i].icon!)),
                                    const SizedBox(height: 10,),
                                    ItemLabelText(text: s.data![i].title!,textAlignment: TextAlign.center,style: const TextStyle(fontFamily: Inter.medium,fontSize: 11,color: Colors.black,fontWeight: FontWeight.w400),)
                                  ],
                                ),
                              ),
                            );
                          }),
                    );



                  }
              )
            ],
          ),
        ),
      ),
    );
  }
}
