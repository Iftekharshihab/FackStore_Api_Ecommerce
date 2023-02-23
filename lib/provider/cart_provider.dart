
import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/data/repository/cart_repo.dart';
import 'package:flutter/cupertino.dart';

class CartProvider extends ChangeNotifier {
  final CartRepo cartRepo;
  CartProvider({required this.cartRepo});

  ///----------------Cart List-------

  List<CartModel> _cartList = [];
  List<CartModel> get cartList => _cartList;

  ///------------Amount---------
  double _amount = 0.0;
  double get amount => _amount;

  ///---------- select list-----
  List<bool> _isSelectList = [];
  List<bool> get isSelectList => _isSelectList;

  ///---------------selectAll --------

  bool _isSelectAll = true;
  bool get isAllSelect => _isSelectAll;

  ///-------------get Cart Data -------

  void getCartData() {
    _cartList = [];
    _cartList.addAll(cartRepo.getCartList());
  }

  ///----------------Add To Cart------

  void addToCart(CartModel cartModel) {
    _cartList.add(cartModel);
    _isSelectList.add(true);
    cartRepo.addToCartList(_cartList);
    _amount = _amount + (cartModel.productModel!.price * cartModel.quantity);
    notifyListeners();
  }

  ///-------------remove from cart----

  void removeFromCart(int index) {
    if (_isSelectList[index]) {
      _amount = _amount -
          (_cartList[index].productModel!.price * _cartList[index].quantity);
    }
    _cartList.removeAt(index);
    _isSelectList.removeAt(index);
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  ///---------- remove and checkout product--------

  void removeCheckOutProduct(List<CartModel> carts) {
    carts.forEach((cart) {
      _amount = _amount - (cart.productModel!.price * cart.quantity);
      _cartList.removeWhere(
              (cartModel) =>
          cartModel.productModel!.id == cart.productModel!.id);

      _isSelectList.removeWhere((selected) => selected);
    });

    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }

  ///-------------------set quantity-------------

  void setQuantity(bool isIncrement, int index) {
    if (isIncrement) {
      _cartList[index].quantity = _cartList[index].quantity + 1;
      _isSelectList[index]
          ? _amount = _amount + _cartList[index].productModel!.price
          : _amount = _amount;
    } else {
      _cartList[index].quantity = _cartList[index].quantity - 1;
      _isSelectList[index]
          ? _amount = _amount - _cartList[index].productModel!.price
          : _amount = _amount;
    }
    cartRepo.addToCartList(_cartList);
    notifyListeners();
  }


}
