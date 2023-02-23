
import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/cart/widget/card_widget.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:fakestoreapi_e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  final bool fromCheckout;
  final int sellerId;
   CartScreen({Key? key, this.fromCheckout = false,  this.sellerId =1}) : super(key: key);
  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<CartProvider>(context, listen: false).getCartData();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CartProvider>(
      builder: (context,cart,child){
        double amount = 0.0;
        double shippingAmount = 0.0;
        List<CartModel> cartList = [];
        cartList.addAll(cart.cartList);

        for(int i = 0; i<cart.cartList.length; i++){
          amount += (cart.cartList[i].productModel!.price) * cart.cartList[i].quantity;
        }
        return Scaffold(

          ///--------------total price and checkout button
          bottomNavigationBar: Container(
            height: 80,
            padding: const EdgeInsets.symmetric(
              horizontal: Dimensions.paddingSizeLarge,
              vertical: Dimensions.paddingSizeDefault,
            ),
            decoration:  const BoxDecoration(
              color: Colors.grey,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(10),
                topLeft: Radius.circular(10),
              ),
            ),

            child: cartList.isNotEmpty ?
                Row(
                  children: [
                    Expanded(
                        child: Center(
                          child: Row(
                            children: [
                              Text("Total Price: ",
                              style: titilliumBold.copyWith(
                                fontSize: Dimensions.fontSizeLarge
                              ),
                              ),
                              Text(
                                "\$ ${(amount + shippingAmount).toStringAsFixed(2)}",
                                style: titilliumBold.copyWith(
                                    fontSize: Dimensions.fontSizeLarge,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        )
                    ),

                    Builder(
                        builder: (context){
                          return InkWell(
                            onTap: (){
                              orderCompleteDialog(context);
                              Provider.of<CartProvider>(context,listen: false).removeCheckOutProduct(cartList);
                            },
                            child:  Container(
                              alignment: Alignment.center,
                              width: MediaQuery.of(context).size.width / 2.5,
                              decoration:BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blueGrey,
                              ),
                              child: Text(
                                "Checkout",
                                style: titilliumBold.copyWith(fontSize:
                                20,color: ColorResources.white,
                                ),
                              ),
                            ),
                          );
                        }
                    )
                  ],
                ):const SizedBox(),
          ),

          body: ListView(
            children: [
              AppBar(
                title:Text("Cart",
                  style: titilliumRegular.copyWith(fontSize: Dimensions.fontSizeLarge,color: ColorResources.black),
                ),
                backgroundColor: ColorResources.white,
               // elevation: 0,
                leading:
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },icon: Icon(Icons.keyboard_arrow_left,size: 25,color: ColorResources.black,),
                ),
              ),

              Card(
                child: Container(
                 /* padding: EdgeInsets.only(
                    bottom: Dimensions.paddingSizeExtraLarge,
                  ),*/
                  color: ColorResources.white,
                 ///------------------card section---
                  child: ListView.builder(
                    itemCount: cartList.length,
                    physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      padding: EdgeInsets.all(0),
                      itemBuilder: (context, i){
                        return CardWidget(
                          cartModel: cartList[i],
                          index: i,
                          fromCheckout: widget.fromCheckout,
                        );
                      }
                  ),
                ),
              ),

            ],
          ),

        );
      },
    );
  }
}



orderCompleteDialog(BuildContext context){
  return showDialog(
      context: context,
      builder: (BuildContext context){
        return  AlertDialog(
          title:  Text("Order Complete"),
          content: Text("Congratulation! Your order has been successfully placed."),
          actions: [
            TextButton(
                onPressed: (){
                  Navigator.pop(context);
                },
                child: Text("Ok")
            ),
          ],
        );
      }
  );
}


