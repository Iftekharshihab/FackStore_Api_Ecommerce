import 'package:fakestoreapi_e_commerce/data/model/response/cart_model.dart';
import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_details_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/product_details/widget/product_images_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:fakestoreapi_e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  ProductDetails({Key? key, required this.productModel, required this.index})
      : super(key: key);

  final ProductModel productModel;
  int index;
  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final PageController controller = PageController();
  @override
  Widget build(BuildContext context) {
    final ch = MediaQuery.of(context).size.height;
    final cw = MediaQuery.of(context).size.width;
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.black,
        onPressed: () {
          CartModel cart = CartModel(widget.productModel, 1);
          var addToCart = Provider.of<CartProvider>(context,listen: false).addToCart(cart);
          ScaffoldMessenger.of(context).showSnackBar(snackBar("Add to cart successful!"));

        },
        child: const Icon(
          Icons.shopping_cart_outlined,
          color: Colors.white,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(10),
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            InkWell(
              child: widget.productModel.image != null
                  ? ProductImagesView(productModel: widget.productModel,
                index: widget.index,
              )
                  : SizedBox(),
            ),

            ///-----------title price category section--
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.productModel.category,
                          style: titilliumRegular,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Text(
                          widget.productModel.title,
                          style: titilliumBold.copyWith(
                              fontSize: Dimensions.fontSizeExtraLarge,
                              overflow: TextOverflow.ellipsis),
                        ),
                        Text(
                          "Select Size",
                          style: titilliumRegular.copyWith(height: 2),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    "\$ ${widget.productModel.price}",
                    style: titilliumBold.copyWith(
                        fontSize: 20, color: ColorResources.amber),
                  ),
                ],
              ),
            ),

            ///-----Size section-----

            Consumer<ProductDetailsProvider>(
                builder: (context, productDetails, child) {
              return productDetails.productSizeList != null
                  ? SizedBox(
                      height: 50,
                      width: cw,
                      child: ListView.builder(
                          itemCount: productDetails.productSizeList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, int index) {
                            return InkWell(
                              onTap: () {
                                productDetails.setProductSize(index);
                              },
                              child: Container(
                                alignment: Alignment.center,
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                height: 40,
                                width: 50,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    width: 1,
                                    color: ColorResources.black,
                                  ),
                                  color:
                                      productDetails.productSizeIndex == index
                                          ? Colors.grey
                                          : Colors.white,
                                ),
                                child: Text(
                                  productDetails.productSizeList[index]
                                      .toString(),
                                  style: titilliumBold.copyWith(
                                      color: productDetails.productSizeIndex ==
                                              index
                                          ? ColorResources.white
                                          : ColorResources.black),
                                ),
                              ),
                            );
                          }),
                    )
                  : SizedBox();
            }),

            ///----------Find section-----
            Container(
              margin: EdgeInsets.only(top: 20),
              height: 50,
              width: cw - 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey.shade300,
              ),
              child: Text(
                "Find in Store",
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeLarge),
              ),
            ),

            ///---------------description----
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 300,
              width: cw - 40,
              child: Text(
                widget.productModel.description,
                style: titilliumRegular.copyWith(
                    fontSize: Dimensions.fontSizeDefault),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///----------------indicator list ----

List<Widget> _indicators(BuildContext context) {
  List<Widget> indicators = [];
  for (int index = 0; index < 5; index++) {
    indicators.add(TabPageSelectorIndicator(
      backgroundColor: index ==
          Provider.of<ProductDetailsProvider>(context).imagesSliderIndex
          ? ColorResources.black
          : ColorResources.hintTextColor,
      borderColor: ColorResources.white,
      size: index ==
          Provider.of<ProductDetailsProvider>(context).imagesSliderIndex
          ? 15
          : 10,
    ));
  }
  return indicators;
}

