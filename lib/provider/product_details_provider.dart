import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/data/repository/product_details_repo.dart';
import 'package:flutter/cupertino.dart';

class ProductDetailsProvider extends ChangeNotifier{
  ProductDetailsRepo productDetailsRepo;

  ProductDetailsProvider({required this.productDetailsRepo});

  /// -------- Images slider Index----
   int _imageSliderIndex = 1;
  int get imagesSliderIndex => _imageSliderIndex;

  ///---------------Quantity -------
  int  _quantity = 1;
  int get quantity => _quantity;

  ///-------  Product Model ----------

  ProductModel? _productModel = null;
  ProductModel? get productModel => _productModel;


  ///-----------------------------product Size----
  List<int> _productSizeList = [36,37,38,39,40,41,42];
  List<int> get productSizeList => _productSizeList;

  ///--------------Product size index-----

  int _productSizeIndex = -1;
  int get productSizeIndex => _productSizeIndex;


  ///--------- set Images Slider Select Index---------

  void setImagesSliderSelectIndex(int selectIndex){
    _imageSliderIndex = selectIndex;
    notifyListeners();
  }

  ///------------set quantity ----

  void setQuantity (int value){
    _quantity= value;
    notifyListeners();
  }

  /// ------------setProductSize -------

  void setProductSize(int value){
    _productSizeIndex = value;
    notifyListeners();
  }




}