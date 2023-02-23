
import 'package:fakestoreapi_e_commerce/data/model/response/product_model.dart';
import 'package:fakestoreapi_e_commerce/provider/product_details_provider.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductImagesView extends StatelessWidget {

  final ProductModel productModel;
  int index;
  ProductImagesView({
    Key? key,
    required this.productModel,
    required this.index
  }) : super(key: key);


  final PageController controller = PageController();

  @override
  Widget build(BuildContext context) {
    final cw = MediaQuery.of(context).size.width;

    return SafeArea(
      child: Container(
        height: cw + 30,
        width: cw - 40,
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.all(20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: index.isEven
              ? ColorResources.cart1Bg
              : ColorResources.cart2Bg,
          borderRadius: BorderRadius.circular(30),
        ),
        child: Column(
          children: [
            SizedBox(
              height: cw - 30,
              width: cw - 40,
              child: Stack(
                children: [
                  ///------routed container-
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
                        left: 60,
                        right: 60,
                        top: 10,
                        bottom: 60),
                    transform: Matrix4.translationValues(
                        0.33, 0.33, 0.33)
                      ..rotateZ(
                          (index.isEven ? -28 : 28) / 180),
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
                    right: 20,
                    top: 30,
                    child: SizedBox(
                        height: cw - 20,
                        child: productModel.image != null
                            ? PageView.builder(
                          controller: controller,
                          itemCount: 5,
                          itemBuilder: (context, index) {
                            return FadeInImage.assetNetwork(
                              placeholder:
                              Images.placeholder,
                              //height:cw/2,
                              width: cw / 2,
                              fit: BoxFit.cover,
                              image:
                              productModel.image,
                              imageErrorBuilder: ((context,
                                  error, stackTrace) =>
                                  Image(
                                    image:  const AssetImage(
                                        Images.placeholder),
                                    //height:cw/2,
                                    width: cw / 2,
                                    fit: BoxFit.cover,
                                  )),
                            );
                          },
                          onPageChanged: (index) {
                            Provider.of<ProductDetailsProvider>(context, listen: false).setImagesSliderSelectIndex(index);
                          },
                        )
                            : const SizedBox.shrink()),
                  ),

                  Positioned(
                    left: 0,
                    right: 0,
                    top: -15,
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            getPageBack(context);
                          },
                          icon: const Icon(
                            Icons.chevron_left,
                            size: 35,
                            color: ColorResources.lightSkyBlue,
                          ),
                        ),
                        Row(
                          mainAxisAlignment:
                          MainAxisAlignment.center,
                            children: _indicators(context),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset(
                            Images.heart,
                            color: ColorResources.lightSkyBlue,
                            height: 20,
                            width: 20,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 8,
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