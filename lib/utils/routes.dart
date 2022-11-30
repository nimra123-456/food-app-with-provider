import 'package:flutter/material.dart';
import 'package:fod_delievery_app/pages/cart/cart_page.dart';


import 'package:fod_delievery_app/pages/splash/splash_page.dart';
import '../pages/food/popular_food.dart';
import '../pages/food/recommended_food_detail.dart';
import '../pages/home/home_page.dart';
import"./routes_name.dart";


class Routes{
  static Route<dynamic> generateRoute (RouteSettings settings){
    switch(settings.name){
      case  RouteName.splash_screen :
         return MaterialPageRoute(builder: ((context) => const SplashScreen()));
      case  RouteName.home_screen :
         return MaterialPageRoute(builder: ((context) => const HomePage()));
         case  RouteName.recommended_screen :
         return MaterialPageRoute(builder: ((context) => RecommendedFoodDetails(data:settings.arguments as Map)));
          case  RouteName.popular_screen :
         return MaterialPageRoute(builder: ((context) => PopularFoodDetail(data: settings.arguments as Map,)));
         case  RouteName.cart_screen :
         return MaterialPageRoute(builder: ((context) => const Cartpage()));
         
         //
         //
         
         default:
         return MaterialPageRoute(builder: ((context) {
           return const Scaffold(
            body:Center(child: Text("No Route Defined"))
           );
         }));

    }

  }
}