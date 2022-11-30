

import 'package:flutter/material.dart';
import 'package:fod_delievery_app/providers/cart_provider.dart';

import 'package:fod_delievery_app/providers/product_provider.dart';
import 'package:fod_delievery_app/utils/app_constant.dart';
import 'package:fod_delievery_app/widgets/expandable_text_widget.dart';
import 'package:provider/provider.dart';

import '../../colors.dart';
import '../../dimensions.dart';
import '../../utils/routes_name.dart';
import '../../widgets/app_column.dart';
import '../../widgets/app_icon.dart';
import '../../widgets/bid_text.dart';



class PopularFoodDetail extends StatefulWidget {
  dynamic data;

   PopularFoodDetail({super.key, required this.data});

  @override
  State<PopularFoodDetail> createState() => _PopularFoodDetailState();
}

class _PopularFoodDetailState extends State<PopularFoodDetail> {
  @override
  void initState() {
    // TODO: implement initState
   
    super.initState();
  }
 
  @override
  Widget build(BuildContext context) {


     var popularProductProvider = context.read<PopularProductDataProvider>();
     var product = popularProductProvider.productss[widget.data["pageId"]];
     var page = widget.data["cartScreen"];
     var cart = context.read<CartProvider>();
     
     popularProductProvider.initProduct(product,cart);
   

    return Scaffold(
      backgroundColor: Colors.white,
      body:Stack(children: [
        Positioned(
          left:0,
          right:0,

          child:Container(
            height:Dimensions.popularImageSize,
            width:double.infinity,
            decoration: BoxDecoration(image:DecorationImage(
              fit: BoxFit.cover,
              image:NetworkImage(AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product.img))),
          

        )),
        Positioned(
          top:Dimensions.height45,
          left:Dimensions.width20,
          right:Dimensions.width20,
          child:Container(
          

          child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: (){
                  if(page=="cartScreen"){
                    
                 Navigator.pushNamed(context,RouteName.cart_screen );

                  }
                  else{
                    Navigator.pushNamed(context,RouteName.home_screen );

                  }

                },
                child: const AppIcon(icon: Icons.arrow_back_ios,)),
               Consumer<PopularProductDataProvider>(
                builder: (context, value, child) {
                 return   GestureDetector(
                   onTap: (() {
Navigator.pushNamed(context,RouteName.cart_screen );
                    }),
                   child: Stack(children: [
                    const AppIcon(icon: Icons.shopping_cart_outlined,),
                     popularProductProvider.totalItems>=1?const Positioned(
                      right:0,
                      top:0,
                      child: AppIcon(backgroundColor: AppColors.mainColor, icon: Icons.circle, size:20, icnColor: Colors.transparent,)):Container(),
                          
                     popularProductProvider.totalItems>=1?Positioned(
                      right:3,
                      top:3,
                      child: BigText(text: popularProductProvider.totalItems.toString(), size:11 , color: Colors.white,)):Container()
                 
                   ],),
                 );
                  
                },
               )

          ],)
        )),
// description 
        Positioned(
          top:Dimensions.popularImageSize-20,
          right:0,
          left:0,
          bottom:0,
          
          child:Container(
            padding:EdgeInsets.only(left:Dimensions.width20,
            right: Dimensions.width20,
            top:Dimensions.height20,
            
            ),
            decoration: BoxDecoration(
             color:Colors.white,
              borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.radius20),
            topLeft:Radius.circular(Dimensions.radius20)),

        ),
        child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppColumn(text: product.name),
            SizedBox(height:Dimensions.height20),
            BigText(text:"Introduce"),
            const SizedBox(height:20 ,),
            Expanded(child: SingleChildScrollView(child: ExpandableTextWidget(text:product.description )))
          ],
        )
        ),
        )


      ],)
    ,
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
            GestureDetector(
              onTap:(){
                popularProductProvider.setQuantity(false);
              },
            child:const Icon(Icons.remove,color:AppColors.signColor),
          ),
            SizedBox(width:Dimensions.width10/2),
            Consumer<PopularProductDataProvider>(builder: (context, value, child) => BigText(text: value.cartItems.toString())),
            SizedBox(width:Dimensions.width10/2),
            GestureDetector(
              onTap:(){
                popularProductProvider.setQuantity(true);
              },
              child: const Icon(Icons.add,color:AppColors.signColor)),
            

          ],)
      ),
       Container(
        padding:EdgeInsets.all(Dimensions.height20),
        decoration: BoxDecoration(
          color:AppColors.mainColor,
          borderRadius: BorderRadius.circular(Dimensions.radius20)),
          child:GestureDetector(
            onTap: (() {
              popularProductProvider.addItem(product);
            }),
            child: BigText(text:"\$ ${product.price}| Add to cart ", color:Colors.white))
      )

     ]),
    )
    );
  }
}

