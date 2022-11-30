import 'package:flutter/material.dart';

import 'package:fod_delievery_app/providers/product_provider.dart';

import 'package:fod_delievery_app/widgets/app_icon.dart';
import 'package:fod_delievery_app/widgets/bid_text.dart';
import 'package:fod_delievery_app/widgets/small_text.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../dimensions.dart';
import '../../providers/cart_provider.dart';
import '../../providers/recommended_product_provider.dart';
import '../../utils/app_constant.dart';
import '../../utils/routes_name.dart';

class Cartpage extends StatelessWidget {
  const Cartpage({super.key});
  // var cartProvider;
  // var cartList;

  @override
  Widget build(BuildContext context) {
    var popularProdProvider = context.read<PopularProductDataProvider>();
    var cartProvider = context.read<CartProvider>();
    

    // PopularProdProvider.initProduct(product,cart);

    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: Dimensions.height20 * 3,
          left: Dimensions.width20,
          right: Dimensions.width20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            AppIcon(
              icon: Icons.arrow_back_ios,
              icnColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              iconSize: Dimensions.iconSize24,
            ),
            SizedBox(width: Dimensions.width20 * 5),
            GestureDetector(
              onTap: (() {
                Navigator.pushNamed(context, RouteName.home_screen);
              }),
              child: AppIcon(
                icon: Icons.home_outlined,
                icnColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                iconSize: Dimensions.iconSize24,
              ),
            ),
            AppIcon(
              icon: Icons.shopping_cart,
              icnColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              iconSize: Dimensions.iconSize24,
            )
          ]),
        ),
        Positioned(
          top: Dimensions.height20 * 5,
          right: Dimensions.width20,
          left: Dimensions.width20,
          bottom: 0,
          child: Container(
              margin: EdgeInsets.only(top: Dimensions.height10),
              child: MediaQuery.removePadding(
                context: context,
                removeTop: true,
                child:
                    Consumer<CartProvider>(builder: ((context, value, child) {
                  return ListView.builder(
                      itemCount: cartProvider.getItems.length,
                      itemBuilder: ((context, index) {
                        return Container(
                            height: Dimensions.height20 * 5,
                            width: double.maxFinite,
                            child: Row(
                              children: [
                                GestureDetector(
                                  onTap: (() {
                                    var popularIndex = popularProdProvider // it is not giving corect index sometimes it gives index in minus
                                        .productss
                                        .indexOf(cartProvider
                                            .getItems[index].product!);
                                    if (popularIndex >= 0) {
                                      Navigator.pushNamed(
                                          context, RouteName.popular_screen,
                                          arguments: {"pageId": popularIndex,
                                                       "cartScreen": "cartScreen"
                                          });
                                    } else {
                                      var recommendedIndex = context
                                          .read<RecommendedProductProvider>()
                                          .recommendedproductss
                                          .indexOf(cartProvider
                                              .getItems[index].product!);
                                      Navigator.pushNamed(
                                          context, RouteName.recommended_screen,
                                          arguments: {
                                            "index": recommendedIndex,
                                               "recomendCart": "cartScreen"

                                          });
                                    }
                                  }),
                                  child: Container(
                                      margin: EdgeInsets.only(
                                          bottom: Dimensions.height10),
                                      width: Dimensions.width20 * 5,
                                      height: Dimensions.height20 * 5,
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                            fit: BoxFit.cover,
                                            image: NetworkImage(
                                                AppConstant.BASE_URL +
                                                    AppConstant.UPLOAD_URL +
                                                    cartProvider.getItems[index].product!// product should not be used it shoud work without product because cart model has image property but for now i used because it"s not working.
                                                        .img)),
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: Colors.white,
                                      )),
                                ),
                                SizedBox(width: Dimensions.width10),
                                Expanded(
                                  child: Container(
                                      height: Dimensions.height20 * 5,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          BigText(
                                              text: cartProvider
                                                  .getItems[index].name!,
                                              color: Colors.black54),
                                          SmallText(text: "Spicy"),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              BigText(
                                                  text: cartProvider
                                                      .getItems[index].price
                                                      .toString(),
                                                  color: Colors.redAccent),
                                              Container(
                                                  padding: EdgeInsets.all(
                                                      Dimensions.height10),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              Dimensions
                                                                  .radius20)),
                                                  child: Row(
                                                    children: [
                                                      GestureDetector(
                                                        onTap: () {
                                                          cartProvider.addItem(
                                                              cartProvider
                                                                  .getItems[
                                                                      index]
                                                                  .product!,
                                                              -1);
                                                        },
                                                        child: const Icon(
                                                            Icons.remove,
                                                            color: AppColors
                                                                .signColor),
                                                      ),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      BigText(
                                                          text: value
                                                              .getItems[index]
                                                              .quantity
                                                              .toString()),
                                                      SizedBox(
                                                          width: Dimensions
                                                                  .width10 /
                                                              2),
                                                      GestureDetector(
                                                          onTap: () {
                                                            var cartList =
                                                                cartProvider
                                                                    .getItems;
                                                            cartProvider.addItem(
                                                                cartList[index]
                                                                    .product!,
                                                                1);
                                                          },
                                                          child: const Icon(Icons.add,
                                                              color: AppColors
                                                                  .signColor)),
                                                    ],
                                                  )),
                                            ],
                                          )
                                        ],
                                      )),
                                )
                              ],
                            ));
                      }));
                })),
              )),
        )
      ],
    ),
    bottomNavigationBar: Container(
      height:Dimensions.bottomHeightBar,
      padding:EdgeInsets.only(top:Dimensions.height30, right:Dimensions.width20,left: Dimensions.width20,bottom:Dimensions.height20),
      decoration: BoxDecoration(
        color:AppColors.buttonBackgroundColor,
        borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.radius20*2),topLeft:Radius.circular(Dimensions.radius20*2))),

     child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
      Container(
        padding:EdgeInsets.all(Dimensions.height20),
        decoration: BoxDecoration(
          color:Colors.white,
          borderRadius: BorderRadius.circular(Dimensions.radius20)),
          child:Row(children: [
         
            SizedBox(width:Dimensions.width10/2),
            Consumer<CartProvider>(builder: (context, value, child) => BigText(text: "\$ ${value.totalAmount.toString()}")),
            SizedBox(width:Dimensions.width10/2),
            
            

          ],)
      ),
       Container(
        padding:EdgeInsets.all(Dimensions.height20),
        decoration: BoxDecoration(
          color:AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20)),
          child:GestureDetector(
            onTap: (() {
              print("tapped");
           cartProvider.addToHistory();
            }),
            child: BigText(text:"Check Out ", color:Colors.white))
      )

     ]),
    )
    );
  }
}
