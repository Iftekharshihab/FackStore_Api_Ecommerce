import 'package:fakestoreapi_e_commerce/provider/cart_provider.dart';
import 'package:fakestoreapi_e_commerce/provider/product_provider.dart';
import 'package:fakestoreapi_e_commerce/screen/cart/cart_screen.dart';
import 'package:fakestoreapi_e_commerce/screen/home/widget/product_widget.dart';
import 'package:fakestoreapi_e_commerce/utils/color_resources.dart';
import 'package:fakestoreapi_e_commerce/utils/dimensions.dart';
import 'package:fakestoreapi_e_commerce/utils/images.dart';
import 'package:fakestoreapi_e_commerce/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

final _searchController = TextEditingController();

class _HomeScreenState extends State<HomeScreen> {
  ScrollController _scrollController = ScrollController();

  _loadData(BuildContext context) {
    Provider.of<ProductProvider>(context, listen: false).getProductList();
  }

  @override
  Widget build(BuildContext context) {
    final ch = MediaQuery.of(context).size.height;
    final cw = MediaQuery.of(context).size.width;

    return Scaffold(
      backgroundColor: ColorResources.white,
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: ColorResources.white,
          onRefresh: () async {
            await _loadData(context);
          },
          child: Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  ///-------------------------App Bar---
                  SliverAppBar(
                    floating: true,
                    elevation: 0,
                    centerTitle: true,
                    automaticallyImplyLeading: false,
                    backgroundColor: ColorResources.white,
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 15),
                      child: Image.asset(Images.menus),
                    ),
                    title: Text(
                      "New Arrival",
                      style: titilliumBold.copyWith(
                          fontSize: Dimensions.fontSizeOverLarge,
                          color: ColorResources.black),
                    ),
                    actions: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: IconButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => CartScreen()));
                          },
                          icon: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              const Image(
                                image: AssetImage(Images.shopping_cart),
                                color: Colors.blue,
                                height: 25,
                                width: 25,
                              ),
                              Positioned(
                                  top: -4,
                                  right: -4,
                                  child: Consumer<CartProvider>(
                                    builder: (context, cart, child) {
                                      return CircleAvatar(
                                        radius: 8,
                                        backgroundColor: ColorResources.red,
                                        child: Container(
                                          alignment: Alignment.center,
                                          height: 30,
                                          width: 30,
                                          child: Text(
                                            cart.cartList.length.toString(),
                                            style: titilliumBold.copyWith(
                                                color: ColorResources.white),
                                          ),
                                        ),
                                      );
                                    },
                                  ))
                            ],
                          ),
                        ),
                      )
                    ],
                  ),

                  ///------------------------Search bar---
                  SliverPersistentHeader(
                      pinned: true,
                      delegate: SliverDelegate(
                          child: InkWell(
                        // onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => SearchScreen())),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: Dimensions.paddingSizeDefault,
                            vertical: Dimensions.paddingSizeSmall,
                          ),
                          color: ColorResources.white,
                          alignment: Alignment.center,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: Dimensions.paddingSizeSmall,
                                vertical: Dimensions.paddingSizeSmall),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.grey.shade300,
                            ),
                            alignment: Alignment.centerLeft,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.search,
                                  color: ColorResources.textColor,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  "Search Product.....",
                                  style: titilliumBold.copyWith(
                                    fontSize: 15,
                                    color: ColorResources.textColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ))),

                  ///------------------- Product section-------

                  SliverToBoxAdapter(
                    child: SizedBox(
                        height: ch - 160,
                        width: cw,
                        child: Consumer<ProductProvider>(
                          builder: (context, productProvider, child) {
                            return productProvider.productList != null
                                ? productProvider.productList.length > 0
                                    ? ListView.builder(
                                        itemCount:
                                            productProvider.productList.length,
                                        itemBuilder: (context, int index) {
                                          return ProductWidget(
                                            cw: cw,
                                            productModel: productProvider
                                                .productList[index],
                                            index: index,
                                          );
                                        })
                                    : const Center(
                                        child: CircularProgressIndicator(),
                                      )
                                : const Center(
                                    child: CircularProgressIndicator(),
                                  );
                          },
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class SliverDelegate extends SliverPersistentHeaderDelegate {
  Widget child;
  SliverDelegate({required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return child;
  }

  @override
  double get maxExtent => 70;

  @override
  double get minExtent => 70;

  @override
  bool shouldRebuild(SliverDelegate oldDelegate) {
    return oldDelegate.maxExtent != 70 ||
        oldDelegate.minExtent != 70 ||
        child != oldDelegate.child;
  }
}
