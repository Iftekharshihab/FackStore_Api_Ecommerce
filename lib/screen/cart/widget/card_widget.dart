
import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:fakestoreapi_e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CardWidget extends StatelessWidget {

  final CartModel cartModel;
  final int index;
  final bool fromCheckout;


   CardWidget({
    Key? key,
    required this.cartModel,
    required this.index,
    required this.fromCheckout,
  }) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(Dimensions.marginSizeSmall),
      padding: EdgeInsets.all(Dimensions.paddingSizeSmall),
      decoration: BoxDecoration(
          color: ColorResources.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: ColorResources.black.withOpacity(0.3),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ]
      ),
      child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(3),
              decoration: BoxDecoration(
                  color: ColorResources.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow:[
                    BoxShadow(
                        color: ColorResources.black.withOpacity(0.3),
                        spreadRadius: 1,
                        blurRadius: 3
                    ),
                  ]
              ),
              child: ClipRRect(
                borderRadius:
                BorderRadius.circular(10),
                child: FadeInImage.assetNetwork(
                  placeholder: Images.placeholder,
                  width: 65,
                  height: 65,
                  image: cartModel.productModel!.image,
                  imageErrorBuilder: ((context, error, stackTrace) => Image.asset(
                      Images.placeholder,
                      fit: BoxFit.cover,
                      height: 60,
                      width: 60
                  )
                  ),
                ),
              ),
            ),

            Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.paddingSizeExtraLarge,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(cartModel.productModel!.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: titilliumBold.copyWith(
                                fontSize: Dimensions.fontSizeDefault,
                                color: ColorResources.black,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),

                          ///------delete----
                          !fromCheckout
                              ? InkWell(
                            onTap: (){
                              Provider.of<CartProvider>(context,listen: false).removeFromCart(index);
                            },
                            child: Container(
                              width: 20,
                              height: 20,
                              child: Image.asset(
                                Images.delete,
                                scale: .5,
                              ),
                            ),
                          ): SizedBox.shrink(),

                        ],
                      ),

                      Row(
                        children: [

                          Text("\$ ${cartModel.productModel!.price-5}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titilliumBold.copyWith(
                              color: ColorResources.red,
                              decoration: TextDecoration.lineThrough,
                            ),
                          ),
                          const SizedBox(width: 5,),

                          Text("\$ ${cartModel.productModel!.price}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: titilliumBold.copyWith(
                              color: ColorResources.sellerTXT,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5,),

                       Row(
                      children: [
                        Expanded(child: Text(cartModel.productModel!.category, style: titilliumRegular.copyWith(
                          overflow: TextOverflow.ellipsis, ),)),


                        ///-----------Button------------
                        Padding(
                          padding:const EdgeInsets.only(
                              right: Dimensions.paddingSizeSmall),
                          child: QuantityButton(
                              isIncrement: false,
                              index: index,
                              quantity: cartModel.quantity,
                              maxQty: 20,
                              cartModel: cartModel,
                          ),
                        ),
                        Text(cartModel.quantity.toString(), style: titilliumBold),
                        Padding(
                          padding:const EdgeInsets.only(
                              left: Dimensions.paddingSizeSmall),
                          child: QuantityButton(
                              index: index,
                              isIncrement: true,
                              quantity: cartModel.quantity,
                              maxQty: 20,
                              cartModel: cartModel,
                          ),
                        ),

                      ],
                    ),
                    ],
                  ),
                )
            ),

          ]
      ),


    );
  }
}



///-------------quantity button-


class QuantityButton extends StatelessWidget {
  final CartModel cartModel;
  final bool isIncrement;
  final int quantity;
  final int index;
  final int maxQty;
  QuantityButton(
      {required this.isIncrement,
        required this.quantity,
        required this.index,
        required this.maxQty,
        required this.cartModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (!isIncrement && quantity > 1) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(false, index);
        } else if (isIncrement && quantity < maxQty) {
          Provider.of<CartProvider>(context, listen: false)
              .setQuantity(true, index);
        }
      },
      child: Icon(
        isIncrement ? Icons.add_circle : Icons.remove_circle,
        color: isIncrement
            ? quantity >= maxQty
            ? ColorResources.grey
            : ColorResources.lightSkyBlue
            : quantity > 1
            ? ColorResources.lightSkyBlue
            : ColorResources.grey,
        size: 30,
      ),
    );
  }
}
