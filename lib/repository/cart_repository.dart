import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/cart_model.dart';
import '../utils/app_constant.dart';

class CartRepo{


List<String> cart=[];

List<String> cartHistory= [];
void addToCartList(List<CartModel> cartList) async {

  SharedPreferences sp = await SharedPreferences.getInstance();
  sp.remove(AppConstant.CART_LIST);
  
  cart = [];
  //converts object(cartModel) into string because shared prefs stores only string 
   cartList.forEach((element) { 
    return cart.add(jsonEncode(element));


  });
    
  
// addToCartHistory(cart);
  sp.setStringList(AppConstant.CART_LIST, cart);

 
   

}
 Future<List<CartModel>> getCartList()  async  {
    SharedPreferences sp = await SharedPreferences.getInstance();
    
  List<String> carts=[];

  if(sp.containsKey(AppConstant.CART_LIST)){
    carts = sp.getStringList(AppConstant.CART_LIST)!;
  //  print("Carts Elements: " + carts.toString());
  }
   List<CartModel> cartList = [];
  carts.forEach((element) {
    
    
   return  cartList.add(CartModel.fromJson(jsonDecode(element)));
  });

  return cartList;

 }
 void addToCartHistory( ) async {
  SharedPreferences sp = await  SharedPreferences.getInstance();

  print("cart has ${cart.length}");
  
  for(int i = 0; i<cart.length; i++){
    print("History list${cart[i]}");
    print("after");
    cartHistory.add(cart[i]);
  }
  sp.setStringList(AppConstant.CART_HISTORY_LIST, cartHistory);
 }
}