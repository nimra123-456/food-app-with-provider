import 'package:flutter/material.dart';

import 'package:fod_delievery_app/colors.dart';
import 'package:fod_delievery_app/providers/cart_provider.dart';
import 'package:fod_delievery_app/repository/repository.dart';
import 'package:get/get.dart';

import '../models/cart_model.dart';
import '../models/product_model.dart';


class PopularProductDataProvider extends ChangeNotifier {
   int _quantity= 0;
       int _cartItems= 0;
   int  get  quantity => _quantity;
      int  get  cartItems =>_cartItems+ _quantity;
  Repository repository = Repository();
  late CartProvider _cart;
  
  
  bool loading = false;
  List<ProductModel> productss= [];

  Future<void> getPopularProductData() async {
    loading = true;
    notifyListeners();
     final response=  await repository.getPopularProductData();
     productss = response;
  
    loading = false;

    notifyListeners();
 
  }

   void setQuantity(bool isIncrement){
    if(isIncrement){
      _quantity = checkQuantity(_quantity +1);
      notifyListeners();
      
    }else {
      _quantity = checkQuantity(_quantity-1);
      notifyListeners();
    }
  }
   int checkQuantity(int quantity){
    if((_cartItems+quantity)<0){
          Get.snackbar("Item Count", "You cant reduce more", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      if(_cartItems>0){
        _quantity = -_cartItems;
        return _quantity;
      }
      
      return 0;

    }else if((cartItems+ quantity)>20){
       Get.snackbar("Item Count", "You cant add more", backgroundColor: AppColors.mainColor, colorText: Colors.white);
      return 20;
    }
    else {
      return quantity;
    }
   }
  void initProduct(  ProductModel product ,CartProvider cart){
    _quantity = 0;
    _cartItems = 0;
    _cart = cart;
    bool exist = false;
    exist = _cart.existInCart(product);
 
    if(exist){
      _cartItems = _cart.getQuantity(product);

    }
   }
   void addItem(ProductModel product){
    // if(_quantity>0 ){
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _cartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) { 
     
      });
      notifyListeners();
    
    
   }
   int get totalItems{
    return _cart.totalItems;
   }
   List<CartModel> get getItems {
    return _cart.getItems;
   }


}