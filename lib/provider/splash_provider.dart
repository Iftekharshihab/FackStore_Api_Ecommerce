import 'package:fakestoreapi_e_commerce/data/repository/splash_repo.dart';
import 'package:flutter/foundation.dart';

class SplashProvider extends ChangeNotifier{

  final SplashRepo splashRepo;
  SplashProvider({required this.splashRepo});

  void initSharedPreferencesData(){
    splashRepo.initShareData();
  }
}