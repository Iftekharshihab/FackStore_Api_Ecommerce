
import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/data/repository/product_repo.dart';
import 'package:flutter/foundation.dart';

class ProductProvider extends ChangeNotifier{

  final ProductRepo productRepo;
  ProductProvider({required this.productRepo});

  List<ProductModel> _productList=[];
  List<ProductModel> get productList=>_productList;



  void getProductList() async {
    _productList.clear();
    _productList= await productRepo.getProduct();
    print("Product:");
    print(_productList.length);
    print("------------------------$_productList");
    notifyListeners();
  }


}