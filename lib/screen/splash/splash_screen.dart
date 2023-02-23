
import 'dart:async';

import 'package:fakestoreapi_e_commerce/provider/product_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/splash_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/home/home_screen.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _route();
  }


  _route(){
    Provider.of<SplashProvider>(context,listen: false).initSharedPreferencesData();
     Provider.of<ProductProvider>(context,listen: false).getProductList();

    Timer(const Duration(seconds: 2),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const HomeScreen()));
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 250.0,
              width: 250.0,
              child: Image.asset(Images.splashLogo),
            ),
            const CircularProgressIndicator(color:Colors.blue,),
          ],
        ),
      ),
    );
  }
}
