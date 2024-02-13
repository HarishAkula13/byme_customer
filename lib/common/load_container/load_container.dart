import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:hexcolor/hexcolor.dart';

import 'load_indicator.dart';

class LoaderContainer extends StatelessWidget {
  final Stream<bool>? stream;
  final initialValue;
  final child;
  final Widget? childWidget;
  final Widget? bottomSheet;

  LoaderContainer({this.stream, this.initialValue = false, this.child,this.childWidget,this.bottomSheet});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
      stream: stream,
      initialData: initialValue,
      builder: (c, s) {
        return Scaffold(
          backgroundColor: Colors.white,
          body: Stack(
            children: <Widget>[
              SvgPicture.asset('assets/images/bg.svg',width: Get.width,fit: BoxFit.fitWidth,),
              if (child != null) ...[child],
              (bottomSheet!=null)?SizedBox():Positioned.fill(child: _getIndicator(s.data ?? false)),
            ],
          ),
          bottomSheet: Stack(
            children: [
              (bottomSheet!=null)?bottomSheet!:SizedBox(),
              (bottomSheet!=null)?Positioned.fill(child: _getIndicator(s.data ?? false)):SizedBox()

            ],
          ),
        );
      },
    );
  }

  _getIndicator(bool isLoading) {
    if (isLoading) {
      return Container(
        color: Colors.white.withOpacity(0.5),
        child: Center(
          child: LoaderIndicator(),
        ),
      );
    } else {
      return Container();
    }
  }
}
