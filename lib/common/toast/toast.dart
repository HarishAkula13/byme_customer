import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:toast/toast.dart';

import '../utilities/byme_colors.dart';

void ToastMessage (String msg){
  Toast.show(msg, duration: Toast.lengthShort, gravity:  Toast.bottom,backgroundColor:ByMeColors.app_color,webTexColor: Colors.white,
  backgroundRadius: 20);

}

