import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:shopmobile/data/category_repo.dart';
import 'package:shopmobile/di.dart';
import 'package:shopmobile/dio_exception.dart';
import 'package:shopmobile/models/categoreysModel.dart';
import 'package:shopmobile/models/subCategoryModel.dart';
import 'package:shopmobile/utils/appConfig.dart';

class CategoryProvider extends ChangeNotifier {
  bool cateInit = true;
  List<Category> category = [];
  List<Sub> subCategory = [];
  String title = "";

  // Get Category
  void getCategoriesProvider() async {
    try {
      Categories res = await sl<CategoryRepo>().getCategoreisData();
      category = res.data!.category!;
      cateInit = false;
      notifyListeners();
    } on DioError catch (e) {
      cateInit = true;
      notifyListeners();
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }

  // Get Sub Category
  void getSubCategoriesProvider({int? id}) async {
    try {
      subCategory.clear();
      notifyListeners();
      category.forEach(
        (element) {
          element.id == id ? title = element.name! : "";
        },
      );
      notifyListeners();
      CategoriesDetails res =
          await sl<CategoryRepo>().getSubCategoreisData(id: id);

      subCategory = res.data!.sub!;
      cateInit = false;
      notifyListeners();
    } on DioError catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      AppConfig.showSnakBar("$errorMessage");
    }
  }
}
