import 'package:flutter/material.dart';

import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/providers/product_provider.dart';
import 'package:fod_delievery_app/providers/recommended_product_provider.dart';
import 'package:fod_delievery_app/utils/app_constant.dart';
import 'package:fod_delievery_app/widgets/app_icon.dart';
import 'package:fod_delievery_app/widgets/expandable_text_widget.dart';
import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../../providers/cart_provider.dart';
import '../../utils/routes_name.dart';
import '../../widgets/bid_text.dart';

class RecommendedFoodDetails extends StatelessWidget {
  dynamic data;
   RecommendedFoodDetails({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    var product = context.read<RecommendedProductProvider>().recommendedproductss[data['index']];
    var recomendPage = data[ "recomendCart"];
    var popularProductProvider = context.read<PopularProductDataProvider>();
     var cart = context.read<CartProvider>();
     popularProductProvider.initProduct(product,cart);
    return Scaffold(
      backgroundColor: Colors.white,
      body:CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            GestureDetector(
              onTap: (() {
                
             if(recomendPage=="cartScreen"){
                    
                 Navigator.pushNamed(context,RouteName.cart_screen );

                  }
                  else{
                    Navigator.pushNamed(context,RouteName.home_screen );

                  }
              }
              )
              ,child: AppIcon(icon: Icons.clear)),
            // AppIcon(icon: Icons.shopping_cart_outlined)
           Consumer<PopularProductDataProvider>(
                builder: (context, value, child) {
                 return   Stack(children: [
                  GestureDetector(
                    onTap:(() =>Navigator.pushNamed(context, RouteName.cart_screen) ),
                    child: AppIcon(icon: Icons.shopping_cart_outlined,)),
                   popularProductProvider.totalItems>=1?Positioned(
                    right:0,
                    top:0,
                    child: AppIcon(backgroundColor: AppColors.mainColor, icon: Icons.circle, size:20, icnColor: Colors.transparent,)):Container(),
                        
                   popularProductProvider.totalItems>=1?Positioned(
                    right:3,
                    top:3,
                    child: BigText(text: popularProductProvider.totalItems.toString(), size:11 , color: Colors.white,)):Container()

                 ],);
                  
                },
               )
          
          ]),
          bottom:PreferredSize(
            preferredSize: Size.fromHeight(30),
            child:Container(
              decoration:BoxDecoration(color:Colors.white,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radius20), topRight: Radius.circular(Dimensions.radius20))
              ),
              padding:EdgeInsets.only(top:5, bottom:10),
              
              width:double.infinity, 
              child: Center(child: BigText(text:product.name, size:Dimensions.font26))) ,),

          pinned:true,
          backgroundColor:AppColors.yellowColor ,

          expandedHeight: 260,
          flexibleSpace: FlexibleSpaceBar(background:Image.network(
          
            AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product.img,
            width:double.infinity,
            fit: BoxFit.cover,
            
            ) ),
        ),
        SliverToBoxAdapter(
          child:Column(children: [
            Container(
              margin:EdgeInsets.only(left:Dimensions.width20, right:Dimensions.width20 ),
              child:ExpandableTextWidget(text: product.description))
          ],)
        )
      ],)

,
bottomNavigationBar: Consumer<PopularProductDataProvider>(
  builder: (context, value, child) {
    return Column(
  
    mainAxisSize: MainAxisSize.min,
  
    children: [
  
    Container(
  
      padding: EdgeInsets.symmetric(vertical:Dimensions.height10),
  
      child: Row(
  
        mainAxisAlignment:MainAxisAlignment.center ,
  
        children: [
  
        GestureDetector(
          onTap: (() {
            popularProductProvider.setQuantity(false);
            
          }),
          child: AppIcon(icon: Icons.remove,iconSize:Dimensions.iconSize24 ,icnColor:Colors.white , backgroundColor:AppColors.mainColor)),
  
        SizedBox(width: Dimensions.width20,),
  
        BigText( text: "\$ ${product.price} X ${value.cartItems} ",color:AppColors.mainBlackColor, size:Dimensions.font26),
  
        SizedBox(width: Dimensions.width20,),
  
        GestureDetector(
          onTap: (() {
            popularProductProvider.setQuantity(true);
          }),
          child: AppIcon(icon: Icons.add,iconSize:Dimensions.iconSize24 ,icnColor:Colors.white , backgroundColor:AppColors.mainColor))
  
      
  
      ],),
  
    ),
  Container(
  
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
  
            child:Icon(Icons.favorite, color: AppColors.mainColor,)
  
        ),
  
         GestureDetector(
          onTap:() {
            value.addItem(product);
          },
           child: Container(
           
            padding:EdgeInsets.all(Dimensions.height20),
           
            decoration: BoxDecoration(
           
              color:AppColors.mainColor,
           
              borderRadius: BorderRadius.circular(Dimensions.radius20)),
           
              child:BigText(text:"\$ ${product.price} | Add to cart ", color:Colors.white)
           
                 ),
         )
  
  
  
       ]),
  
      )
  
  ]);
  },  
),
);
  }
}