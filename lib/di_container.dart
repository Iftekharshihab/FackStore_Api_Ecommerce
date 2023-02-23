
import 'package:connectivity/connectivity.dart';
import 'package:dio/dio.dart';
import 'package:fakestoreapi_e_commerce/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestoreapi_e_commerce/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:fakestoreapi_e_commerce/data/repository/cart_repo.dart';
import 'package:fakestoreapi_e_commerce/data/repository/product_details_repo.dart';
import 'package:fakestoreapi_e_commerce/data/repository/product_repo.dart';
import 'package:fakestoreapi_e_commerce/data/repository/splash_repo.dart';
import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_details_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/splash_provider.dart';
import 'package:fakestoreapi_e_commerce/utils/app_constants.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


///-------------- Single tone-----------
final sl = GetIt.instance;

Future<void> init ()async{

  /// ---------core----------


  sl.registerLazySingleton(() => DioClient(AppConstants.BASE_URL, sl(),
      loggingInterceptor: sl(), sharedPreferences: sl()));

  /// ------------------Repository ---------------

  sl.registerLazySingleton(() => ProductRepo());
  sl.registerLazySingleton(() => SplashRepo(dioClient: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => ProductDetailsRepo(dioClient: sl(),));
  sl.registerLazySingleton(() => CartRepo(sharedPreferences: sl(),dioClient: sl()));


  ///------------------------------- Provider ------------------
  sl.registerLazySingleton(() => ProductProvider(productRepo: sl()));
  sl.registerLazySingleton(() => SplashProvider(splashRepo: sl()));
  sl.registerLazySingleton(() => ProductDetailsProvider(productDetailsRepo: sl()));
  sl.registerLazySingleton(() => CartProvider(cartRepo: sl()));




  ///--------------------Share preference -----------------
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());

  sl.registerLazySingleton(() => LoggingInterceptor());
  sl.registerLazySingleton(() => Connectivity());

}

