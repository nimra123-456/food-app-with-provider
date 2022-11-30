import 'product_model.dart';

class CartModel{
  int? id;
  String? name;
  bool? isExist;
  int? quantity;
  int? price;
  String? image;
  String? time;
  ProductModel? product;
 
  CartModel({ this.isExist,this. product,  this.quantity,  this.time, this.price, this.id,  this.image,  this.name, });

 factory CartModel.fromJson(Map<String, dynamic> json ){
  return CartModel(id: json["id"] ,
        name: json["name"],
        isExist: json["isExist"],
        price: json["price"],
        time:json["time"],
        image: json["img"],
        quantity: json["quantity"],
        product: ProductModel.fromJson(json["product"])
       
    );
 }
 // Next, we will create a toJson() method
 // Note: If the jsonEncode() function is called without creating a toJson() method, an error will be thrown
 Map<String,dynamic> toJson(){
  return {
  "id"  :this.id,
  "name":this.name,
  "isExist":this.isExist,
  "price":this.price ,
  "time":this.time,
  "image":this.image,
  "quantity":this.quantity ,
  "product":this.product!.toJson(),

  };
 }
}
