import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fod_delievery_app/providers/recommended_product_provider.dart';
import 'package:fod_delievery_app/repository/cart_repository.dart';
import 'package:fod_delievery_app/repository/repository.dart';
import 'package:get/get.dart';

import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';


import 'providers/cart_provider.dart';
import 'providers/product_provider.dart';
import 'utils/routes.dart';
import 'utils/routes_name.dart';
void main() {
 
 


  HttpOverrides.global =  MyHttpOverrides();
  runApp(const MyApp());
}
 class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

       

    return MultiProvider(
  providers: [
     ChangeNotifierProvider(create: (context) => PopularProductDataProvider()),
    ChangeNotifierProvider(create: (_) => RecommendedProductProvider()),
    ChangeNotifierProvider(create: (_) => CartProvider()),
    
  ],
  builder:((context, child) {
     Provider.of<CartProvider>(context).getCartData();
    
   
    return const GetMaterialApp( debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
    
     initialRoute: RouteName.splash_screen,
     onGenerateRoute: Routes.generateRoute,
     
      
    
      
    );
    
  })
   
);
    
  }
}

