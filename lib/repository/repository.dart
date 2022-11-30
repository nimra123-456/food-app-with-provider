import 'dart:convert';

import 'package:fod_delievery_app/utils/app_constant.dart';

import '../models/product_model.dart';
import 'package:http/http.dart' as http;


class Repository{


 
  Future<List<ProductModel>> getPopularProductData() async {
  Product result;
  var item; 
  
  
    final response = await http.get(
      // 
      // "http://mvs.bslmeiyu.com/api/v1/products/popular"
      Uri.parse(AppConstant.BASE_URL+ AppConstant.POPULAR_PRODUCT_URI));
      // 
    if (response.statusCode == 200) {
      
       item = jsonDecode(response.body);
     
     
    } else {
     print(response.statusCode);
    }
   return  Product.fromJson(item).products;
}
Future<List<ProductModel>> getRecommendedData() async {
  Product result;
  var item; 
  
    final response = await http.get(
      //"http://mvs.bslmeiyu.com/api/v1/products/recommended"
      
      Uri.parse( AppConstant.BASE_URL+ AppConstant.RECOMMENDED_PRODUCT_URI));
    if (response.statusCode == 200) {
      
       item = jsonDecode(response.body);
     
    } else {
    
    }
   return  Product.fromJson(item).products;
}



}