import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'common/utilities/byme_colors.dart';
import 'di/app_injector.dart';
void main() {
  runApp( MaterialApp(home: AppInjector.instance.app));
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    //statusBarColor: ByMeColors.white_color, // status bar color
  ));

}

