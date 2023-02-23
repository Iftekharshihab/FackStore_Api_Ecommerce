import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_details_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/splash_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/splash/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'di_container.dart' as di;


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  runApp(MultiProvider(
      providers: providers,
    child:  const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
     
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}


List<SingleChildWidget>providers=[
  ChangeNotifierProvider<ProductProvider>(create:(_)=> di.sl<ProductProvider>()),
  ChangeNotifierProvider<SplashProvider>(create:(_)=> di.sl<SplashProvider>()),
  ChangeNotifierProvider<ProductDetailsProvider>(create:(_)=> di.sl<ProductDetailsProvider>()),
  ChangeNotifierProvider<CartProvider>(create:(_)=> di.sl<CartProvider>()),

];