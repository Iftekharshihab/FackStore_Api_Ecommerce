import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/product_details/product_details_screen.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:fakestoreapi_e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductWidget extends StatelessWidget {
  ProductWidget({
    Key? key,
    required this.cw,
    required this.productModel,
    required this.index,
  }) : super(key: key);

  final double cw;

  ProductModel productModel;
  int index;

  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: (){
        Navigator.push(context, PageRouteBuilder(
          transitionDuration:Duration(milliseconds: 1000) ,
            pageBuilder: ((context, animation, secondaryAnimation) => ProductDetails(
              productModel: productModel,index: index,
            )),
        ));
      },
      ///---- ---- First container-------
      child: Container(
        height: cw - 20,
        width: cw - 40,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index.isEven ? ColorResources.cart1Bg : ColorResources.cart2Bg,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [

            SizedBox(
              height: cw - 135,
              width: cw - 40,
              child: Stack(
                children: [
                  ///----------routed container-------
                  Container(
                    height: cw / 2,
                    width: cw / 2,
                    alignment: Alignment.center,
                    margin: index.isEven
                        ? const EdgeInsets.only(
                            left: 60,
                            right: 60,
                            top: 60,
                            bottom: 20,
                          )
                        : const EdgeInsets.only(
                            left: 60, right: 60, top: 10, bottom: 60),
                    transform: Matrix4.translationValues(0.33, 0.33, 0.33)
                      ..rotateZ((index.isEven ? -28 : 28) / 180),
                    decoration: BoxDecoration(
                      color: index.isEven
                          ? ColorResources.cart1Shape
                          : ColorResources.cart2Shape,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),


                  ///------------images section---
                  Positioned(
                    left: 20,
                    right: 25,
                    child: FadeInImage.assetNetwork(
                      placeholder: Images.placeholder,
                      //height:cw/2,
                      width: cw / 2,
                      fit: BoxFit.cover,
                      image: productModel.image,
                      imageErrorBuilder: ((context, error, stackTrace) => Image(
                            image: AssetImage(Images.placeholder),
                            //height:cw/2,
                            width: cw / 2,
                            fit: BoxFit.cover,
                          )),
                    ),
                  ),


                ],
              ),
            ),

            const SizedBox(
              height: 8,
            ),

            ///------------------ category title price -----

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        productModel.category,
                        style: titilliumRegular,
                      ),
                      Text(
                        productModel.title,
                        style: titilliumBold.copyWith(
                            fontSize: Dimensions.fontSizeLarge,
                            overflow: TextOverflow.ellipsis),
                      ),
                      Text(
                        "\$ ${productModel.price}",
                        style: titilliumBold.copyWith(
                            fontSize: 18, color: ColorResources.amber),
                      ),
                    ],
                  ),
                ),

                ///---------------cart section-

                InkWell(
                  onTap: (){

                    CartModel cart = CartModel(
                        productModel, 1);

                    Provider.of<CartProvider>(
                        context,
                        listen: false)
                        .addToCart(cart);

                    ScaffoldMessenger.of(context)
                        .showSnackBar(snackBar(
                        "Add to cart successful!"));
                  },
                  child: Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey.shade300,
                    ),
                    child: const Icon(
                      Icons.shopping_cart_outlined,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
