import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Images{

  // images
  static const String  splashLogo = "assets/images/splash_logo.png";
  static const String placeholder = 'assets/images/placeholder_1x1.png';
  static const String e_commerce_logo = 'assets/images/e_commerce_logo.png';
  static const String mlogo = 'assets/images/mlogo.png';
  static const String no_internet = 'assets/images/opps_internet.png';
  static const String no_data = 'assets/images/no_data.png';
  static const String heart = 'assets/images/heart.png';
  static const String delete = 'assets/images/delete.png';
  static const String menus = 'assets/images/menus.png';
  static const String shopping_cart = 'assets/images/shopping_cart.png';










}


currentHeight(context){
      final height = MediaQuery.of(context).size.height;
}

currentWidth(context){
   final width = MediaQuery.of(context).size.width;
}


getAnotherPage(context ,Widget widget){
  Navigator.push(context, MaterialPageRoute(builder: (context)=>widget));
}

getPageBack(context,){
  Navigator.pop(context);
}