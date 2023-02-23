import 'package:dio/dio.dart';
import 'package:fakestoreapi_e_commerce/data/datasource/remote/dio/dio_client.dart';
import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/utils/app_constants.dart';

class ProductRepo {
  ProductRepo();
  /*
  final DioClient dioClient;
  ProductRepo({required this.dioClient});*/

  ///----------------Product from api
  Future<List<ProductModel>> getProduct() async {
    try {
      Response response =
          await Dio().get(AppConstants.BASE_URL + AppConstants.PRODUCTLIST);
      List<ProductModel> productList = [];

      for (var product in response.data) {
        productList.add(ProductModel.fromJson(product));
      }
      return productList;
    } catch (error, stacktrace) {
      print("Exception occurred: $error stackTrace: $stacktrace");
      return [];
    }
  }
}
