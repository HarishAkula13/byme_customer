
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../utilities/byme_colors.dart';
import '../../utilities/fonts.dart';

void imageBottomSheet({required  Function(String type) onCallback}){
  showModalBottomSheet(
      isDismissible: false,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15)),
      ),
      backgroundColor: Colors.white,
      context: Get.context!, builder: (BuildContext context){

    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(topRight: Radius.circular(15),topLeft:Radius.circular(15) )
      ),

      height: 150,
      alignment: Alignment.center,

      child:  Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(icon: Icon(Icons.cancel_outlined,color: Colors.red),onPressed: (){
              Navigator.pop(context);
            }),
          ),
          SizedBox(height: 10,),
          InkWell(
            onTap: (){
              Navigator.pop(context);
              onCallback('Cam');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt_outlined,color: ByMeColors.app_color,size: 26,),
                SizedBox(width: 10,),
                Text('Camera', style: TextStyle(fontSize:18 ,color:Colors.black,fontFamily: Inter.semiBold),),
              ],
            ),
          ),
          SizedBox(height: 20,),
          InkWell(
            onTap: (){
              Navigator.pop(context);
              onCallback('Gal');
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.photo,color: ByMeColors.app_color,size: 26,),
                SizedBox(width: 10,),
                Text('Gallery', style:TextStyle(fontSize:18 ,color: Colors.black,fontFamily: Inter.semiBold),),
              ],
            ),
          ),
        ],
      ),

    );
  });
}

Future<File?> getImageFromCamera() async {
  var image = await ImagePicker.platform
      .pickImage(source: ImageSource.camera, imageQuality: 50);

  if (image != null) {
    return File(image.path);
  } else {
    return null;
    print('No image selected.');
  }

}

Future<File?> getImageFromGallery() async {
  var image = await ImagePicker.platform
      .pickImage(source: ImageSource.gallery, imageQuality: 50);

  if (image != null) {
    return File(image.path);
  } else {
    return null;
  }

}
