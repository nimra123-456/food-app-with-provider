import 'package:flutter/material.dart';


import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/pages/home/food_page_body.dart';
import 'package:fod_delievery_app/widgets/bid_text.dart';
import 'package:fod_delievery_app/widgets/small_text.dart';

import '../../dimensions.dart';



class MainFoodPage extends StatefulWidget {
  const MainFoodPage({super.key});

  @override
  State<MainFoodPage> createState() => _MainFoodPageState();
}

class _MainFoodPageState extends State<MainFoodPage> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body:Column(children: [
        Container(
          child: Container(
          padding: EdgeInsets.only(left:Dimensions.width20,right:Dimensions.width20),
          margin:  EdgeInsets.only(top:Dimensions.height45,bottom:Dimensions.height15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
            Column(children: [
              BigText(text: "Pakistan", color: AppColors.mainColor),
              Row(
                children: [
                  SmallText(text: "Lahore",color:Colors.black),
                  const Icon(Icons.arrow_drop_down_rounded)

                ],
              )
            ],),
            Container( height:Dimensions.height45,
            width:Dimensions.height45,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radius15),
              color:AppColors.mainColor ,),
              child: Icon(Icons.search,color: Colors.white,size:Dimensions.iconSize24)
            )

          ]),
        ),),
         const Expanded(child: SingleChildScrollView(child: FoodPageBody()))
      ],)
    );
  }
}