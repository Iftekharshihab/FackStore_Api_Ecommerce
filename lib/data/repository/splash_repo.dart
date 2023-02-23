
import 'package:fakestoreapi_e_commerce/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestoreapi_e_commerce/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo{

  ///------------------------Dio Client------------
  final DioClient dioClient;

  ///----------------------------SharePreference----------------
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.dioClient,required this.sharedPreferences});

  void initShareData() async{
    if(!sharedPreferences.containsKey(AppConstants.CART_LIST)){
      sharedPreferences.setStringList(AppConstants.CART_LIST, []);
    }
  }

}