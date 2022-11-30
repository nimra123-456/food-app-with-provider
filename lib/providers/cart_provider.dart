import 'package:flutter/material.dart';
import 'package:fod_delievery_app/repository/cart_repository.dart';

import 'package:get/get.dart';


import '../colors.dart';
import '../models/cart_model.dart';
import '../models/product_model.dart';



class CartProvider extends ChangeNotifier {
   final Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;
  List<CartModel> storageItems= [];
    // use forEach(key, value) loop to print items
    
  void addItem(ProductModel product, int quantity){
            var totalQuantity = 0;
    if(_items.containsKey(product.id)){

      _items.update(product.id, (value) {
          totalQuantity = value.quantity! + quantity;
        
        return CartModel(id: value.id,image:value.image,name:value.name, isExist:true,price: value.price,quantity:
       value.quantity!+ quantity,time:  DateTime.now().toString(),
       product:product,
       
       );

      });
       if(totalQuantity<= 0){
    _items.remove(product.id);
   }
    }
  
    else{
      if(quantity>0){
      
     _items.putIfAbsent(product.id, () {
      
   
     
      return CartModel(id: product.id,image:product.img,name: product.name, isExist:true,price: product.price,quantity:
       quantity,time:  DateTime.now().toString(),
       product:product,
       
       );
    });

     } 
    
    
     else {
       Get.snackbar("Item Count", "You Should atleast add 1 Item in cart",
         backgroundColor: AppColors.mainColor, colorText: Colors.white);
     }

    
  
   
  }
    
    CartRepo().addToCartList(getItems);
    print(getItems);
    notifyListeners();
   
  }
  
  
   
bool existInCart(ProductModel product ){
  if(_items.containsKey(product.id)){
    return true;
  }
  else {
    return false;
  }
}

 int getQuantity(ProductModel product){
  int quantity = 0;
  if(_items.containsKey(product.id)){
    _items.forEach((key, value) {
      if(key== product.id){
        quantity = value.quantity!;
       
      }
     });
  }
  return quantity;
 }

int get totalItems{
  var totalQuantity = 0;
  _items.forEach((key, value) {
    totalQuantity += value.quantity!;
  });
return totalQuantity;
}
 

List<CartModel> get getItems{


  return _items.entries.map((e) {

    return e.value;
  }).toList();

}

int get totalAmount{
  var total = 0;
  _items.forEach((key, value) {
    total += value.quantity!*value.price!;
  });
return total;
}
Future<List<CartModel>> getCartData() async {

  setCart = await  CartRepo().getCartList();
  return storageItems;

}
 set setCart(List<CartModel> items){
  storageItems= items;
  print("Length of cart items are "+ storageItems.length.toString());

  for(int i=0; i<storageItems.length; i++){
    _items.putIfAbsent(storageItems[i].product!.id, () => storageItems[i]);
  }


 
 }
  void addToHistory(){
    print("function called");
    CartRepo().addToCartHistory();
  }
}