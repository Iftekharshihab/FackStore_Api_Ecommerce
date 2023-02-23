
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:flutter/material.dart';

const titilliumRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeSmall,
);
const titleRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w500,
  fontSize: Dimensions.fontSizeDefault,

);
const titleHeader = TextStyle(
  fontFamily: 'Ubuntu',
  fontWeight: FontWeight.w600,
  fontSize: Dimensions.fontSizeLarge,

);
const titilliumSemiBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeSmall,
  fontWeight: FontWeight.w600,
);

const titilliumBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w700,
);
const titilliumItalic = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeDefault,
  fontStyle: FontStyle.italic,
);

const robotoRegular = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeDefault,
);

const robotoBold = TextStyle(
  fontFamily: 'Ubuntu',
  fontSize: Dimensions.fontSizeDefault,
  fontWeight: FontWeight.w700,
);


textFieldDecoration(){
  return BoxDecoration(
    color: ColorResources.textBg,
    borderRadius: BorderRadius.circular(30),
  );

}

snackBar (String msg){
  return  SnackBar(
    content:  Text(msg,style: titilliumRegular.copyWith(color: ColorResources.white),),
    backgroundColor: ColorResources.lightSkyBlue,
  );
}





