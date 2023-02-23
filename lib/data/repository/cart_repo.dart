
import 'dart:convert';

import 'package:fakestoreapi_e_commerce/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CartRepo{

  ///------------------------Dio client instance---
  final DioClient dioClient;
  ///---------------------------Share preference instance---------------
  final SharedPreferences sharedPreferences;


  CartRepo({required this.sharedPreferences,required this.dioClient});


  ///------------------------------get cart list-------------
  List<CartModel> getCartList() {
    List<String> ? carts = sharedPreferences.getStringList(AppConstants.CART_LIST);
    List<CartModel> cartList = [];
    carts!.forEach((cart) {
      cartList.add(CartModel.fromJason(jsonDecode(cart)));
    });
    return cartList;
  }

  ///--------------------------set cart List --------------

  void addToCartList(List<CartModel> cartProductList){
    List<String> carts = [];
    cartProductList.forEach((cartModel) {
      carts.add(jsonEncode(cartModel));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, carts);
  }
}