import 'package:flutter/material.dart';
import 'package:fod_delievery_app/repository/repository.dart';

import '../models/product_model.dart';

class RecommendedProductProvider extends ChangeNotifier {
  Repository repository = Repository();
  
  
  bool loading = false;
  List<ProductModel> recommendedproductss= [];

  Future<void> getRecommenndedData() async {
    loading = true;
    notifyListeners();
     final response=  await repository.getRecommendedData();
     recommendedproductss = response;
 
    loading = false;

    notifyListeners();
 
  }
}