import 'package:flutter/material.dart';

import '../models/category.dart';
import '../services/category_service.dart';

class HomeScreenVM extends ChangeNotifier {
  List<Category> get categoryList => _categoryList;
  List<Category> _categoryList = [];

  getCategory() async {
    _categoryList = await ProductCategoryService().getCategory();
  }
}
