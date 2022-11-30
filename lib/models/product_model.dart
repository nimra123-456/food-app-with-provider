
class Product{
  int totalSize, offset,typeId;
  List<ProductModel> products;
  List<ProductModel> get  product => products ;

  Product({required this.offset, required this.products, required this.totalSize, required this.typeId});
  factory Product.fromJson(Map<String, dynamic> map){
    return Product(offset:map["offset"],totalSize: map["total_size"],typeId: map["type_id"],products:List<ProductModel>.from(map["products"].map((e)=>ProductModel.fromJson(e))));

  }
}


class ProductModel{
   int id;
    String name;
    String description;
    int price;
    int stars;
    String img;
    String location;
    DateTime createdAt;
    DateTime updatedAt;
    int typeId;
  ProductModel({required this.createdAt,required this.location,required this.price, required this.description,required this.id, required this.img, required this.name, required this.stars, required this.typeId, required this.updatedAt});

 factory ProductModel.fromJson(Map<String, dynamic> json ){
  return ProductModel(
   id: json["id"],
        name: json["name"],
        description: json["description"],
        price: json["price"],
        stars: json["stars"],
        img: json["img"],
        location: json["location"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        typeId: json["type_id"],
    );
  
 }

 Map<String,dynamic> toJson(){
  return {
 "id": id,
        "name": name,
        "description": description,
        "price": price,
        "stars": stars,
        "img": img,
        "location": location,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "type_id": typeId,
    };
}

  
 }
