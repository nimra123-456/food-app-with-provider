import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/providers/product_provider.dart';
import 'package:fod_delievery_app/providers/recommended_product_provider.dart';
import 'package:fod_delievery_app/utils/app_constant.dart';
import 'package:fod_delievery_app/widgets/bid_text.dart';
import 'package:fod_delievery_app/widgets/icon_text_widget.dart';
import 'package:fod_delievery_app/widgets/small_text.dart';


import 'package:provider/provider.dart';

import '../../dimensions.dart';
import '../../models/product_model.dart';
import '../../utils/routes_name.dart';
import '../../widgets/app_column.dart';



class FoodPageBody extends StatefulWidget {
  const FoodPageBody({super.key});

  @override
  State<FoodPageBody> createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
 
  double _currentPageValue = 0.0;
  final _scaleFactor = 0.8;
  final double _height = Dimensions.pageViewContainer;


  @override
  void initState(){
    super.initState();
    
     WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final data = Provider.of<PopularProductDataProvider>(context, listen:false);
   data.getPopularProductData();
   Provider.of<RecommendedProductProvider>(context, listen:false).getRecommenndedData();
  
     });

    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
   
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  PageController pageController = PageController(viewportFraction: 0.85);
  @override
  Widget build(BuildContext context) {
    var prod = context.read<PopularProductDataProvider>();
    var recomendProd = context.read<RecommendedProductProvider>();
  
    return Column(children: [
      //Slider section
    Consumer<PopularProductDataProvider>(builder: (context, value, child) {
       if (value.loading) {
            return const Center(
              child: CircularProgressIndicator(color:AppColors.mainColor),
            );
          }
          // If loading is false then this code will show the list of todo item
      final products1 = value.productss;
      return Container(
          height: Dimensions.pageView,
          // color:Colors.red,
          child: PageView.builder(
            controller: pageController,
            itemCount: products1.length,
            itemBuilder: (context, position) {
              return _buildItem(position, products1[position]);
            }));
          
    
    }),
    // ignore: avoid_print
       
       DotsIndicator(
        
        dotsCount: prod.productss.isNotEmpty?prod.productss.length:1,
      
        position: _currentPageValue,
        decorator: DotsDecorator(
          activeColor: AppColors.mainColor,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
// Recommended text
      SizedBox(
        height: Dimensions.height30,
      ),
      Container(
        margin: EdgeInsets.only(left: Dimensions.width20),
        child: Row(crossAxisAlignment: CrossAxisAlignment.end, children: [
          BigText(
            text: "Recommended",
          ),
          SizedBox(width: Dimensions.width10),
          Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: SmallText(text: ".")),
          SizedBox(width: Dimensions.width10),
          Container(
              margin: const EdgeInsets.only(bottom: 3),
              child: SmallText(text: "Food pairing"))
        ]),
      ),
      // List of images
      
     recomendProd.loading?const CircularProgressIndicator(color:AppColors.mainColor) :ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount:recomendProd.recommendedproductss.length,
          itemBuilder: ((context, index) {
           final  rProd= recomendProd.recommendedproductss;
            return GestureDetector(
              onTap:() => Navigator.pushNamed(context, RouteName.recommended_screen, arguments: {
                "index" : index
              }),
              child: Container(
                
                margin: EdgeInsets.only(
                    left: Dimensions.width20,
                    right: Dimensions.width20,
                    bottom: Dimensions.height10
                    ),
            
                child: Row(children: [
                  // image section
                  Container(
                    height: Dimensions.listViewImageSize,
                    width: Dimensions.listViewImageSize,
                    decoration: BoxDecoration(
                        color: Colors.white38,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius15),
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image:  NetworkImage(AppConstant.BASE_URL+AppConstant.UPLOAD_URL+rProd[index].img))),
                  ),
                  Expanded(child: Container( 
                    height:Dimensions.listViewTextContainer,
                    decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(topRight:Radius.circular(Dimensions.radius20) ,bottomRight: Radius.circular(Dimensions.radius20)),
                    
                  ),
                  child: Padding(padding: EdgeInsets.only(left:Dimensions.width10, right:Dimensions.width10),
                  child:Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      BigText(text:rProd[index].name),
                      SizedBox(height:Dimensions.height10),
                      SmallText(text: "With Chineses characteristics",),
                      SizedBox(height:Dimensions.height10),
                       Row(
                         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: const [
                          IconAndTextWidget(
                            icon: Icons.circle_sharp,
                            text: "normal",
                            iconColor: AppColors.iconColor1,
                          ),
                          IconAndTextWidget(
                            icon: Icons.location_on,
                            text: "1.7km",
                            iconColor: AppColors.mainColor,
                          ),
                          IconAndTextWidget(
                            icon: Icons.access_time_rounded,
                            text: "32min",
                            iconColor: AppColors.iconColor2,
                          ),
                        ],
                      )
                    ],
                  )
                  
                  ),),)
                ]),
              ),
            );
          }))
    ]);
  }

  
   
  


Widget _buildItem(int position, ProductModel product) {
   Matrix4 matrix = Matrix4.identity();
    if (position == _currentPageValue.floor()) {
      var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currentPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currentPageValue - position + 1) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currentPageValue.floor() - 1) {
      var currScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
      var currTrans = _height * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, (_height * (1 - currScale) / 2), 0);
    } 
    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          GestureDetector(
            onTap:() => Navigator.pushNamed(context, RouteName.popular_screen,arguments: {
              "pageId" : position
            }),
            child: Container(
              height: Dimensions.pageViewContainer,
              margin: EdgeInsets.only(
                  left: Dimensions.width10, right: Dimensions.width10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image:  DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage(AppConstant.BASE_URL+AppConstant.UPLOAD_URL+product.img))),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                height: Dimensions.pageViewTextContainer,
                margin: EdgeInsets.only(
                    left: Dimensions.width30,
                    right: Dimensions.width30,
                    bottom: Dimensions.height30),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                    boxShadow: const [
                      BoxShadow(
                          offset: Offset(0, 5),
                          color: Color(0xFFe8e8e8),
                          blurRadius: 5.0),
                      BoxShadow(offset: Offset(-5, 0), color: Colors.white),
                      BoxShadow(offset: Offset(5, 0), color: Colors.white)
                    ]),
                child: Container(
                    padding: EdgeInsets.only(
                        top: Dimensions.height15, left: 15, right: 15),
                    child: AppColumn(text: product.name))),
          ),
        ],
      ),
    );
}
}


