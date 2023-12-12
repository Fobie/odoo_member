// import 'package:ai_ecom_f3/view_models/user_vm.dart';
import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as storage;

import '../models/category.dart';
import './routes.dart';
//import '../models/result_status.dart';

class ProductCategoryService {
  Future<List<Category>> getCategory() async {
    List<Category> categoryList = [];
    const secureStorage = storage.FlutterSecureStorage();
    var sessionId = await secureStorage.read(key: 'sessionId');
    Dio dio = Dio();
    var options = Options(
      headers: {"Content-Type": "application/json", 'Cookie': "$sessionId"},
    );

    //var cartbody = {"jsonrpc": "2.0", "params": {}};
    var body = {
      "jsonrpc": "2.0",
      "params": {}
      //"page": 0, "search": "", "ppg": 100
    };
    Response response =
        await dio.post(getCategoryApi, options: options, data: body);

    response.data["result"]["data"].forEach((data) {
      data["img_cookie"] = {"Cookie": sessionId!};
      Category category = Category.fromJson(data);
      categoryList.add(category);
    });
    return categoryList;
    // return CategoryData(categoryList: _categoryList);
  }
}
